//
//  MessagesDataSource.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/18/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol MessagesDataSourceDelegate <NSObject>

@optional
- (void)refresh;

@end


@interface MessagesDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) id<MessagesDataSourceDelegate> delegate;

@end
