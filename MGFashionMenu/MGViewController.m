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
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1]];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    [lbl setText:@"This is a test"];
    [lbl setTextColor:[UIColor whiteColor]];
    [view addSubview:lbl];
    
    _menuView = [[MGMenuView alloc] initWithMenuView:view];
    [self.view addSubview:_menuView];
}

- (IBAction)menuAction:(id)sender {
    if (_menuView.isShown)
        [_menuView hide];
    else
        [_menuView show];
}

@end
