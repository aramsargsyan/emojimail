//
//  MessageListViewController.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/19/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListViewEventHandler.h"

@interface MessageListViewController : UIViewController

@property id<MessageListViewEventHandler> eventHandler;

@end
