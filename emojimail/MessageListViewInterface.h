//
//  MessageListViewInterface.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/12/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageItem;

@protocol MessageListViewInterface <NSObject>

- (void)showMessageList:(NSArray <MessageItem *> *)messageItems;

@end
