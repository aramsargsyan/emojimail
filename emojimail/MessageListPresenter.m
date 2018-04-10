//
//  MessageListPresenter.m
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import "MessageListPresenter.h"
#import "MessageItem.h"
#import <GTLRGmail.h>

/*imported just for the category*/
#import "MessageListInteractor.h"


@interface MessageListPresenter ()

@property NSArray<MessageItem *> *messageItems;

@end


@implementation MessageListPresenter

#pragma mark - MessageListViewEventHandler

- (void)updateTableView {
    [self.input getEmails];
}

#pragma mark - MessageListInteractorOutput

- (void)gotEmails:(NSArray<GTLRGmail_Message *> *)emails {
    NSLog(@"GOT EMAILS");
    
    self.messageItems = [self messageItemsFromGmailMessageObjects:emails];
    
}

#pragma mark - Private

- (NSArray<MessageItem *> *)messageItemsFromGmailMessageObjects:(NSArray<GTLRGmail_Message *> *)messages {
    NSMutableArray *messageItems = [NSMutableArray array];
    
    for (GTLRGmail_Message *message in messages) {
        [messageItems addObject:[self messageItemFromGmailMessageObject:message]];
    }
    
    return messageItems;
}

- (MessageItem *)messageItemFromGmailMessageObject:(GTLRGmail_Message *)message {
    MessageItem *messageItem = [[MessageItem alloc] init];
    
    for (GTLRGmail_MessagePartHeader *header in message.payload.headers) {
        if ([header.name isEqualToString:@"From"]) {
            messageItem.from = header.value;
        } else if ([header.name isEqualToString:@"Subject"]) {
            messageItem.subject = header.value;
        }
    }
    
    messageItem.snippet = message.snippet;
    
    messageItem.dateString = [self dateStringFromTimestamp:message.internalDate.doubleValue];
    
    if (message.emojiString) {
        messageItem.emojiString = message.emojiString;
    } else {
        messageItem.emojiString = @"😐";
    }
    
    return messageItem;
}

- (NSString *)dateStringFromTimestamp:(double)timestamp {
    // The timestamp of GTLRGmail_Message provided by Google is in milliseconds
    timestamp /= 1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Show time for today's messages, show date for older messages
    BOOL isDateFromToday = [[NSCalendar currentCalendar] isDateInToday:date];
    if (isDateFromToday) {
        [dateFormatter setDateFormat:@"HH:mm"];
    } else {
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    }
    
    return [dateFormatter stringFromDate:date];
}

@end
