//
//  AuthentificationInteractorIO.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol AuthentificationInteractorInput <NSObject>

- (void)attemptSilentGoogleSignIn;

@end


@protocol AuthentificationInteractorOutput <NSObject>

- (void)silentGoogleSignInSucceded;

- (void)silentGoogleSignInFailed;

@end
