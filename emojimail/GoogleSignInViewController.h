//
//  GoogleSignInViewController.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/18/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GoogleSignInViewInterface.h"
#import "GoogleSignInViewEventHandler.h"
@class AuthentificationPresenter;


@interface GoogleSignInViewController : UIViewController <GoogleSignInViewInterface>

@property (nonatomic, strong) id<GoogleSignInViewEventHandler> eventHandler;

@end
