//
//  JFBarShaperLayer.h
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface JFBarShaperLayer : CAShapeLayer

@property (nonatomic) float grade;

@property (nonatomic) BOOL ISInverted;

@property (nonatomic,assign)CGFloat value;

- (void)strokeLayer;

@end
