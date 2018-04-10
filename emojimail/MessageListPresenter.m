//
//  MessageListPresenter.m
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import "MessageListPresenter.h"

@implementation MessageListPresenter

#pragma mark - MessageListViewEventHandler

- (void)updateTableView {
    [self.input getEmails];
}

#pragma mark - MessageListInteractorOutput

- (void)gotEmails:(NSArray<GTLRGmail_Message *> *)emails {
    NSLog(@"GOT EMAILS");
}

@end
