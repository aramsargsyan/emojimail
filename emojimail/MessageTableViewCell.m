//
//  MessageTableViewCell.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/20/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "MessageTableViewCell.h"


@interface MessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *snippetLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


@implementation MessageTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (NSString *)defaultReuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (CGFloat)defaultCellHeight {
    return 120;
}


- (void)render:(GTLRGmail_Message *)message {
    self.snippetLabel.text = message.snippet;
    
    // The timestamp provided by Google is in milliseconds
    double timestamp = message.internalDate.doubleValue/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // Show time for today's messages, show date for older messages
    BOOL isDateFromToday = [[NSCalendar currentCalendar] isDateInToday:date];
    if (isDateFromToday) {
        [dateFormatter setDateFormat:@"HH:mm"];
    } else {
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    }
    self.timeLabel.text = [dateFormatter stringFromDate:date];
    
    for (GTLRGmail_MessagePartHeader *header in message.payload.headers) {
        if ([header.name isEqualToString:@"From"]) {
            self.fromLabel.text = header.value;
        } else if ([header.name isEqualToString:@"Subject"]) {
            self.subjectLabel.text = header.value;
        }
    }
    
    self.emojiLabel.text = @"😁";
}



@end
