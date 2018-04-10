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
    [self.input attemptedGoogleSignIn];
    [self.googleSignInView showLoading];
}

#pragma mark - AuthentificationInteractorOutput

- (void)silentGoogleSignInSucceded {
    NSLog(@"[%@] SILENT Google sign in succeded", NSStringFromClass(self.class));
    //TODO: Tell the wireframe to go to HOME VC
    
    [self.wireframe authentificationSuccededFromViewController:self.initialView];
}

- (void)silentGoogleSignInFailed {
    NSLog(@"[%@] SILENT Google sign in failed, showing Google sign in page", NSStringFromClass(self.class));
    [self.wireframe presentGoogleSignInView];
}

- (void)googleSignInSucceded {
    NSLog(@"[%@] Google sign in succeded", NSStringFromClass(self.class));
    //TODO: Tell the wireframe to go to HOME VC
    
    [self.wireframe authentificationSuccededFromViewController:self.googleSignInView];
}

- (void)googleSignInFailed {
    NSLog(@"[%@] Google sign in failed", NSStringFromClass(self.class));
    [self.googleSignInView stopLoading];
    //TODO: DO NOTHING
}

@end
