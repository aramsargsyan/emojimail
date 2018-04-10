//
//  MessageTableViewCell.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/20/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessagesDataSource.h"
#import "MessageItem.h"


@interface MessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *snippetLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


@implementation MessageTableViewCell


#pragma mark - Lifecycle


- (void)awakeFromNib {
    [super awakeFromNib];
    
    // No need for selection on this cell
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


#pragma mark - Public


+ (NSString *)defaultReuseIdentifier {
    return NSStringFromClass(self.class);
}


+ (CGFloat)defaultCellHeight {
    return 120;
}

- (void)renderMessageItem:(MessageItem *)messageItem {
    self.subjectLabel.text = messageItem.subject;
    self.snippetLabel.text = messageItem.snippet;
    self.fromLabel.text = messageItem.from;
    self.timeLabel.text = messageItem.dateString;
    self.emojiLabel.text = messageItem.emojiString;
}


@end
