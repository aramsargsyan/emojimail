//
//  SentimentPolarityManager.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/21/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 A class that manages the SentimentPolarity Machine Learning model.
 */
@interface SentimentPolarityManager : NSObject


/**
 The singleton instance.
 */
+ (instancetype)sharedManager;

/**
 Determines the sentiment using the ML model and return an emoji representing that sentiment.
 @param text the text to determine the sentiment emoji for
 */
- (NSString *)sentimentEmojiForText:(NSString *)text;

@end
