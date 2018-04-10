//
//  AuthentificationModuleDelegate.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthentificationModuleDelegate <NSObject>

- (void)authentificationModuleSuccededFromViewController:(UIViewController *)viewController;

@end
