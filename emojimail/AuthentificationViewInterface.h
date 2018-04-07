//
//  AuthentificationViewInterface.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AuthentificationViewInterface <NSObject>

- (void)showLoading;

- (void)stopLoading;

@end
