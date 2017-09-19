//
//  GoogleSignInManager.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/19/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "GoogleSignInManager.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "AuthentificationViewController.h"
#import <Google/SignIn.h>
#import <GTLRGmail.h>


@interface GoogleSignInManager () <GIDSignInDelegate, GIDSignInUIDelegate>

@property BOOL didSignInCalled;
@property UINavigationController *navigationController;
@property UIViewController *googleSignInViewController;

@end


@implementation GoogleSignInManager


#pragma mark - Public


+ (instancetype)sharedInstance {
    static GoogleSignInManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}


- (void)startGoogleSignInFlowWithNavigationController:(UINavigationController *)navigationController {
    self.navigationController = navigationController;
    
    // Configure Google Sign-in.
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.delegate = self;
    signIn.uiDelegate = self;
    
    signIn.scopes = [NSArray arrayWithObjects:kGTLRAuthScopeGmailReadonly, nil];
    
    if (signIn.hasAuthInKeychain) {
        [signIn signInSilently];
    }
}


#pragma mark - Private


- (void)showAlertOnVisibleAuthControllerForError:(NSError *)error {
    if ([self.navigationController.visibleViewController isKindOfClass:[AuthentificationViewController class]]) {
        [((AuthentificationViewController *)self.navigationController.visibleViewController) showAlert:@"Failed to Sign in to Google" message:error.localizedDescription];
    }
}


#pragma mark - GIDSignInDelegate


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (!self.didSignInCalled) {
        self.didSignInCalled = YES;
        if (error) {
            AuthentificationViewController *authentificationController = [[AuthentificationViewController alloc] init];
            [self.navigationController setViewControllers:@[authentificationController] animated:NO];
            [self showAlertOnVisibleAuthControllerForError:error];
        } else {
            [self.navigationController setViewControllers:@[[[HomeViewController alloc] init]] animated:NO];
        }
    } else {
        if (error) {
            [self showAlertOnVisibleAuthControllerForError:error];
        } else {
            [self.navigationController setViewControllers:@[[[HomeViewController alloc] init]] animated:NO];
        }
        [self.googleSignInViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - GIDSignInUIDelegate


- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self.navigationController.visibleViewController presentViewController:viewController animated:YES completion:nil];
}


- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    self.googleSignInViewController = viewController;
}

@end
