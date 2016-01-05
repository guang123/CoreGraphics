//
//  ChartView.m
//  CoreGraphics
//
//  Created by Yx on 15/12/28.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "ChartView.h"

//Box gradient bg alpha
#define kBoxAlpha 0.95f

#define kGradientTitleBottomColor [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:kBoxAlpha]

#define kGradientTitleTopColor [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:kBoxAlpha]

#define CFTYPECAST(exp) (__bridge exp)

@interface ChartView ()
@property (strong, nonatomic) CAShapeLayer *backgroundLayer;//绘制填充色范围线
@property (strong, nonatomic) CAShapeLayer *graphPathLayer;//动画折线
@end

@implementation ChartView
@synthesize xAxis     = _xAxis;
@synthesize xAxisMark = _xAxisMark;
@synthesize yAxis     = _yAxis;
@synthesize yAxisMark = _yAxisMark;
@synthesize chartY;
@synthesize chartX;
@synthesize backgroundLayer;
@synthesize graphPathLayer;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self                 = [super initWithFrame:frame];
    if (self) {
    self.backgroundColor = [UIColor redColor];
    viewH                = frame.size.height;
    viewW                = frame.size.width;
    }
    return self;
}

#pragma mark set/get
- (void)setXAxis:(NSMutableArray *)axAxis{
    if (self.xAxis != nil) {
        _xAxis     = [axAxis mutableCopy];
    }
}

- (NSMutableArray *)xAxis{
    if (_xAxis == nil) {
        _xAxis     = [NSMutableArray array];
    }
    return  _xAxis;
}

- (void)setXAxisMark:(NSMutableArray *)xAxisMark{
    if (self.xAxisMark != nil) {
        _xAxisMark = [xAxisMark mutableCopy];
    }
}

- (NSMutableArray *)xAxisMark{
    if (_xAxisMark == nil) {
        _xAxisMark = [NSMutableArray array];
    }
    return _xAxisMark;
}

- (void)setYAxis:(NSMutableArray *)yAxis{
    if (self.yAxis != nil) {
        _yAxis     = [yAxis mutableCopy];
    }
}

- (NSMutableArray *)yAxis{
    if (_yAxis == nil) {
        _yAxis     = [NSMutableArray array];
    }
    return _yAxis;
}

- (void)setYAxisMark:(NSMutableArray *)yAxisMark{
    if (self.yAxisMark != nil) {
        _yAxisMark = [yAxisMark mutableCopy];
    }
}

- (NSMutableArray *)yAxisMark{
    if (_yAxisMark == nil) {
        _yAxisMark = [NSMutableArray array];
    }
    return _yAxisMark;
}

