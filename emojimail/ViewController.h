//
//  ViewController.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/18/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GTLRGmail.h>

@interface ViewController : UIViewController


@property (nonatomic, strong) UITextView *output;
@property (nonatomic, strong) GTLRGmailService *service;


@end

