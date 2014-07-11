//
//  MGMenuView.h
//  MGFashionMenu
//
//  Created by Matteo Gobbi on 05/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGMenuView : UIView

@property (atomic, assign, readonly) BOOL isShown;

- (instancetype)initWithMenuView:(UIView *)menuView;

- (void)show;
- (void)hide;

@end
