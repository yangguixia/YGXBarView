//
//  JFBarChartLabel.m
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import "JFBarChartLabel.h"

@implementation JFBarChartLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.font                      = [UIFont boldSystemFontOfSize:11.0f];
        self.backgroundColor           = [UIColor clearColor];
        self.textAlignment             = NSTextAlignmentCenter;
        self.userInteractionEnabled    = YES;
        self.adjustsFontSizeToFitWidth = YES;
        self.numberOfLines             = 0;
        self.textColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:11.0f];
    }
    
    return self;
}

@end
