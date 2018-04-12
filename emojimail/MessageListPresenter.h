//
//  MessageListPresenter.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageListInteractorIO.h"
#import "MessageListViewEventHandler.h"
#import "MessageListViewInterface.h"

@interface MessageListPresenter : NSObject <MessageListInteractorOutput, MessageListViewEventHandler>

@property (nonatomic, strong) id<MessageListInteractorInput> input;
@property (nonatomic, weak) id<MessageListViewInterface> messageListView;

@end
