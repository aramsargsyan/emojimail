//
//  MessageListWireframe.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/10/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthentificationModuleDelegate.h"
#import "MessageListPresenter.h"


@interface MessageListWireframe : NSObject <AuthentificationModuleDelegate>

@property MessageListPresenter *presenter;

@end
