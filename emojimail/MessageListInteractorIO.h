//
//  MessageListInteractorIO.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GTLRGmail_Message;

@protocol MessageListInteractorInput <NSObject>

- (void)getEmails;

@end


@protocol MessageListInteractorOutput <NSObject>

- (void)gotEmails:(NSArray <GTLRGmail_Message *> *)emails;

@end
