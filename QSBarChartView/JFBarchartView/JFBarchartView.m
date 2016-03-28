//
//  JFBarchartView.m
//  QSBarChartView
//
//  Created by 秦山 on 15-5-25.
//  Copyright (c) 2015年 dfhe. All rights reserved.
//

#import "JFBarchartView.h"
#import "JFBarPath.h"
#import "JFBarLayerItem.h"
#import "JFBarShaperLayer.h"
#import "JFBarChartLabel.h"

#define BOTTOM_MARGIN_TO_LEAVE 30.0
#define TOP_MARGIN_TO_LEAVE 10

#define LINE_WIDTH (self.bounds.size.width - _leftMarginToLeave)

#define kJFBarChartBackGroundColor [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4]
#define kJFLightGrey     [UIColor colorWithRed:225.0 / 255.0 green:225.0 / 255.0 blue:225.0 / 255.0 alpha:1.0f]

#define kLayerTag   @"layerTag"

@interface JFBarchartView (){
    float _leftMarginToLeave;
    CGFloat _xLabelWidth;
}

@end

@implementation JFBarchartView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        _leftMarginToLeave = 0;
        self.yAxisLabelSideMargin = 10;
        self.showXLabel = YES;
        self.xLabelSkip = 1;
        
    }
    return self;
}


- (void)reloadData{
    
    [self drawYLabels];
    [self drawXLabels];
    [self drawYLines];
    [self drawXLines];
    
    [self drawBars];
    
    [self setupTagGustrueRecognizer];
}

- (void)setupTagGustrueRecognizer{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)handleTap:(UITapGestureRecognizer*)tap
{
    if(tap.state != UIGestureRecognizerStateEnded)
        return;
    
    CGPoint pos = [tap locationInView:tap.view];
    
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        if (view.tag == 1000) {
            [view removeFromSuperview];
        }
    }
    for(CALayer* layer in self.layer.sublayers){
        if(![layer isKindOfClass:[JFBarShaperLayer class]]){
            continue;
        }
        
        JFBarShaperLayer* tappedLayer = (JFBarShaperLayer*)layer;
        
        NSString* layerTag = [tappedLayer valueForKeyPath:kLayerTag];
        if(layerTag == nil){
            continue;
        }
        
        if (CGRectContainsPoint(tappedLayer.frame, pos)) {
            
            UIView *layView = [[UIView alloc]initWithFrame:CGRectMake(tappedLayer.frame.origin.x-5, tappedLayer.frame.size.height*(1-tappedLayer.grade)-10,tappedLayer.frame.size.width+10, 15)];
            layView.tag = 1000;
            layView.backgroundColor = [UIColor colorWithCGColor:tappedLayer.strokeColor];//[UIColor greenColor];
            [self addSubview:layView];
            
            UIBezierPath *rectPath1 = [UIBezierPath bezierPathWithRoundedRect:layView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
            [rectPath1 moveToPoint:CGPointMake(layView.frame.size.width/2, layView.frame.size.height+5)];
            [rectPath1 addLineToPoint:CGPointMake(layView.frame.size.width/2-5, layView.frame.size.height)];
            [rectPath1 addLineToPoint:CGPointMake(layView.frame.size.width/2+5, layView.frame.size.height)];
            
            CAShapeLayer  *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = rectPath1.CGPath;
            shapeLayer.lineCap = kCALineCapButt;
            shapeLayer.fillColor = [[UIColor colorWithCGColor:tappedLayer.strokeColor] CGColor];
            [layView.layer addSublayer:shapeLayer];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, layView.frame.size.width, layView.frame.size.height)];
            label.text = [NSString stringWithFormat:@"%.2f",tappedLayer.value];
            label.font = [UIFont systemFontOfSize:8];
            label.minimumScaleFactor = 2.0;
            label.textAlignment = NSTextAlignmentCenter;
            [layView addSubview:label];
            
            if (tappedLayer.value < 0) {
                layView.frame = CGRectMake(tappedLayer.frame.origin.x-5, tappedLayer.frame.origin.y-20,tappedLayer.frame.size.width+10, 15);
            }
            
            break;
        }
        index++;
    }
}

