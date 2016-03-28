//
//  JFBarLayerItem.m
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import "JFBarLayerItem.h"
#import "JFBarShaperLayer.h"
#import "JFBarPath.h"
#import "DTGraphicsConverter.h"

@implementation JFBarLayerItem

-(JFBarShaperLayer*)jf_JFBarShaperLayer{
    
    JFBarShaperLayer* layer = [JFBarShaperLayer layer];
    
    layer.fillColor = self.fillColor.CGColor;
    
    layer.strokeColor = self.strokeColor.CGColor;
    
    layer.lineWidth = self.lineWidth;
    layer.miterLimit = self.miterLimit;
    
    layer.lineCap = self.lineCap;
    layer.lineJoin = self.lineJoin;
    
    layer.fillRule = self.fillRule;
    
    
    layer.lineDashPattern = [self.lineDashPattern copy];
    layer.lineDashPhase = self.lineDashPhase;
    
    layer.grade = self.grade;
    layer.ISInverted = self.ISInverted;
    layer.value = self.value;
    
    layer.cornerRadius = self.cornerRadius;
    return layer;
}

- (JFBarPath*)jf_JFBarPath{
    JFBarPath* path = [[JFBarPath alloc] init];
    
    path.lineWidth = self.lineWidth;
    path.miterLimit = self.miterLimit;
    
    path.lineCapStyle = [DTGraphicsConverter lineCapFromCALineCap:self.lineCap];
    path.lineJoinStyle = [DTGraphicsConverter lineJoinFromCALineJoin:self.lineJoin];
    
    path.usesEvenOddFillRule = (self.fillRule == kCAFillRuleEvenOdd);
    
    CGFloat phase = self.lineDashPhase;
    NSInteger count = self.lineDashPattern.count;
    CGFloat pattern[count];
    for (NSUInteger i = 0; i < count; i++) {
        pattern[i] = [[self.lineDashPattern objectAtIndex:i] floatValue];
    }
    [path setLineDash:pattern count:count phase:phase];
    
    return path;

}

@end
