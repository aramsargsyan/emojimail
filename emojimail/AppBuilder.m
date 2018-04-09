//
//  AppBuilder.m
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import "AppBuilder.h"
#import "AuthentificationWireframe.h"
#import "AuthentificationPresenter.h"
#import "AuthentificationInteractor.h"


@interface AppBuilder ()

@property (nonatomic, strong) AuthentificationWireframe *authentificationWireframe;

@end


@implementation AppBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureDependencies];
    }
    return self;
}

- (void)configureDependencies {
    AuthentificationWireframe *authentificationWireframe = [[AuthentificationWireframe alloc] init];
    AuthentificationPresenter *authentificationPresenter = [[AuthentificationPresenter alloc] init];
    AuthentificationInteractor *authentificationInteractor = [[AuthentificationInteractor alloc] init];
    
    self.authentificationWireframe = authentificationWireframe;
    authentificationWireframe.rootWireframe = [[RootWireframe alloc] init];
    authentificationWireframe.presenter = authentificationPresenter;
    
    authentificationPresenter.input = authentificationInteractor;
    authentificationPresenter.wireframe = authentificationWireframe;
    
    authentificationInteractor.output = authentificationPresenter;
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window {
    [self.authentificationWireframe presentInitialViewFromWindow:window];
    
}

@end
