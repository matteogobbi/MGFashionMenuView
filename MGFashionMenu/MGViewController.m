//
//  MGViewController.m
//  MGFashionMenu
//
//  Created by Matteo Gobbi on 05/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGViewController.h"
#import "MGFashionMenuView.h"
#import <CoreGraphics/CoreGraphics.h>

@interface MGViewController ()

- (IBAction)menuAction:(id)sender;
- (IBAction)menuAction2:(id)sender;
- (IBAction)menuAction3:(id)sender;

@end


@implementation MGViewController {
    MGFashionMenuView *_menuView;
    MGFashionMenuView *_menuView2;
    MGFashionMenuView *_menuView3;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _menuView = [[MGFashionMenuView alloc] initWithMenuView:[self createExampleView]];
    [self.view addSubview:_menuView];
    
    _menuView2 = [[MGFashionMenuView alloc] initWithMenuView:[self createExampleView2] andAnimationType:MGAnimationTypeSoftBounce];
    [self.view addSubview:_menuView2];
    
    _menuView3 = [[MGFashionMenuView alloc] initWithMenuView:[self createExampleView3] andAnimationType:MGAnimationTypeWave];
    [self.view addSubview:_menuView3];
}

- (UIView *)createExampleView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1]];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:view.bounds];
    [lbl setText:@"This is a test with Bounce animation"];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor whiteColor]];
    [view addSubview:lbl];
    [lbl setCenter:view.center];
    
    return view;
}

- (UIView *)createExampleView2 {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [view setBackgroundColor:[UIColor blackColor]];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:view.bounds];
    [lbl setText:@"x"];
    [lbl setFont:[UIFont boldSystemFontOfSize:16.0]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor whiteColor]];
    [view addSubview:lbl];
    [lbl setCenter:view.center];
    
    return view;
}

- (UIView *)createExampleView3 {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    [view setBackgroundColor:[UIColor colorWithRed:0.2 green:0.722 blue:0.2 alpha:1]];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:view.bounds];
    [lbl setText:@"This is a test with Wave animation"];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor whiteColor]];
    [view addSubview:lbl];
    [lbl setCenter:view.center];
    
    return view;
}

- (IBAction)menuAction:(id)sender {
    if (_menuView.isShown)
        [_menuView hide];
    else
        [_menuView show];
}

- (IBAction)menuAction2:(id)sender {
    if (_menuView2.isShown)
        [_menuView2 hide];
    else
        [_menuView2 show];
}

- (IBAction)menuAction3:(id)sender {
    if (_menuView3.isShown)
        [_menuView3 hide];
    else
        [_menuView3 show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
