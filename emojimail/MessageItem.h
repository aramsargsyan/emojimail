//
//  MessageItem.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageItem : NSObject

@property NSString *subject;
@property NSString *from;
@property NSString *snippet;
@property NSString *dateString;
@property NSString *emojiString;

@end
