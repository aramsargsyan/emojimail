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


/**
 A class that manages the Google sign in flow.
 */
@interface GoogleSignInManager : NSObject

/**
 the Google user object, which represents a Google account, is set after a successful login
 */
@property (nonatomic, readonly) GIDGoogleUser *user;

/**
 The singleton instance.
 */
+ (instancetype)sharedManager;

/**
 Set the view controller classes.
 @param homeVCClass the class of the view controller that will be shown after a successful login
 @param authVCClass the class of the view controller that will be shown after failing to log in, should most probably have a Google sign-in button
 */
- (void)setHomeViewControllerClass:(Class)homeVCClass andAuthentificationViewControllerClass:(Class)authVCClass;

/**
 Starts the whole flow.
 @param navigationController the navigation controller that will be used to show relevant VC's. Authentification and Google sign-in view controllers will not be kept in the stack.
 */
- (void)startGoogleSignInFlowWithNavigationController:(UINavigationController *)navigationController;

@end
