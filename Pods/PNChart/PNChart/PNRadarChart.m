//
//  PNRadarChart.m
//  PNChartDemo
//
//  Created by Lei on 15/7/1.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

#import "PNRadarChart.h"

@interface PNRadarChart()

@property (nonatomic) CGFloat centerX; // x轴
@property (nonatomic) CGFloat centerY; // y轴
@property (nonatomic) NSMutableArray *pointsToWebArrayArray; // 所有的坐标钱点
@property (nonatomic) NSMutableArray *pointsToPlotArray; // 根据value获取到所有定位的点
@property (nonatomic) UILabel *detailLabel; // 点击实现的Label，暂时可以无视他
@property (nonatomic) CGFloat lengthUnit; // 每个长度对应的
@property (nonatomic) CAShapeLayer *chartPlot; // 用来画中心区域的效果Layer

@end


@implementation PNRadarChart

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items valueDivider:(CGFloat)unitValue {
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        //Public iVar
        if ([items count]< 3)//At least three corners of A polygon ,If the count of items is less than 3 will add 3 default values
        {
            NSLog( @"At least three items!");
            NSArray *defaultArray = @[[PNRadarChartDataItem dataItemWithValue:0 description:@"Default"],
                                      [PNRadarChartDataItem dataItemWithValue:0 description:@"Default"],
                                      [PNRadarChartDataItem dataItemWithValue:0 description:@"Default"],
                                      ];
            defaultArray = [defaultArray arrayByAddingObjectsFromArray:items];
            _chartData = [NSArray arrayWithArray:defaultArray];
        }else{
            _chartData = [NSArray arrayWithArray:items];
        }
        _valueDivider = unitValue;
        _maxValue = 1;
        _webColor = [UIColor redColor];
        _plotColor = [UIColor colorWithRed:.1 green:.3 blue:.4 alpha:.7];
        _fontColor = [UIColor blackColor];
        _graduationColor = [UIColor redColor];
        _fontSize = 15;
        _labelStyle = PNRadarChartLabelStyleHorizontal;
        _isLabelTouchable = YES;
        _isShowGraduation = NO;
        
        //Private iVar
        _centerX = frame.size.width/2;
        _centerY = frame.size.height/2;
        _pointsToWebArrayArray = [NSMutableArray array];
        _pointsToPlotArray = [NSMutableArray array];
        _lengthUnit = 0;
        _chartPlot = [CAShapeLayer layer];
        _chartPlot.lineCap = kCALineCapButt;
        _chartPlot.lineWidth = 1.0;
        [self.layer addSublayer:_chartPlot];
        
        [super setupDefaultValues];
        //init detailLabel
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.1 alpha:.9];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        [_detailLabel setHidden:YES];
        [self addSubview:_detailLabel];
        
        [self strokeChart];
    }
    return self;
}

#pragma mark - main

/**
 主要计算的核心方法
 */