- (void)drawBars{
    NSUInteger yAxisCount = [self.dataSource numberOfYLabelInBarChartView:self];
    NSUInteger baseLineIndex = [self.dataSource baseLineIndexInBarChartView:self];
    
    double verticalGap = (self.bounds.size.height  - BOTTOM_MARGIN_TO_LEAVE - TOP_MARGIN_TO_LEAVE) / (yAxisCount -1);
    CGFloat chartCavanUpHeight = verticalGap*baseLineIndex;
    CGFloat chartCavanDownHeight =  verticalGap*(yAxisCount -1 -baseLineIndex);
    CGFloat chartBaseLineYPosition = verticalGap*(baseLineIndex)+TOP_MARGIN_TO_LEAVE;
    
    NSUInteger dataCount = [self.dataSource numberOfBarsInBarChartView:self];
    double intervalInPx = (self.bounds.size.width - _leftMarginToLeave) / (dataCount );
    
    for(NSInteger index = 0;index < dataCount;index++){
        
        BOOL stop = NO;
        NSUInteger loopTime = 0;
        while (!stop) {
            JFBarLayerItem* item = [self.dataSource barChartView:self BarsdataItemAtIndex:index loopTime:loopTime stop:&stop];
            if(item == nil){
                break;
            }
            
            JFBarShaperLayer* linesLayer = [item jf_JFBarShaperLayer];
            if(stop){
                [linesLayer setValue:[NSString stringWithFormat:@"%ld",(long)index] forKeyPath:kLayerTag];
            }
            
            CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave+ (index * intervalInPx), TOP_MARGIN_TO_LEAVE);
            
            CGRect frame = CGRectZero;
            if (item.ISInverted == NO) {
                frame = CGRectMake(currentLinePoint.x, TOP_MARGIN_TO_LEAVE, intervalInPx, chartCavanUpHeight);
            }
            else{
                frame = CGRectMake(currentLinePoint.x, chartBaseLineYPosition, intervalInPx, chartCavanDownHeight);
            }
            
            linesLayer.frame = frame;
            [linesLayer strokeLayer];
            [self.layer addSublayer:linesLayer];
            
            
            loopTime++;
        }
    }
    
}

- (void)drawXLines{
    
    NSUInteger dataCount = [self.dataSource numberOfXGapInBarChartView:self];
    double intervalInPx = (self.bounds.size.width - _leftMarginToLeave) / (dataCount );
    
    for(NSInteger index = 0;index < dataCount;index++){
        
        BOOL rightSide = NO;
        JFBarLayerItem* item = [self.dataSource barChartView:self XLinedataItemAtIndex:index atRightSide:&rightSide];
        
        if(item == nil){
            continue;
        }
        
        JFBarShaperLayer* linesLayer = [item jf_JFBarShaperLayer];
        JFBarPath* progressline = [item jf_JFBarPath];
        
        CGPoint currentLinePoint;
        if(rightSide == NO){
            currentLinePoint = CGPointMake(_leftMarginToLeave + (index * intervalInPx), TOP_MARGIN_TO_LEAVE);
        }else{
            currentLinePoint = CGPointMake(_leftMarginToLeave + (index * intervalInPx) + intervalInPx-1, TOP_MARGIN_TO_LEAVE);
        }
        
        [progressline moveToPoint:CGPointMake(currentLinePoint.x, currentLinePoint.y)];
        [progressline addLineToPoint:CGPointMake(currentLinePoint.x,  CGRectGetHeight(self.frame) - BOTTOM_MARGIN_TO_LEAVE+5)];
        
        linesLayer.path = progressline.CGPath;
        
        [self.layer addSublayer:linesLayer];
    }
}

