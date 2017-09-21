//
//  GoogleSignInManager.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/19/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "GoogleSignInManager.h"
#import <GTLRGmail.h>


@interface GoogleSignInManager () <GIDSignInDelegate, GIDSignInUIDelegate>

@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) UIViewController *googleSignInViewController;

@property (nonatomic, readwrite) Class homeViewControllerClass;
@property (nonatomic, readwrite) Class authentificationViewControllerClass;

@property (nonatomic, readwrite) GIDGoogleUser *user;

@end


@implementation GoogleSignInManager

#pragma mark - Public


+ (instancetype)sharedManager {
    static GoogleSignInManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


- (void)setHomeViewControllerClass:(Class)homeVCClass andAuthentificationViewControllerClass:(Class)authVCClass {
    self.homeViewControllerClass = homeVCClass;
    self.authentificationViewControllerClass = authVCClass;
}


- (void)startGoogleSignInFlowWithNavigationController:(UINavigationController *)navigationController {
    NSAssert(self.homeViewControllerClass, @"Use the [GoogleSignInManager] setHomeViewControllerClass:andAuthentificationViewControllerClass: method to set view controller classes before you use this method.");
    NSAssert(navigationController, @"[GoogleSignInManager] needs an initial view controller embedded in a UINavigationController to perform necessary UI changes");
    self.navigationController = navigationController;
    
    // Configure Google Sign-in.
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.delegate = self;
    signIn.uiDelegate = self;
    signIn.scopes = [NSArray arrayWithObjects:kGTLRAuthScopeGmailReadonly, nil];
    
    if (signIn.hasAuthInKeychain) {
        [signIn signInSilently];
    } else {
        [self.navigationController setViewControllers:@[[[self.authentificationViewControllerClass alloc] init]] animated:NO];
    }
}


#pragma mark - Private


- (void)showAlertOnVisibleAuthControllerForError:(NSError *)error {
    if ([self.navigationController.visibleViewController isKindOfClass:self.authentificationViewControllerClass]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed to Sign in to Google"
                                                                       message:error.localizedDescription
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                                         }];
        [alert addAction:okAction];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController.visibleViewController presentViewController:alert animated:YES completion:nil];
        });
    }
}


#pragma mark - GIDSignInDelegate


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    self.user = user;
    if (error) {
        if (self.googleSignInViewController) {
            [self.googleSignInViewController dismissViewControllerAnimated:YES completion:^{
                [self showAlertOnVisibleAuthControllerForError:error];
            }];
        } else {
            if (!(self.navigationController.viewControllers.count && [self.navigationController.viewControllers.firstObject isKindOfClass:self.authentificationViewControllerClass])) {
                [self.navigationController setViewControllers:@[[[self.authentificationViewControllerClass alloc] init]] animated:NO];
            }
        }
    } else {
        [self.navigationController setViewControllers:@[[[self.homeViewControllerClass alloc] init]] animated:NO];
        [self.googleSignInViewController dismissViewControllerAnimated:YES completion:nil];
    }
    self.googleSignInViewController = nil;
}


#pragma mark - GIDSignInUIDelegate


- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self.navigationController.visibleViewController presentViewController:viewController animated:YES completion:nil];
}


- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    self.googleSignInViewController = viewController;
}


@end
