//
//  InitialViewController.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/20/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "InitialViewController.h"
#import "GoogleSignInManager.h"


@interface InitialViewController ()

@property UIActivityIndicatorView *activityIndicator;

@end


@implementation InitialViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    
    
    [[GoogleSignInManager sharedInstance] startGoogleSignInFlowWithNavigationController:self.navigationController];
    [self.activityIndicator startAnimating];
}


- (void)configureViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.color = [UIColor grayColor];
    
    [self.view addSubview:self.activityIndicator];
    
    [NSLayoutConstraint constraintWithItem:self.activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
}



@end
