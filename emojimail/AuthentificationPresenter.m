//
//  AuthentificationPresenter.m
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//


#import "AuthentificationPresenter.h"
#import "AuthentificationWireframe.h"


@implementation AuthentificationPresenter

- (void)initialViewAppeared {
    [self.input attemptSilentGoogleSignIn];
}

- (void)openGoogleSignInPage {
    [self.wireframe presentGoogleSignInView];
}

- (void)signInButtonAction {
    [self.view showLoading];
}

#pragma mark - AuthentificationInteractorOutput

- (void)silentGoogleSignInSucceded {
    NSLog(@"[%@] silent Google sign in succeded", NSStringFromClass(self.class));
}

- (void)silentGoogleSignInFailed {
    NSLog(@"[%@] silent Google sign in failed, showing Google sign in page", NSStringFromClass(self.class));
    [self.wireframe presentGoogleSignInView];
}

@end
