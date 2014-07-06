//
//  MGMenuView.m
//  MGFashionMenu
//
//  Created by Matteo Gobbi on 05/07/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGMenuView.h"

@implementation MGMenuView {
    UIView *_centerAnchorView;
    UIView *_sideAnchorView;
    UIColor *_fillColor;
}

- (id)initWithFrame:(CGRect)frame sideAnchorView:(UIView *)sideAnchorView centerAnchorView:(UIView *)centerAnchorView
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _sideAnchorView = sideAnchorView;
        _centerAnchorView = centerAnchorView;
        _fillColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect");
    
    CALayer *sideLayer = _sideAnchorView.layer.presentationLayer;
    CALayer *centerLayer = _centerAnchorView.layer.presentationLayer;
    
    CGPoint sideLayerCenterPoint = CGPointMake(sideLayer.frame.origin.x+sideLayer.frame.size.width/2.0, sideLayer.frame.origin.y+sideLayer.frame.size.height/2.0);
    CGPoint centerLayerCenterPoint = CGPointMake(centerLayer.frame.origin.x+centerLayer.frame.size.width/2.0, centerLayer.frame.origin.y+centerLayer.frame.size.height/2.0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:sideLayerCenterPoint];
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width, sideLayerCenterPoint.y) controlPoint:centerLayerCenterPoint];

    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    
    [path closePath];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_fillColor setFill];
    CGContextFillPath(context);
}


@end
