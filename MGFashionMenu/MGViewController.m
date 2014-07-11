//
//  MGViewController.m
//  MGFashionMenu
//
//  Created by Matteo Gobbi on 05/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGViewController.h"
#import "MGMenuView.h"
#import <CoreGraphics/CoreGraphics.h>

@interface MGViewController ()

- (IBAction)menuAction:(id)sender;

@end


@implementation MGViewController {
    MGMenuView *_menuView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *exampleView = [self createExampleView];
    
    _menuView = [[MGMenuView alloc] initWithMenuView:exampleView];
    [self.view addSubview:_menuView];
}

- (UIView *)createExampleView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1]];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:view.bounds];
    [lbl setText:@"This is a test"];
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
