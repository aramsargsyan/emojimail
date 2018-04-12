//
//  GoogleSignInViewController.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/18/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "GoogleSignInViewController.h"
#import <Google/SignIn.h>
#import <GTLRGmail.h>
#import "UIView+Autolayout.h"
#import "AuthentificationPresenter.h"


@interface GoogleSignInViewController ()

// Low alpha image view for showing the google logo as background
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIView *signInButtonContainerView;

@property (nonatomic) GIDSignInButton *signInButton;

// This activity indicator takes place of the sign-in button above to avoid repeated touches of the button
@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@end


@implementation GoogleSignInViewController

#pragma mark - Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add the Google sign-in button
    self.signInButton = [[GIDSignInButton alloc] init];
    [self.signInButton addTarget:self action:@selector(signInTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.signInButtonContainerView addSubview:self.signInButton];
    self.signInButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.signInButton placeInSuperviewUpperCenter];
    
    // Add the activity indicator and hide it
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    self.activityIndicator.color = [UIColor grayColor];
    self.activityIndicator.hidesWhenStopped = YES;
    
    [self.signInButtonContainerView addSubview:self.activityIndicator];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.activityIndicator placeInSuperviewUpperCenter];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


#pragma mark - Private

- (void)stopActivityIndicator {
    [self.activityIndicator stopAnimating];
    self.signInButton.hidden = NO;
}

- (void)startActivityIndicator {
    self.signInButton.hidden = YES;
    [self.activityIndicator startAnimating];
}

- (void)signInTapped {
    /* GIDSignInButton handles the Safari ViewController push, this action is just for UI changes */
    [self.eventHandler signInButtonAction];
}


#pragma mark - AuthentificationViewInterface

- (void)showLoading {
    [self startActivityIndicator];
}

- (void)stopLoading {
    [self stopActivityIndicator];
}

@end
