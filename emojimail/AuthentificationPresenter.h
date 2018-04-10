//
//  AuthentificationPresenter.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InitialViewEventHandler.h"
#import "GoogleSignInViewEventHandler.h"
#import "AuthentificationInteractor.h"
#import "GoogleSignInViewInterface.h"
@class AuthentificationWireframe;


@interface AuthentificationPresenter : NSObject <AuthentificationInteractorOutput, InitialViewEventHandler, GoogleSignInViewEventHandler>

@property (nonatomic, strong) id<AuthentificationInteractorInput> input;
@property (nonatomic, weak) AuthentificationWireframe *wireframe;
@property (nonatomic, weak) UIViewController<GoogleSignInViewInterface> *googleSignInView;
@property (nonatomic, weak) UIViewController *initialView;

@end