- (void)calculateChartPoints {
    // 区域
    [_pointsToPlotArray removeAllObjects];
    // 区域分割线
    [_pointsToWebArrayArray removeAllObjects];
    
    //init Descriptions , Values and Angles.
    // 描述数组
    NSMutableArray *descriptions = [NSMutableArray array];
    // 对应的值
    NSMutableArray *values = [NSMutableArray array];
    // 计算出平均的角度 例如五个 就是从 1 / 5 * 3.14进行分配，而且正数是顺时针旋转分配  负数是逆时针
    NSMutableArray *angles = [NSMutableArray array];
    // 根据传入的数组进行遍历
    for (int i=0;i<_chartData.count;i++) {
        PNRadarChartDataItem *item = (PNRadarChartDataItem *)[_chartData objectAtIndex:i];
        [descriptions addObject:item.textDescription];
        [values addObject:[NSNumber numberWithFloat:item.value]];
        CGFloat angleValue = (float)i/(float)[_chartData count]*2*M_PI;
        angleValue += -18.0 / 360.0 * 2 * M_PI;
        [angles addObject:[NSNumber numberWithFloat:angleValue]];
    }
    
    //calculate all the lengths 最大values
    _maxValue = [self getMaxValueFromArray:values];
    CGFloat margin = 0;
    if (_labelStyle==PNRadarChartLabelStyleCircle) {
        margin = MIN(_centerX , _centerY)*3/10;
    }else if (_labelStyle==PNRadarChartLabelStyleHorizontal) {
        margin = [self getMaxWidthLabelFromArray:descriptions withFontSize:_fontSize];
    }
    // 最大长度 根据最小边获取  例如 宽度 30   高度 1000   那么maxLength也就是15
    CGFloat maxLength = ceil(MIN(_centerX, _centerY) - margin);
    // 多少圈
    int plotCircles = (_maxValue/_valueDivider);
    
    // 最多只有20圈
    if (plotCircles > MAXCIRCLE) {
        NSLog(@"Circle number is higher than max");
        plotCircles = MAXCIRCLE;
        _valueDivider = _maxValue/plotCircles;
    }
    
    // 每一圈的长度
    _lengthUnit = maxLength/plotCircles;
    
    /**
     plotCircles是多少圈
     lengthUnit是每一圈的长度（往外扩张的长度）
     计算出数组，例如10圈
     8.4,
     16.8,
     25.2,
     33.6,
     42,
     50.4,
     58.8,
     67.2,
     75.6,
     84
     */
    NSArray *lengthArray = [self getLengthArrayWithCircleNum:(int)plotCircles];
    
    //get all the points and plot
    // 获取到所有对应的坐标点  一圈圈往外画
    for (NSNumber *lengthNumber in lengthArray) {
        CGFloat length = [lengthNumber floatValue];
        [_pointsToWebArrayArray addObject:[self getWebPointWithLength:length angleArray:angles]];
    }
    // 计算出对应的value点  item几个就计算几个出来
    int section = 0;
    for (id value in values) {
        CGFloat valueFloat = [value floatValue];
        if (valueFloat>_maxValue) {
            NSString *reason = [NSString stringWithFormat:@"Value number is higher than max -value: %f - maxValue: %f",valueFloat,_maxValue];
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            return;
        }
        
        CGFloat length = valueFloat/_maxValue*maxLength;
        CGFloat angle = [[angles objectAtIndex:section] floatValue];
        CGFloat x = _centerX +length*cos(angle);
        CGFloat y = _centerY +length*sin(angle);
        NSValue* point = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        [_pointsToPlotArray addObject:point];
        section++;
    }
    // set the labels
    // 设置label的位置
    [self drawLabelWithMaxLength:maxLength labelArray:descriptions angleArray:angles];
    
}
#pragma mark - Draw

/**
 画圈圈线和画切割线
 
 @param rect <#rect description#>
 */
- (void)drawRect:(CGRect)rect {
    // Drawing backgound
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    int section = 0;
    int row = 0;
    // circles
    for(NSArray *pointArray in _pointsToWebArrayArray){
        // 这段代码可以过滤掉内部所有的线，只留一根最外部的
//        if (!(row == _pointsToWebArrayArray.count - 1)) {
//            row ++;
//            continue;
//        }
        // plot backgound
        CGContextRef graphContext = UIGraphicsGetCurrentContext();
        CGContextBeginPath(graphContext);
        CGPoint beginPoint = [[pointArray objectAtIndex:0] CGPointValue];
        CGContextMoveToPoint(graphContext, beginPoint.x, beginPoint.y);
        for(NSValue* pointValue in pointArray){
            CGPoint point = [pointValue CGPointValue];
            CGContextAddLineToPoint(graphContext, point.x, point.y);
        }
        CGContextAddLineToPoint(graphContext, beginPoint.x, beginPoint.y);
        CGContextSetStrokeColorWithColor(graphContext, _webColor.CGColor);
        CGContextStrokePath(graphContext);
        
    }
    // cuts
    NSArray *largestPointArray = [_pointsToWebArrayArray lastObject];
    for (NSValue *pointValue in largestPointArray){
        section++;
        if (section==1&&_isShowGraduation)continue;
        
        CGContextRef graphContext = UIGraphicsGetCurrentContext();
        CGContextBeginPath(graphContext);
        CGContextMoveToPoint(graphContext, _centerX, _centerY);
        CGPoint point = [pointValue CGPointValue];
        CGContextAddLineToPoint(graphContext, point.x, point.y);
        CGContextSetStrokeColorWithColor(graphContext, _webColor.CGColor);
        CGContextStrokePath(graphContext);
    }
    
    
}

