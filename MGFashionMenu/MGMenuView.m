//
//  MGMenuView.m
//  MGFashionMenu
//
//  Created by Matteo Gobbi on 05/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGMenuView.h"

static CGFloat const sideHelperView = 20.0;
static CGFloat const animationDuration = .5;

@implementation MGMenuView {
    UIView *_centerAnchorView;
    UIView *_sideAnchorView;
    UIView *_menuView;
    UIColor *_fillColor;
    CADisplayLink *_displayLink;
    
    BOOL _isAnimating;
}


//Init the menuView and the helperViews
- (instancetype)initWithMenuView:(UIView *)menuView {
    
    CGRect fakeRect = menuView.frame;
    
    //from up
    
    //Go to make the under view bigger for the animation
    fakeRect.size.height += 25.0;
    
    if (self = [super initWithFrame:fakeRect]) {
        
        _menuView = menuView;
        
        //from up
        _sideAnchorView = [[UIView alloc] initWithFrame:CGRectMake(-sideHelperView/2.0, -sideHelperView/2.0, sideHelperView, sideHelperView)];
        
        _centerAnchorView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0-sideHelperView/2.0, -sideHelperView/2.0, sideHelperView, sideHelperView)];
        
        _fillColor = menuView.backgroundColor;
        
        _menuView.frame = CGRectMake(0, -_menuView.frame.size.height, _menuView.frame.size.width, _menuView.frame.size.height);
        
        [self setBackgroundColor:[UIColor clearColor]];
        [_menuView setBackgroundColor:[UIColor clearColor]];
        
        _isAnimating = NO;
        _isShown = NO;
    }
    
    return self;
}

//Logic to draw the context for each tick
- (void)drawRect:(CGRect)rect
{
    if (!_menuView.superview) {
        [self addSubview:_menuView];
        [self addSubview:_centerAnchorView];
        [self addSubview:_sideAnchorView];
    }
    
    CALayer *sideLayer = _sideAnchorView.layer.presentationLayer;
    CALayer *centerLayer = _centerAnchorView.layer.presentationLayer;
    
    CGPoint sideLayerCenterPoint = CGPointMake(sideLayer.frame.origin.x+sideLayer.frame.size.width/2.0, sideLayer.frame.origin.y+sideLayer.frame.size.height/2.0);
    CGPoint centerLayerCenterPoint = CGPointMake(centerLayer.frame.origin.x+centerLayer.frame.size.width/2.0, centerLayer.frame.origin.y+centerLayer.frame.size.height/2.0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:sideLayerCenterPoint];
    [path addQuadCurveToPoint:CGPointMake(sideLayerCenterPoint.x+_menuView.frame.size.width, sideLayerCenterPoint.y) controlPoint:centerLayerCenterPoint];
    [path addLineToPoint:CGPointMake(_menuView.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    
    [_fillColor setFill];
    
    CGContextFillPath(context);
}



#pragma mark - Public Methods

- (void)show {
    [self mg_animateMenuViewToAppear:YES];
}

- (void)hide {
    [self mg_animateMenuViewToAppear:NO];
}

#pragma mark - Private Methods

//Animation of the helperViews
- (void)mg_animateMenuViewToAppear:(BOOL)needsToAppear {
    
    if (_isShown != needsToAppear && !_isAnimating) {
        
        _isAnimating = YES;
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(mg_tick:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        
        [UIView animateWithDuration:animationDuration delay:.1 usingSpringWithDamping:.4 initialSpringVelocity:.9 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
            
            if (needsToAppear) {
                _sideAnchorView.frame = CGRectMake(_sideAnchorView.frame.origin.x, _menuView.frame.size.height-sideHelperView/2.0, sideHelperView, sideHelperView);
                _menuView.frame = CGRectMake(_menuView.frame.origin.x, 0, _menuView.frame.size.width, _menuView.frame.size.height);
            } else
                _sideAnchorView.frame = CGRectMake(_sideAnchorView.frame.origin.x, -sideHelperView/2.0, sideHelperView, sideHelperView);
            
        } completion:^(BOOL finished) {
            
            [_displayLink invalidate];
            _displayLink = nil;
            _isShown = needsToAppear;
            _isAnimating = NO;
            
        }];
        
        
        [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:.6 initialSpringVelocity:.6 options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
            
            if (needsToAppear)
                _centerAnchorView.frame = CGRectMake(_centerAnchorView.frame.origin.x, _menuView.frame.size.height-sideHelperView/2.0, sideHelperView, sideHelperView);
            else {
                _centerAnchorView.frame = CGRectMake(_centerAnchorView.frame.origin.x, -sideHelperView/2.0, sideHelperView, sideHelperView);
                
                _menuView.frame = CGRectMake(_menuView.frame.origin.x, -_menuView.frame.size.height, _menuView.frame.size.width, _menuView.frame.size.height);
            }
            
        } completion:nil];
        
    }
}

//Called from the displayLink each frame of the view changes
- (void)mg_tick:(CADisplayLink *)displayLink {
    [self setNeedsDisplay];
}

@end
