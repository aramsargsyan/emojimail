//
//  AuthentificationPresenter.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthentificationInteractor.h"
#import "AuthentificationViewInterface.h"
#import <UIKit/UIKit.h>
@class AuthentificationWireframe;

@interface AuthentificationPresenter : NSObject <AuthentificationInteractorOutput>

@property (nonatomic, strong) id<AuthentificationInteractorInput> input;
@property (nonatomic, weak) AuthentificationWireframe *wireframe;
@property (nonatomic, strong) UIViewController<AuthentificationViewInterface> *view;

- (void)initialViewAppeared;

- (void)signInButtonAction;

- (void)openGoogleSignInPage;

@end