/**
 初始化的时候调用
 */
- (void)strokeChart {
    
    [self calculateChartPoints];
    // 会调用drawInRect进行重绘
    [self setNeedsDisplay];
    [_detailLabel setHidden:YES];
    
    //Draw plot
    // 画中心区域的动画Layer静态效果
    [_chartPlot removeAllAnimations];
    UIBezierPath *plotline = [UIBezierPath bezierPath];
    CGPoint beginPoint = [[_pointsToPlotArray objectAtIndex:0] CGPointValue];
    [plotline moveToPoint:CGPointMake(beginPoint.x, beginPoint.y)];
    for(NSValue *pointValue in _pointsToPlotArray){
        CGPoint point = [pointValue CGPointValue];
        [plotline addLineToPoint:CGPointMake(point.x ,point.y)];
        
    }
    [plotline setLineWidth:1];
    [plotline setLineCapStyle:kCGLineCapSquare];
    
    _chartPlot.path = plotline.CGPath;
    
    _chartPlot.fillColor = _plotColor.CGColor;
    
    [self addAnimationIfNeeded];
    [self showGraduation];
}

#pragma mark - Helper
// 设置Label标签
- (void)drawLabelWithMaxLength:(CGFloat)maxLength labelArray:(NSArray *)labelArray angleArray:(NSArray *)angleArray {
    //set labels
    int labelTag = 121;
    while (true) {
        UIView *label = [self viewWithTag:labelTag];
        if(!label)break;
        [label removeFromSuperview];
    }
    int section = 0;
    CGFloat labelLength = maxLength + maxLength/10;
    
    for (NSString *labelString in labelArray) {
        CGFloat angle = [[angleArray objectAtIndex:section] floatValue];
        CGFloat x = _centerX + labelLength *cos(angle);
        CGFloat y = _centerY + labelLength *sin(angle);
        
        UILabel *label = [[UILabel alloc] init] ;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:_fontSize];
        label.text = labelString;
        label.tag = labelTag;
        CGSize detailSize = [labelString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_fontSize]}];
        
        switch (_labelStyle) {
            case PNRadarChartLabelStyleCircle:
                label.frame = CGRectMake(x-5*_fontSize/2, y-_fontSize/2, 5*_fontSize, _fontSize);
                label.transform = CGAffineTransformMakeRotation(((float)section/[labelArray count])*(2*M_PI)+M_PI_2);
                label.textAlignment = NSTextAlignmentCenter;
                
                break;
            case PNRadarChartLabelStyleHorizontal:
                if (x<_centerX) {
                    label.frame = CGRectMake(x-detailSize.width, y-detailSize.height/2, detailSize.width, detailSize.height);
                    label.textAlignment = NSTextAlignmentRight;
                }else{
                    label.frame = CGRectMake(x, y-detailSize.height/2, detailSize.width , detailSize.height);
                    label.textAlignment = NSTextAlignmentLeft;
                }
                break;
            case PNRadarChartLabelStyleHidden:
                [label setHidden:YES];
                break;
            default:
                break;
        }
        [label sizeToFit];
        
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapLabelGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel:)];
        [label addGestureRecognizer:tapLabelGesture];
        [self addSubview:label];
        
        section ++;
    }
    
}

- (void)tapLabel:(UITapGestureRecognizer *)recognizer {
    UILabel *label=(UILabel*)recognizer.view;
    _detailLabel.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y-30, 50, 25);
    for (PNRadarChartDataItem *item in _chartData) {
        if ([label.text isEqualToString:item.textDescription]) {
            _detailLabel.text =  [NSString stringWithFormat:@"%.2f", item.value];
            break;
        }
    }
    [_detailLabel setHidden:NO];
    
}

