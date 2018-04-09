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


@interface AuthentificationWireframe : NSObject

@property RootWireframe *rootWireframe;

@property AuthentificationPresenter *presenter;

- (void)presentInitialViewFromWindow:(UIWindow *)window;

- (void)presentGoogleSignInView;

@end
