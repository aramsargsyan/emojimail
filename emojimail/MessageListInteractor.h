//
//  MessageListInteractor.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageListInteractorIO.h"
#import <GTLRGmail.h>

@interface MessageListInteractor : NSObject <MessageListInteractorInput>

@property (nonatomic, weak) id<MessageListInteractorOutput> output;

@end

@interface GTLRGmail_Message (MessageListInteractor)

@property NSString *emojiString;

@end