- (void)showGraduation {
    int labelTag = 112;
    while (true) {
        UIView *label = [self viewWithTag:labelTag];
        if(!label)break;
        [label removeFromSuperview];
    }
    int section = 0;
    for (NSArray *pointsArray in _pointsToWebArrayArray) {
        section++;
        CGPoint labelPoint = [[pointsArray objectAtIndex:0] CGPointValue];
        UILabel *graduationLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelPoint.x-_lengthUnit, labelPoint.y-_lengthUnit*5/8, _lengthUnit*5/8, _lengthUnit)];
        graduationLabel.adjustsFontSizeToFitWidth = YES;
        graduationLabel.tag = labelTag;
        graduationLabel.font = [UIFont systemFontOfSize:ceil(_lengthUnit)];
        graduationLabel.textColor = [UIColor orangeColor];
        graduationLabel.text = [NSString stringWithFormat:@"%.0f",_valueDivider*section];
        [self addSubview:graduationLabel];
        if (_isShowGraduation) {
            [graduationLabel setHidden:NO];
        }else{
            [graduationLabel setHidden:YES];}
    }
    
}

// 类似波纹往外扩散，从小到大，每一层一个长度，然后根据角度数组进行每个点的坐标布局，例如你有五个item，没个item在每个长度的地方进行坐标的打点
- (NSArray *)getWebPointWithLength:(CGFloat)length angleArray:(NSArray *)angleArray {
    NSMutableArray *pointArray = [NSMutableArray array];
    for (NSNumber *angleNumber in angleArray) {
        CGFloat angle = [angleNumber floatValue];
        CGFloat x = _centerX + length*cos(angle);
        CGFloat y = _centerY + length*sin(angle);
        [pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(x,y)]];
    }
    return pointArray;
    
}


/**
 根据有多少圈  最大20圈，以及每一圈有多少长，进行一个数组存储
 
 @param plotCircles <#plotCircles description#>
 @return <#return value description#>
 */
- (NSArray *)getLengthArrayWithCircleNum:(int)plotCircles {
    NSMutableArray *lengthArray = [NSMutableArray array];
    CGFloat length = 0;
    for (int i = 0; i < plotCircles; i++) {
        length += _lengthUnit;
        [lengthArray addObject:[NSNumber numberWithFloat:length]];
    }
    return lengthArray;
}

- (CGFloat)getMaxWidthLabelFromArray:(NSArray *)keyArray withFontSize:(CGFloat)size {
    CGFloat maxWidth = 0;
    for (NSString *str in keyArray) {
        CGSize detailSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_fontSize]}];
        maxWidth = MAX(maxWidth, detailSize.width);
    }
    return maxWidth;
}

/**
 算出最大value的值  外部不给默认的时候就是默认为1，如果外部给的其他的就要进行比较
 */
- (CGFloat)getMaxValueFromArray:(NSArray *)valueArray {
    CGFloat max = _maxValue;
    for (NSNumber *valueNum in valueArray) {
        CGFloat valueFloat = [valueNum floatValue];
        max = MAX(valueFloat, max);
    }
    return ceil(max);
}

// 加个动画
- (void)addAnimationIfNeeded
{
    // 默认加动画
    if (self.displayAnimated) {
        CABasicAnimation *animateScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animateScale.fromValue = [NSNumber numberWithFloat:0.f];
        animateScale.toValue = [NSNumber numberWithFloat:1.0f];
        
        CABasicAnimation *animateMove = [CABasicAnimation animationWithKeyPath:@"position"];
        animateMove.fromValue = [NSValue valueWithCGPoint:CGPointMake(_centerX, _centerY)];
        animateMove.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        
        CABasicAnimation *animateAlpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animateAlpha.fromValue = [NSNumber numberWithFloat:0.f];
        
        CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
        aniGroup.duration = 2.f;
        aniGroup.repeatCount = 1;
        aniGroup.animations = [NSArray arrayWithObjects:animateScale,animateMove,animateAlpha, nil];
        aniGroup.removedOnCompletion = YES;
        
        [_chartPlot addAnimation:aniGroup forKey:nil];
    }
}

@end