- (void)drawYLines{
    
    NSUInteger dataCount = [self.dataSource numberOfYLabelInBarChartView:self];
    
    NSUInteger gapCount = dataCount>1?dataCount-1:dataCount;
    
    CGFloat intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE - TOP_MARGIN_TO_LEAVE) / (gapCount );
    for(NSInteger index=dataCount;index>0;index--){
        
        JFBarLayerItem* item = [self.dataSource barChartView:self YLinedataItemAtIndex:index];
        
        JFBarShaperLayer* linesLayer = [item jf_JFBarShaperLayer];
        JFBarPath* progressline = [item jf_JFBarPath];
        
        CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, (index-1) * intervalInPx+TOP_MARGIN_TO_LEAVE);
        
        [progressline moveToPoint:CGPointMake(currentLinePoint.x, currentLinePoint.y)];
        [progressline addLineToPoint:CGPointMake(currentLinePoint.x + LINE_WIDTH,  currentLinePoint.y)];
        
        linesLayer.path = progressline.CGPath;
        
        [self.layer addSublayer:linesLayer];
        
    }
    
}


- (void)drawXLabels{
    
    if(!self.showXLabel)
        return;
    
    NSUInteger dataCount = [self.dataSource numberOfXLabelInBarChartView:self];
    
    _xLabelWidth = (LINE_WIDTH) / dataCount;
    int labelAddCount = 0;
    for (int index = 0; index < dataCount; index++) {
        labelAddCount += 1;
        
        if (labelAddCount == _xLabelSkip) {
            NSString *labelText = [self.dataSource stringOfXLabelInBarChartView:self atIndex:index];
            JFBarChartLabel * label = [[JFBarChartLabel alloc] initWithFrame:CGRectMake(0, 0, _xLabelWidth, BOTTOM_MARGIN_TO_LEAVE)];
            [label setTextAlignment:NSTextAlignmentCenter];
            label.text = labelText;
            //[label sizeToFit];
            CGFloat labelXPosition;
            if (_rotateForXAxisText){
                label.transform = CGAffineTransformMakeRotation(M_PI / 4);
                labelXPosition = (index *  _xLabelWidth + _leftMarginToLeave + _xLabelWidth /1.5);
            }
            else{
                labelXPosition = (index *  _xLabelWidth + _leftMarginToLeave + _xLabelWidth /2.0 );
            }
            label.center = CGPointMake(labelXPosition,
                                       self.frame.size.height - BOTTOM_MARGIN_TO_LEAVE + label.frame.size.height /2.0);
            labelAddCount = 0;
            
            //[_xChartLabels addObject:label];
            [self addSubview:label];
        }
    }
    
}


- (void)drawYLabels{
    NSUInteger dataCount = [self.dataSource numberOfYLabelInBarChartView:self];
    
    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE - TOP_MARGIN_TO_LEAVE) / (dataCount-1);
    
    NSMutableArray *labelArray = [NSMutableArray array];
    float maxWidth = 0;
    
    for(NSUInteger i= dataCount; i > 0; i--){
        CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, (i-1) * intervalInPx+TOP_MARGIN_TO_LEAVE);
        CGRect lableFrame = CGRectMake(0, currentLinePoint.y - (intervalInPx / 2), 100, intervalInPx);
        
        if(i != 0) {
            JFBarChartLabel* yAxisLabel = [[JFBarChartLabel alloc]initWithFrame:lableFrame];
            
            NSString* yText = [self.dataSource stringOfYLabelInBarChartView:self atIndex:i-1];
            
            if(yText){
                yAxisLabel.text = yText;
            }else{
                yAxisLabel.text = @"";
            }
            
            [yAxisLabel sizeToFit];
            CGRect newLabelFrame = CGRectMake(0, currentLinePoint.y - (yAxisLabel.layer.frame.size.height / 2), yAxisLabel.frame.size.width, yAxisLabel.layer.frame.size.height);
            yAxisLabel.frame = newLabelFrame;
            if(newLabelFrame.size.width > maxWidth) {
                maxWidth = newLabelFrame.size.width;
            }
            
            [labelArray addObject:yAxisLabel];
            [self addSubview:yAxisLabel];
        }
    }
    
    _leftMarginToLeave = maxWidth + self.yAxisLabelSideMargin;
    
    for( UILabel *l in labelArray) {
        CGSize newSize = CGSizeMake(_leftMarginToLeave, l.frame.size.height);
        CGRect newFrame = l.frame;
        newFrame.size = newSize;
        l.frame = newFrame;
    }
}



@end
