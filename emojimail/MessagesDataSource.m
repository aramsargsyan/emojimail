//
//  MessagesDataSource.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/18/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "MessagesDataSource.h"
#import "GoogleSignInManager.h"
#import <GTLRGmail.h>
#import "MessageTableViewCell.h"


@interface MessagesDataSource ()

@property (nonatomic) GTLRGmailService *service;

@property (nonatomic) BOOL requestInProcess;

@property (nonatomic) NSMutableArray <GTLRGmail_Message *> *messages;

@property (nonatomic) NSString *nextPageToken;

@end


@implementation MessagesDataSource


#pragma mark - Lifecycle


- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialize the service object.
        self.service = [[GTLRGmailService alloc] init];
        self.service.authorizer = [GoogleSignInManager sharedInstance].user.authentication.fetcherAuthorizer;
        
        self.messages = [NSMutableArray array];
        
        [self requestForMessagesList];
    }
    return self;
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
        NSLog(@"[MessagesDataSource] failed to get the message list");
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
                    NSLog(@"[MessagesDataSource] failed to get details for message with id %@", message.identifier);
                } else {
                    NSInteger mainIndex = [self.messages indexOfObject:message];
                    self.messages[mainIndex] = newMessage;
                    if ([self areStatusesEntirelyPositive:statusArray]) {
                        [self.delegate refresh];
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


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageTableViewCell defaultReuseIdentifier] forIndexPath:indexPath];
    
    // Request for the next page when the user reaches last 10 messages
    if (indexPath.row == self.messages.count - 10) {
        [self requestForMessagesList];
    }
    
    [cell render:self.messages[indexPath.row]];
    
    return cell;
}


@end
