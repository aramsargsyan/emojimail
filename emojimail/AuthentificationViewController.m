//
//  AuthentificationViewController.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/18/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "AuthentificationViewController.h"
#import <GTLRGmail.h>

@interface AuthentificationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIView *signInButtonContainerView;

@property (nonatomic, strong) GIDSignInButton *signInButton;


@end

@implementation AuthentificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    
    // Add the sign-in button.
    self.signInButtonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.signInButton = [[GIDSignInButton alloc] init];
    self.signInButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.signInButtonContainerView addSubview:self.signInButton];
    [NSLayoutConstraint constraintWithItem:self.signInButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.signInButtonContainerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.signInButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.signInButtonContainerView attribute:NSLayoutAttributeTop multiplier:1 constant:20].active = YES;
}


// Helper for showing an alert
- (void)showAlert:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
         [alert dismissViewControllerAnimated:YES completion:nil];
     }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
