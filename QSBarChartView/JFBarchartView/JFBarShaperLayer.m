//
//  JFBarShaperLayer.m
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import "JFBarShaperLayer.h"

@implementation JFBarShaperLayer

- (void)strokeLayer
{
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    if(self.ISInverted){
        [progressline moveToPoint:CGPointMake(self.frame.size.width / 2.0, 0)];
        [progressline addLineToPoint:CGPointMake(self.frame.size.width / 2.0, self.grade * self.bounds.size.height)];
        
    }else{
        [progressline moveToPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height)];
        [progressline addLineToPoint:CGPointMake(self.frame.size.width / 2.0, (1 - self.grade) * self.frame.size.height)];
        
    }
    
    
    self.lineWidth = CGRectGetWidth(self.bounds);
    [progressline setLineWidth:self.bounds.size.width];
    [progressline setLineCapStyle:kCGLineCapSquare];
    
       {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 1.0;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;
        [self addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        self.strokeEnd = 1.0;
        
        self.path = progressline.CGPath;
        
    }
    if(self.ISInverted == NO){
        CGFloat cornerRadius = self.cornerRadius;
        CGRect frame = CGRectMake(0, CGRectGetHeight(self.frame)*(1-self.grade), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*self.grade);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor redColor].CGColor;
        maskLayer.path = maskPath.CGPath;
        self.mask = maskLayer;
    }else{
        CGFloat cornerRadius = self.cornerRadius;
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*self.grade);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor redColor].CGColor;
        maskLayer.path = maskPath.CGPath;
        self.mask = maskLayer;
    }
    
}

- (BOOL) containsPoint:(CGPoint)point {
    return CGPathContainsPoint(self.path, NULL, point, false);
}

@end
