//
//  SentimentPolarityManager.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/21/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SentimentPolarityManager : NSObject

+ (instancetype)sharedManager;

- (NSString *)sentimentEmojiForText:(NSString *)text;

@end
