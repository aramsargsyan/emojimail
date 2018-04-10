//
//  MessageListInteractor.m
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import "MessageListInteractor.h"
#import "GoogleSignInManager.h"
#import "SentimentPolarityManager.h"
#import "objc/runtime.h"


@interface MessageListInteractor ()

@property (nonatomic) GTLRGmailService *service;

@property (nonatomic) BOOL requestInProcess;

@property (nonatomic) NSMutableArray <GTLRGmail_Message *> *messages;

@property (nonatomic) NSString *nextPageToken;

@end


@implementation MessageListInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialize the service object.
        self.service = [[GTLRGmailService alloc] init];
        self.messages = [NSMutableArray array];
    }
    return self;
}

- (void)getEmails {
    self.service.authorizer = [GoogleSignInManager sharedManager].user.authentication.fetcherAuthorizer;
    [self requestForMessagesList];
}

#pragma mark - Requests handling

- (void)requestForMessagesList {
    self.requestInProcess = YES;
    
    // Get the mail list with no content
    GTLRGmailQuery_UsersMessagesList *query = [GTLRGmailQuery_UsersMessagesList queryWithUserId:@"me"];
    
    //query.q = @"rfc822msgid: is:unread";
    
    if (self.nextPageToken) {
        query.pageToken = self.nextPageToken;
    }
    
    [self.service executeQuery:query
                      delegate:self
             didFinishSelector:@selector(mailListRequestOnCompletion:finishedWithObject:error:)];
}

- (void)mailListRequestOnCompletion:(GTLRServiceTicket *)ticket
                 finishedWithObject:(GTLRGmail_ListMessagesResponse *)messagesResponse
                              error:(NSError *)error {
    self.requestInProcess = NO;
    if (error) {
        NSLog(@"[%@] failed to get the message list", NSStringFromClass(self.class));
    } else {
        [self.messages addObjectsFromArray:messagesResponse.messages];
        self.nextPageToken = messagesResponse.nextPageToken;
        
        NSMutableArray <NSNumber *> *statusArray = [NSMutableArray array];
        for (NSInteger index = 0; index < messagesResponse.messages.count; index++) {
            [statusArray addObject:[NSNumber numberWithBool:NO]];
        }
        
        // Get message deails for every message
        for (NSInteger index = 0; index < messagesResponse.messages.count; index++) {
            
            GTLRGmail_Message *message = messagesResponse.messages[index];
            
            GTLRGmailQuery_UsersMessagesGet *query = [GTLRGmailQuery_UsersMessagesGet queryWithUserId:@"me" identifier:message.identifier];
            
            [self.service executeQuery:query completionHandler:^(GTLRServiceTicket * _Nonnull callbackTicket, GTLRGmail_Message * _Nullable newMessage, NSError * _Nullable callbackError) {
                
                statusArray[index] = [NSNumber numberWithBool:YES];
                
                if (error) {
                    NSLog(@"[%@] failed to get details for message with id %@", NSStringFromClass(self.class), message.identifier);
                } else {
                    NSString *subject;
                    for (GTLRGmail_MessagePartHeader *header in newMessage.payload.headers) {
                        if ([header.name isEqualToString:@"Subject"]) {
                            subject = header.value;
                        }
                    }
                    newMessage.emojiString = [[SentimentPolarityManager sharedManager] sentimentEmojiForText:subject];
                    
                    NSInteger mainIndex = [self.messages indexOfObject:message];
                    self.messages[mainIndex] = newMessage;
                    if ([self areStatusesEntirelyPositive:statusArray]) {
                        [self.output gotEmails:self.messages];
                    }
                }
            }];
        }
    }
    
}

#pragma mark - Utility methods

- (BOOL)areStatusesEntirelyPositive:(NSArray <NSNumber *> *)statusArray {
    for (NSNumber *number in statusArray) {
        if (number.boolValue == NO) {
            return NO;
        }
    }
    return YES;
}

@end


@implementation GTLRGmail_Message (MessageListInteractor)

- (void)setEmojiString:(NSString *)emojiString
{
    objc_setAssociatedObject(self, @selector(emojiString), emojiString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSString *)emojiString
{
    return objc_getAssociatedObject(self, @selector(emojiString));
}

@end
