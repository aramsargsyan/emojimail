//
//  GoogleSignInViewEventHandler.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GoogleSignInViewEventHandler <NSObject>

- (void)signInButtonAction;

- (void)openGoogleSignInPage;

@end