- (void)startDraw{
    [backgroundLayer removeFromSuperlayer];
    [graphPathLayer removeFromSuperlayer];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //计算表格高/宽度
    NSInteger chartH     = (_yAxisMark.count - 1) * self.yInterval;
    NSInteger chartW     = (_xAxisMark.count - 1) *self.xInterval;
    //图表起点（左上角）
    chartX               = 25;
    chartY               = 50;
    //1.取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
     NSLog(@"CGContextGetTypeID%lu",CGContextGetTypeID());
    //绘制竖线
    //2.创建路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    for (int i = 0 ; i < _xAxisMark.count; i++) {
        if (i == 0) {
            //移动到指定位置（设置路径起点）
            CGPathMoveToPoint(path, nil, chartX, chartY);
            //绘制直线（从起始位置开始）
            CGPathAddLineToPoint(path, nil, chartX, chartY + chartH);
        }else{
            CGPathMoveToPoint(path, nil, chartX + (i * self.xInterval), chartY);
            CGPathAddLineToPoint(path, nil, chartX + (i * self.xInterval), chartY + chartH);
        }
        //3.添加路径到图形上下文
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    }
    //绘制横线
    for (int j = 0; j < _yAxisMark.count; j++) {
        if (j == 0) {
            CGPathMoveToPoint(path, nil, chartX, chartY);
            CGPathAddLineToPoint(path, nil, chartX + chartW, chartY);
        }else{
            CGPathMoveToPoint(path, nil, chartX, chartY + (j * self.yInterval));
            CGPathAddLineToPoint(path, nil, chartX + chartW , chartY + (j * self.yInterval));
        }
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    //6.释放对象
    CGPathRelease(path);
    //绘制X轴标量
    UIFont *font = [UIFont systemFontOfSize:17];//设置字体
    UIColor *color = [UIColor whiteColor];//字体颜色
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];//段落样式
    NSTextAlignment align = NSTextAlignmentLeft;//对齐方式
    style.alignment = align;
    
    for (int j = 0; j < _xAxisMark.count; j++){
        CGRect rect = CGRectZero;
        if (j == 0) {
            rect = CGRectMake(0, chartH + chartY, 40, 21);
        }else{
            rect = CGRectMake((j * self.xInterval), chartH + chartY, 40, 21);
        }
        NSString *text = _xAxisMark[j];
        [text drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
    }

    //绘制Y标量
    for (int j = 0; j < _yAxisMark.count; j++){
        CGRect rect = CGRectZero;
        if (j == 0) {
            rect = CGRectMake(0, chartH + chartY - 20, 20, 21);
        }else{
            rect = CGRectMake(0, chartH + chartY - (j * self.yInterval) - 20, 20, 21);
        }
        NSString *text = _yAxisMark[j];
        [text drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
    }
    
    //绘制点坐标
    NSMutableArray *arrXAxis = [NSMutableArray array];
    NSMutableArray *arrYAxis = [NSMutableArray array];
    for (int i = 0; i < self.yAxis.count; i++) {
        NSString *str     = _yAxis[i];
        NSInteger radius  = 4;
        float y           = chartY + chartH - (self.percentage*[str intValue]);//5 为单位比例yInterval/每条线代表的单位
        CGContextAddEllipseInRect(context,CGRectMake(chartX + (i * self.xInterval) - (radius/2),y - (radius/2),radius,radius));
        CGContextDrawPath(context, kCGPathFillStroke);
        float xCoordinate = chartX + (i * self.xInterval);
        float yCoordinate = y;
        [arrXAxis addObject:[NSNumber numberWithFloat:xCoordinate]];
        [arrYAxis addObject:[NSNumber numberWithFloat:yCoordinate]];
    }
    
    //连线
    if (self.chartType == ChartTypeDefault) {
        CGMutablePathRef pathLine = CGPathCreateMutable();
        for (int j = 0; j < arrYAxis.count - 1; j++) {
            CGPathMoveToPoint(pathLine, nil, [arrXAxis[j] floatValue], [arrYAxis[j] floatValue]);
            CGPathAddLineToPoint(pathLine, nil, [arrXAxis[j+1] floatValue] , [arrYAxis[j+1] floatValue]);
            CGContextAddPath(context, pathLine);
            CGContextDrawPath(context, kCGPathEOFillStroke);
        }
        CGPathRelease(pathLine);
    }else{

        if(self.chartType == ChartTypeAnimationAndFillColor){
            backgroundLayer                 = [CAShapeLayer layer];
            backgroundLayer.frame           = self.bounds;
            //填充色
            backgroundLayer.fillColor       = [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:0.5].CGColor;
            backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
            [backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
            [backgroundLayer setLineWidth:1];
            CGMutablePathRef backgroundPath = CGPathCreateMutable();
            CGPathMoveToPoint(backgroundPath, nil, [arrXAxis[0] floatValue], [arrYAxis[0] floatValue]);
            for (int j                      = 0; j < arrYAxis.count - 1; j++) {
                CGPathAddLineToPoint(backgroundPath, nil, [arrXAxis[j+1] floatValue] , [arrYAxis[j+1] floatValue]);
            }
            CGPathAddLineToPoint(backgroundPath, nil, [arrXAxis[arrXAxis.count-1] floatValue] , chartY + ((arrXAxis.count-1) * self.yInterval));
            CGPathAddLineToPoint(backgroundPath, nil, chartX, chartY + ((arrXAxis.count-1) * self.yInterval));
            CGPathCloseSubpath(backgroundPath);
            backgroundLayer.path            = backgroundPath;
            backgroundLayer.zPosition       = 0;
            [self.layer addSublayer:backgroundLayer];
            CGPathRelease(backgroundPath);
        }

        graphPathLayer                 = [CAShapeLayer layer];
        graphPathLayer.frame           = self.bounds;
        graphPathLayer.fillColor       = [UIColor clearColor].CGColor;
        graphPathLayer.backgroundColor = [UIColor clearColor].CGColor;
        [graphPathLayer setStrokeColor:[UIColor greenColor].CGColor];
        [graphPathLayer setLineWidth:2];
        CGMutablePathRef pathLine = CGPathCreateMutable();
        for (int j = 0; j < arrYAxis.count - 1; j++) {
            CGPathMoveToPoint(pathLine, nil, [arrXAxis[j] floatValue], [arrYAxis[j] floatValue]);
            CGPathAddLineToPoint(pathLine, nil, [arrXAxis[j+1] floatValue] , [arrYAxis[j+1] floatValue]);
        }
        graphPathLayer.path         = pathLine;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration          = 1;
        animation.fromValue         = @(0.0);
        animation.toValue           = @(1.0);
        [graphPathLayer addAnimation:animation forKey:@"strokeEnd"];
        graphPathLayer.zPosition    = 1;
        [self.layer addSublayer:graphPathLayer];
        CGPathRelease(pathLine);
    }
}
@end
