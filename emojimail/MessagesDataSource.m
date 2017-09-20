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

@property (nonatomic, strong) GTLRGmailService *service;

@property (nonatomic) NSMutableArray <GTLRGmail_Message *> *messages;

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


- (void)requestForMessagesList {
    // Get the mail list with no content
    GTLRGmailQuery_UsersMessagesList *query = [GTLRGmailQuery_UsersMessagesList queryWithUserId:@"me"];
    query.includeSpamTrash = NO;
    query.maxResults = 10;
    query.pageToken = 0;
    query.labelIds = nil;
    //query.q = @"rfc822msgid: is:unread";
    
    [self.service executeQuery:query
                      delegate:self
             didFinishSelector:@selector(mailListRequestOnCompletion:finishedWithObject:error:)];
}


- (void)mailListRequestOnCompletion:(GTLRServiceTicket *)ticket
                 finishedWithObject:(GTLRGmail_ListMessagesResponse *)messagesResponse
                              error:(NSError *)error {
    if (error) {
        NSLog(@"[MessagesDataSource] failed to get the message list");
    } else {
        [self.messages addObjectsFromArray:messagesResponse.messages];
        [self.delegate refresh];
    }
    
    // Get message deails for every message
    for (GTLRGmail_Message *message in self.messages) {
        GTLRGmailQuery_UsersMessagesGet *query = [GTLRGmailQuery_UsersMessagesGet queryWithUserId:@"me" identifier:message.identifier];
        
        [self.service executeQuery:query completionHandler:^(GTLRServiceTicket * _Nonnull callbackTicket, GTLRGmail_Message * _Nullable newMessage, NSError * _Nullable callbackError) {
            if (error) {
                NSLog(@"[MessagesDataSource] failed to get message with id %@", message.identifier);
            } else {
                NSInteger index = [self.messages indexOfObject:message];
                self.messages[index] = newMessage;
                if (index == self.messages.count - 1) {
                    [self.delegate refresh];
                }
            }
        }];
    }
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
    
    [cell render:self.messages[indexPath.row]];
    
    return cell;
}


@end
