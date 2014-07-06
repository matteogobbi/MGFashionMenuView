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

static CGFloat const sideHelperView = 30.0;
static CGFloat const animationDuration = .5;

@implementation MGViewController {
    MGMenuView *_menuView;
    UIView *_centerAnchorView;
    UIView *_sideAnchorView;
    CADisplayLink *_displayLink;
    BOOL _isShowed;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _isShowed = NO;
    
    _centerAnchorView = [[UIView alloc] initWithFrame:CGRectMake(320.0/2.0-sideHelperView/2.0, -sideHelperView/2.0, sideHelperView, sideHelperView)];
    [self.view addSubview:_centerAnchorView];
    //[_centerAnchorView setBackgroundColor:[UIColor yellowColor]];
    [self.view bringSubviewToFront:_centerAnchorView];
    
    _sideAnchorView = [[UIView alloc] initWithFrame:CGRectMake(-sideHelperView/2.0, -sideHelperView/2.0, sideHelperView, sideHelperView)];
    [self.view addSubview:_sideAnchorView];
    //[_sideAnchorView setBackgroundColor:[UIColor yellowColor]];
    [self.view bringSubviewToFront:_sideAnchorView];
    
    _menuView = [[MGMenuView alloc] initWithFrame:CGRectMake(0, -250.0, 320.0, 250.0) sideAnchorView:_sideAnchorView centerAnchorView:_centerAnchorView];
    [self.view insertSubview:_menuView atIndex:0];
    [_menuView setBackgroundColor:[UIColor clearColor]];
    
    _menuView.frame = CGRectMake(0, 0, _menuView.frame.size.width, _menuView.frame.size.height);
}


- (void)tick:(CADisplayLink *)displayLink {
    [_menuView setNeedsDisplay];
}

- (IBAction)menuAction:(id)sender {
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    if (!_isShowed) {
        
        [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.4 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
            _centerAnchorView.frame = CGRectMake(_centerAnchorView.frame.origin.x, _centerAnchorView.frame.origin.y+_menuView.frame.size.height-10.0, sideHelperView, sideHelperView);
        } completion:nil];
        
        [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.9 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
            _sideAnchorView.frame = CGRectMake(-sideHelperView/2.0, _sideAnchorView.frame.origin.y+_menuView.frame.size.height-10.0, sideHelperView, sideHelperView);
        } completion:^(BOOL finished) {
            [_displayLink invalidate];
            _displayLink = nil;
        }];
    } else {
        
        [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.4 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
            _centerAnchorView.frame = CGRectMake(_centerAnchorView.frame.origin.x, -sideHelperView/2.0, sideHelperView, sideHelperView);
        } completion:nil];
        
        [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.9 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
            _sideAnchorView.frame = CGRectMake(-sideHelperView/2.0, -sideHelperView/2.0, sideHelperView, sideHelperView);
        } completion:^(BOOL finished) {
            [_displayLink invalidate];
            _displayLink = nil;
        }];
    }
    
    _isShowed = !_isShowed;
}

@end
