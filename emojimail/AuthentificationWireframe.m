//
//  AuthentificationWireframe.m
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//


#import "AuthentificationWireframe.h"
#import "InitialViewController.h"
#import "GoogleSignInViewController.h"


@interface AuthentificationWireframe ()

@property (nonatomic) UINavigationController *navigationController;

@end


@implementation AuthentificationWireframe

- (void)presentInitialViewFromWindow:(UIWindow *)window {
    InitialViewController *initialViewController = [self initialViewController];
    initialViewController.eventHandler = self.presenter;
    self.presenter.initialView = initialViewController;
    
    [self.rootWireframe showRootViewController:initialViewController inWindow:window];
    self.navigationController = initialViewController.navigationController;
}

- (void)presentGoogleSignInView {
    GoogleSignInViewController *googleSignInViewController = [self googleSignInViewController];
    googleSignInViewController.eventHandler = self.presenter;
    self.presenter.googleSignInView = googleSignInViewController;
    
    [self.navigationController setViewControllers:@[googleSignInViewController] animated:NO];
}

- (InitialViewController *)initialViewController {
    return [[InitialViewController alloc] init];
}

- (GoogleSignInViewController *)googleSignInViewController {
    return [[GoogleSignInViewController alloc] init];
}

- (void)authentificationSuccededFromViewController:(UIViewController *)viewController {
    [self.moduleDelegate authentificationModuleSuccededFromViewController:viewController];
}

@end
