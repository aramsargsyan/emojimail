//
//  UIView+Autolayout.h
//  emojimail
//
//  Created by Aram Sargsyan on 9/21/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A category that makes programmatically adding constraints more comfortable
 */
@interface UIView (Autolayout)

- (void)autopinEdgesToSuperview;

- (void)autocenterInSuperview;

- (void)placeInSuperviewUpperCenter;

@end
