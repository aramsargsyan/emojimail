//
//  AuthentificationInteractor.h
//  emojimail
//
//  Created by Aram Sargsyan on 4/7/18.
//  Copyright © 2018 Aram Sargsyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthentificationInteractorIO.h"

@class AuthentificationPresenter;

@interface AuthentificationInteractor : NSObject <AuthentificationInteractorInput>

@property (nonatomic, weak) id<AuthentificationInteractorOutput> output;

@end
