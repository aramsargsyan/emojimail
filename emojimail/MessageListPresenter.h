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

@interface MessageListPresenter : NSObject <MessageListInteractorOutput, MessageListViewEventHandler>

@property id<MessageListInteractorInput> input;
//TODO: ARAM add VC here

@end
