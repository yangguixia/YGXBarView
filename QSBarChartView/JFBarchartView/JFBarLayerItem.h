//
//  JFBarLayerItem.h
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JFBarShaperLayer;
@class JFBarPath;

@interface JFBarLayerItem : NSObject

@property(nonatomic,assign)CGFloat lineWidth;
@property (nonatomic, strong) UIColor *strokeColor;

@property(nonatomic,strong)UIColor *fillColor;

@property(nonatomic,strong) NSString *fillRule;

@property(nonatomic) CGFloat miterLimit;

@property(nonatomic,strong) NSString *lineCap;

@property(nonatomic,strong) NSString *lineJoin;

@property(nonatomic,strong) NSArray *lineDashPattern;

@property(nonatomic,assign) CGFloat lineDashPhase;

@property(nonatomic,assign)CGFloat strokeStart;

@property(nonatomic,assign)CGFloat strokeEnd;

//
@property(nonatomic,assign)CGFloat grade;
@property(nonatomic,assign)BOOL ISInverted;
@property(nonatomic,assign)CGFloat cornerRadius;
@property(nonatomic,assign)CGFloat value;

-(JFBarShaperLayer*)jf_JFBarShaperLayer;

- (JFBarPath*)jf_JFBarPath;

@end
