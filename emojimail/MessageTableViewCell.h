//
//  MessageTableViewCell.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/20/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GTLRGmail.h>


@interface MessageTableViewCell : UITableViewCell

+ (NSString *)defaultReuseIdentifier;

+ (CGFloat)defaultCellHeight;

- (void)render:(GTLRGmail_Message *)message;

@end
