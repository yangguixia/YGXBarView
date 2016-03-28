//
//  ViewController.m
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import "ViewController.h"

#import "JFBarchartView.h"
#import "JFBarChartItemFactory.h"

@interface ViewController ()<JFBarchartViewDataSource,JFBarchartViewDelegate>

@property(nonatomic,strong)JFBarchartView* pieView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.pieView = [[JFBarchartView alloc] initWithFrame:CGRectMake(20, 80, CGRectGetWidth(self.view.frame) - 40, 290)];
    self.pieView.dataSource = self;
    self.pieView.delegate = self;
    self.pieView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pieView];
    
    [self.pieView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSUInteger)numberOfBarsInBarChartView:(JFBarchartView *)barChartView{
    return 15;
}

- (JFBarLayerItem*)barChartView:(JFBarchartView *)pieChart BarsdataItemAtIndex:(NSUInteger)index loopTime:(NSUInteger)looptime stop:(BOOL*)stop{
    
    if(index != 1 && index != 3 && index != 6 && index != 8 && index != 11 && index != 13){
        return nil;
    }
    
    if(looptime == 0){
       return  [JFBarChartItemFactory barItemDefault];
    }else if(looptime == 1 && index == 1){
        return [JFBarChartItemFactory barHasColorItemDefault2];
    }else{
        *stop = YES;
        return [JFBarChartItemFactory barHasColorItemDefault];
    }
}

- (JFBarLayerItem*)barChartView:(JFBarchartView *)pieChart BarsdataItemAtIndex:(NSUInteger)index stop:(BOOL*)stop{
    return nil;
}

- (NSInteger)numberOfYLabelInBarChartView:(JFBarchartView *)barChartView{
    return 8;
}


- (NSInteger)numberOfXLabelInBarChartView:(JFBarchartView *)barChartView{
    return 3;
}

- (NSString*)stringOfYLabelInBarChartView:(JFBarchartView*)barChartView atIndex:(NSUInteger)index{
    return @"2100";
}

- (NSString*)stringOfXLabelInBarChartView:(JFBarchartView*)barChartView atIndex:(NSUInteger)index{
    switch (index) {
        case 0:
            return @"寿险";
            break;
        case 1:
            return @"意外险";
            break;
        case 2:
            return @"终极险";
            break;
        default:
            break;
    }
    return nil;
}

- (JFBarLayerItem*)barChartView:(JFBarchartView *)pieChart YLinedataItemAtIndex:(NSUInteger)index{
    if(index == 8){
        return [JFBarChartItemFactory fullLineItemDefault];
    }
    return [JFBarChartItemFactory dashLineItemDefault];
}

- (JFBarLayerItem*)barChartView:(JFBarchartView *)pieChart XLinedataItemAtIndex:(NSUInteger)index atRightSide:(BOOL *)rightSide{
    if(index != 0 && index != 5 && index != 10 && index != 14){
        return nil;
    }
    if(index == 14){
        *rightSide = YES;
    }
    return [JFBarChartItemFactory gatLineItemDefault];
}

- (NSUInteger)numberOfXGapInBarChartView:(JFBarchartView *)barChartView{
    return 15;
}

- (NSUInteger)baseLineIndexInBarChartView:(JFBarchartView*)barChartView{
    return 7;
}
@end
