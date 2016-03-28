//
//  JFBarChartItemFactory.h
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JFBarLayerItem;

@interface JFBarChartItemFactory : NSObject

+ (JFBarLayerItem*)dashLineItemDefault;

+ (JFBarLayerItem*)fullLineItemDefault;

+ (JFBarLayerItem*)gatLineItemDefault;

+ (JFBarLayerItem*)barItemDefault;

+ (JFBarLayerItem*)barHasColorItemDefault;

+ (JFBarLayerItem*)barHasColorItemDefault2;

@end
