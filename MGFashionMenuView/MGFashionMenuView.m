//
//  MGFashionMenuView.m
//  MGFashionMenu
//
//  Created by Matteo Gobbi on 05/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGFashionMenuView.h"

static CGFloat const MGSideHelperView = 2.0;
static CGFloat const MGAnimationDuration = .5;


struct Animation {
    NSTimeInterval sideDelay;
    NSTimeInterval sideDumping;
    NSTimeInterval sideVelocity;
    NSTimeInterval centerDelay;
    NSTimeInterval centerDumping;
    NSTimeInterval centerVelocity;
};


@implementation MGFashionMenuView {
    UIView *_centerAnchorView;
    UIView *_sideAnchorView;
    UIView *_menuView;
    UIColor *_fillColor;
    CADisplayLink *_displayLink;
    struct Animation animation;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Invalid init" reason:@"Use initViewMenuView: instead" userInfo:nil];
}

- (instancetype)initWithMenuView:(UIView *)menuView {
    return [self initWithMenuView:menuView animationType:MGAnimationTypeBounce];
}

//Init the menuView and the helperViews
- (instancetype)initWithMenuView:(UIView *)menuView animationType:(MGAnimationType)animationType {
    
    CGRect fakeRect = menuView.frame;
    
    //Go to make the under view bigger for the animation
    fakeRect.size.height += 25.0;
    
    if (self = [super initWithFrame:fakeRect]) {
        
        _menuView = menuView;
        
        //Prepare views positions
        _sideAnchorView = [[UIView alloc] initWithFrame:CGRectMake(-MGSideHelperView/2.0, -MGSideHelperView/2.0, MGSideHelperView, MGSideHelperView)];
        _centerAnchorView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0-MGSideHelperView/2.0, -MGSideHelperView/2.0, MGSideHelperView, MGSideHelperView)];
        _menuView.frame = CGRectMake(0, -_menuView.frame.size.height, _menuView.frame.size.width, _menuView.frame.size.height);
        
        //Colors
        _fillColor = menuView.backgroundColor;
        [self setBackgroundColor:[UIColor clearColor]];
        [self setHidden:YES];
        
        [_menuView setBackgroundColor:[UIColor clearColor]];
        
        //Animation
        [self mg_setValuesForAnimationType:animationType];
        
        //Flags
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
        
        if (needsToAppear) {
            [self setHidden:NO];
        }
        
        _isAnimating = YES;
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(mg_tick:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        
        [UIView animateWithDuration:MGAnimationDuration delay:animation.sideDelay usingSpringWithDamping:animation.sideDumping initialSpringVelocity:animation.sideVelocity options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
            
            if (needsToAppear) {
                _sideAnchorView.frame = CGRectMake(_sideAnchorView.frame.origin.x, _menuView.frame.size.height-MGSideHelperView/2.0, MGSideHelperView, MGSideHelperView);
                _menuView.frame = CGRectMake(_menuView.frame.origin.x, 0, _menuView.frame.size.width, _menuView.frame.size.height);
            } else
                _sideAnchorView.frame = CGRectMake(_sideAnchorView.frame.origin.x, -MGSideHelperView/2.0, MGSideHelperView, MGSideHelperView);
            
        } completion:^(BOOL finished) {
            
            [_displayLink invalidate];
            _displayLink = nil;
            _isShown = needsToAppear;
            _isAnimating = NO;
            
            if (!needsToAppear) {
                [self setHidden:YES];
            }
            
        }];
        
        
        [UIView animateWithDuration:MGAnimationDuration delay:animation.centerDelay usingSpringWithDamping:animation.centerDumping initialSpringVelocity:animation.centerVelocity options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
            
            if (needsToAppear)
                _centerAnchorView.frame = CGRectMake(_centerAnchorView.frame.origin.x, _menuView.frame.size.height-MGSideHelperView/2.0, MGSideHelperView, MGSideHelperView);
            else {
                _centerAnchorView.frame = CGRectMake(_centerAnchorView.frame.origin.x, -MGSideHelperView/2.0, MGSideHelperView, MGSideHelperView);
                _menuView.frame = CGRectMake(_menuView.frame.origin.x, -_menuView.frame.size.height, _menuView.frame.size.width, _menuView.frame.size.height);
            }
            
        } completion:nil];
        
    }
}

//Called from the displayLink each frame of the view changes
- (void)mg_tick:(CADisplayLink *)displayLink {
    [self setNeedsDisplay];
}

- (void)mg_setValuesForAnimationType:(MGAnimationType)animationType {
    switch (animationType) {
        case MGAnimationTypeBounce: {
            animation.sideDelay = .1;
            animation.sideDumping = .4;
            animation.sideVelocity = .9;
            animation.centerDelay = 0;
            animation.centerDumping = .6;
            animation.centerVelocity = .6;
        }
            break;
            
        case MGAnimationTypeSoftBounce: {
            animation.sideDelay = .1;
            animation.sideDumping = .6;
            animation.sideVelocity = .6;
            animation.centerDelay = 0;
            animation.centerDumping = .6;
            animation.centerVelocity = .6;
        }
            break;
            
        case MGAnimationTypeHardBounce: {
            animation.sideDelay = .1;
            animation.sideDumping = .3;
            animation.sideVelocity = .7;
            animation.centerDelay = 0;
            animation.centerDumping = .6;
            animation.centerVelocity = .4;
        }
            break;
            
        case MGAnimationTypeWave: {
            animation.sideDelay = .0;
            animation.sideDumping = .5;
            animation.sideVelocity = .5;
            animation.centerDelay = .1;
            animation.centerDumping = .5;
            animation.centerVelocity = .5;
        }
            break;
            
        default:
            break;
    }
}

@end
