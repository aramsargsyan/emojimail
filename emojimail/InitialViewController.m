//
//  InitialViewController.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/20/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "InitialViewController.h"
#import "GoogleSignInManager.h"
#import "AuthentificationViewController.h"
#import "HomeViewController.h"
#import "UIView+Autolayout.h"


@interface InitialViewController ()

@property UIActivityIndicatorView *activityIndicator;

@end


@implementation InitialViewController

#pragma mark - Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    
    [[GoogleSignInManager sharedManager] setHomeViewControllerClass:HomeViewController.class andAuthentificationViewControllerClass:AuthentificationViewController.class];
    [[GoogleSignInManager sharedManager] startGoogleSignInFlowWithNavigationController:self.navigationController];
    
    [self.activityIndicator startAnimating];
}


- (void)configureViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.color = [UIColor grayColor];
    
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator autocenterInSuperview];
}


@end
