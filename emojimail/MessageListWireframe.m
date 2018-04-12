//
//  MessageListWireframe.m
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import "MessageListWireframe.h"
#import "MessageListViewController.h"


@interface MessageListWireframe ()

@property UINavigationController *navigationController;

@end


@implementation MessageListWireframe

- (void)presentMessagesList {
    MessageListViewController *listViewController = [self messageListViewController];
    listViewController.eventHandler = self.presenter;
    self.presenter.messageListView = listViewController;
    
    [self.navigationController setViewControllers:@[listViewController] animated:NO];
}

- (MessageListViewController *)messageListViewController {
    return [[MessageListViewController alloc] init];
}

#pragma mark - AuthentificationModuleDelegate

- (void)authentificationModuleSuccededFromViewController:(UIViewController *)viewController {
    self.navigationController = viewController.navigationController;
    [self presentMessagesList];
}

@end
