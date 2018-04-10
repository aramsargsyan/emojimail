//
//  InitialViewController.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/20/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "InitialViewEventHandler.h"


@interface InitialViewController : UIViewController

@property id<InitialViewEventHandler> eventHandler;

@end
