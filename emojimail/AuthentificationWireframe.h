//
//  AuthentificationWireframe.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RootWireframe.h"
#import "AuthentificationPresenter.h"
#import "AuthentificationModuleDelegate.h"


@interface AuthentificationWireframe : NSObject

@property RootWireframe *rootWireframe;

@property AuthentificationPresenter *presenter;

@property id<AuthentificationModuleDelegate> moduleDelegate;

- (void)presentInitialViewFromWindow:(UIWindow *)window;

- (void)presentGoogleSignInView;

- (void)authentificationSuccededFromViewController:(UIViewController *)viewController;

@end
