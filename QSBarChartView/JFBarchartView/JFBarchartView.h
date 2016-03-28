//
//  JFBarchartView.h
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JFBarchartView;
@class JFBarLayerItem;

@protocol JFBarchartViewDataSource <NSObject>

- (NSUInteger)numberOfBarsInBarChartView:(JFBarchartView *)barChartView;

- (JFBarLayerItem*)barChartView:(JFBarchartView *)pieChart BarsdataItemAtIndex:(NSUInteger)index loopTime:(NSUInteger)looptime stop:(BOOL*)stop;


- (NSInteger)numberOfYLabelInBarChartView:(JFBarchartView *)barChartView;


- (NSInteger)numberOfXLabelInBarChartView:(JFBarchartView *)barChartView;

- (NSString*)stringOfYLabelInBarChartView:(JFBarchartView*)barChartView atIndex:(NSUInteger)index;

- (NSString*)stringOfXLabelInBarChartView:(JFBarchartView*)barChartView atIndex:(NSUInteger)index;

// index 从上到下 index开始值为1
- (JFBarLayerItem*)barChartView:(JFBarchartView *)pieChart YLinedataItemAtIndex:(NSUInteger)index;

- (JFBarLayerItem*)barChartView:(JFBarchartView *)pieChart XLinedataItemAtIndex:(NSUInteger)index atRightSide:(BOOL*)rightSide;

- (NSUInteger)baseLineIndexInBarChartView:(JFBarchartView*)barChartView;

//竖线条数

- (NSUInteger)numberOfXGapInBarChartView:(JFBarchartView *)barChartView;
@optional



@end


@protocol JFBarchartViewDelegate <NSObject>

@optional
/**
 * Callback method that gets invoked when the user taps on a chart bar.
 */
- (void)userClickedOnBarChartView:(JFBarchartView *)barChartView  atIndex:(NSInteger)barIndex;


@end

@interface JFBarchartView : UIView

@property(nonatomic,assign)id<JFBarchartViewDataSource> dataSource;
@property(nonatomic,assign)id<JFBarchartViewDelegate> delegate;

@property (nonatomic,assign)CGFloat yAxisLabelSideMargin;

@property (nonatomic) BOOL showXLabel;
/** How many labels on the x-axis to skip in between displaying labels. */
@property (nonatomic) NSInteger xLabelSkip;
/** Controls whether text for x-axis be straight or rotate 45 degree. */
@property (nonatomic) BOOL rotateForXAxisText;


- (void)reloadData;

@end
