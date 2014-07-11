//
//  MGMenuView.h
//  MGFashionMenu
//
//  Created by Matteo Gobbi on 05/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MGAnimationType) {
    MGAnimationTypeBlob
};

@interface MGMenuView : UIView

@property (atomic, assign, readonly) BOOL isShown;
@property (atomic, assign, readonly) BOOL isAnimating;

- (instancetype)initWithMenuView:(UIView *)menuView;
- (instancetype)initWithMenuView:(UIView *)menuView andAnimation:(MGAnimationType)animationType;

- (void)show;
- (void)hide;

@end
