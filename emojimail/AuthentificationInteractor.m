//
//  AuthentificationInteractor.m
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import "AuthentificationInteractor.h"
#import "GoogleSignInManager.h"
#import "AuthentificationPresenter.h"


@implementation AuthentificationInteractor


- (void)attemptSilentGoogleSignIn {
    [[GoogleSignInManager sharedManager] attemptSilentGoogleSignInWithCompletion:^(BOOL signedIn) {
        if (signedIn) {
            [self.output silentGoogleSignInSucceded];
        } else {
            [self.output silentGoogleSignInFailed];
        }
    }];
}

- (void)attemptedGoogleSignIn {
    [GoogleSignInManager sharedManager].completion = ^(BOOL signedIn) {
        if (signedIn) {
            [self.output googleSignInSucceded];
        } else {
            [self.output googleSignInFailed];
        }
    };
}

@end
