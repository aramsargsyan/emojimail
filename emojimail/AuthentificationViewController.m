//
//  AuthentificationViewController.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/18/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "AuthentificationViewController.h"
#import <Google/SignIn.h>
#import <GTLRGmail.h>


@interface AuthentificationViewController ()

// Low alpha image view for showing the google logo as background
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIView *signInButtonContainerView;

@property (nonatomic) GIDSignInButton *signInButton;

// This activity indicator takes place of the sign-in button above to avoid repeated touches of the button
@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@end


@implementation AuthentificationViewController

#pragma mark - Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add the Google sign-in button
    self.signInButton = [[GIDSignInButton alloc] init];
    [self.signInButton addTarget:self action:@selector(signInTapped) forControlEvents:UIControlEventTouchUpInside];
    [self placeView:self.signInButton inContainerView:self.signInButtonContainerView];
    
    // Add the activity indicator and hide it
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    self.activityIndicator.color = [UIColor grayColor];
    self.activityIndicator.hidesWhenStopped = YES;
    [self placeView:self.activityIndicator inContainerView:self.signInButtonContainerView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Reset button/activity indicator states
    [self.activityIndicator stopAnimating];
    self.signInButton.hidden = NO;
}


#pragma mark - Private


// GIDSignInButton handles the Safari ViewController push, this action is just for UI changes
- (void)signInTapped {
    self.signInButton.hidden = YES;
    [self.activityIndicator startAnimating];
}


- (void)placeView:(UIView *)view inContainerView:(UIView *)containerView {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:view];
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1 constant:20].active = YES;
}


@end
