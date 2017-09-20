//
//  GoogleSignInManager.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/19/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface GoogleSignInManager : NSObject

@property (nonatomic, readonly) GIDGoogleUser *user;

+ (instancetype)sharedInstance;

- (void)startGoogleSignInFlowWithNavigationController:(UINavigationController *)navigationController;

@end
