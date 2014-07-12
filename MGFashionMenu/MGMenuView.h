//
//  MGMenuView.h
//  MGFashionMenu
//
//  Created by Matteo Gobbi on 05/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MGAnimationType) {
    MGAnimationTypeBounce,
    MGAnimationTypeSoftBounce,
    MGAnimationTypeHardBounce,
    MGAnimationTypeWave
};

@interface MGMenuView : UIView

@property (atomic, assign, readonly) BOOL isShown;
@property (atomic, assign, readonly) BOOL isAnimating;

- (instancetype)initWithMenuView:(UIView *)menuView;
- (instancetype)initWithMenuView:(UIView *)menuView andAnimationType:(MGAnimationType)animationType;

- (void)show;
- (void)hide;

@end
