//
//  JFBarChartItemFactory.m
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import "JFBarChartItemFactory.h"
#import "JFBarLayerItem.h"

@implementation JFBarChartItemFactory

+ (JFBarLayerItem*)dashLineItemDefault{
    
    JFBarLayerItem* item = [[JFBarLayerItem alloc] init];
    
    item.lineWidth = 1.0;
    item.strokeColor = [UIColor grayColor];
    item.lineCap = kCALineCapButt;
    
    item.lineDashPhase = 2;
    item.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil];
    return item;
}

+ (JFBarLayerItem*)fullLineItemDefault{
    JFBarLayerItem* item = [[JFBarLayerItem alloc] init];
    
    item.lineWidth = 1.0;
    item.strokeColor = [UIColor grayColor];
    item.lineCap = kCALineCapButt;
    
    return item;
}

+ (JFBarLayerItem*)gatLineItemDefault{
    JFBarLayerItem* item = [[JFBarLayerItem alloc] init];
    
    item.lineWidth = 1.0;
    item.strokeColor = [UIColor grayColor];
    item.lineCap = kCALineCapButt;
    
    return item;
}

+ (JFBarLayerItem*)barItemDefault{
    JFBarLayerItem* item = [[JFBarLayerItem alloc] init];
    
    item.lineWidth = 1.0;
    item.strokeColor = [UIColor greenColor];//[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:35./255.];
    item.fillColor = [UIColor greenColor];//[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:35./255.];
    item.lineCap = kCALineCapButt;
    item.grade = 1.0;
    item.ISInverted = NO;
    item.cornerRadius = 3.0;
    return item;
}

+ (JFBarLayerItem*)barItemDefaultInverted{
    JFBarLayerItem* item = [[JFBarLayerItem alloc] init];
    
    item.lineWidth = 1.0;
    item.strokeColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:35./255.];
    item.fillColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:35./255.];
    item.lineCap = kCALineCapButt;
    item.grade = 1.0;
    item.ISInverted = NO;
    item.cornerRadius = 3.0;
    item.ISInverted = YES;
    return item;
}


+ (JFBarLayerItem*)barHasColorItemDefault{
    JFBarLayerItem* item = [[JFBarLayerItem alloc] init];
    
    item.lineWidth = 1.0;
    item.strokeColor = [UIColor blueColor];
    item.fillColor = [UIColor blueColor];
    item.lineCap = kCALineCapButt;
    item.grade = .1;
    item.ISInverted = NO;
    item.cornerRadius = 3.0;
    item.value = 200;
    return item;
}

+ (JFBarLayerItem*)barHasColorItemDefault2{
    JFBarLayerItem* item = [[JFBarLayerItem alloc] init];
    
    item.lineWidth = 1.0;
    item.strokeColor = [UIColor redColor];
    item.fillColor = [UIColor redColor];
    item.lineCap = kCALineCapButt;
    item.grade = .5;
    item.ISInverted = NO;
    item.cornerRadius = 3.0;
    item.value = 100;
    return item;
}

@end
