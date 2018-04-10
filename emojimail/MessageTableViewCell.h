//
//  MessageTableViewCell.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/20/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MessageTableViewCell : UITableViewCell

+ (NSString *)defaultReuseIdentifier;

+ (CGFloat)defaultCellHeight;

- (void)renderMessageItem:(MessageItem *)messageItem;

@end
