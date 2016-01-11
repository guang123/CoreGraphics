//
//  PieChart.m
//  CoreGraphics
//
//  Created by Yx on 16/1/6.
//  Copyright © 2016年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "PieChartView.h"

#define DefaultMargins 8.0f  //默认边距
#define spaceHeight 5
#define textWidth 80

@implementation PieChartView
@synthesize colorArr = _colorArr;
@synthesize titleArr = _titleArr;
@synthesize numericalArr = _numericalArr;

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
        self.backgroundColor = [UIColor whiteColor];
        viewH                = frame.size.height;
        viewW                = frame.size.width;
    }
    return self;
}

- (void)startDraw{
    [self setNeedsDisplay];
}

#pragma mark set/get
- (void)setColorArr:(NSMutableArray *)colorArr{
    if (self.colorArr != nil) {
        _colorArr = [colorArr mutableCopy];
    }
}

- (NSMutableArray *)colorArr{
    if (_colorArr == nil) {
        _colorArr     = [NSMutableArray array];
    }
    return _colorArr;
}

- (void)setTitleArr:(NSMutableArray *)titleArr{
    if (self.titleArr != nil) {
        _titleArr = [titleArr mutableCopy];
    }
}

- (NSMutableArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr     = [NSMutableArray array];
    }
    return _titleArr;
}

- (void)setNumericalArr:(NSMutableArray *)numericalArr{
    if (self.numericalArr != nil) {
        _numericalArr = [numericalArr mutableCopy];
        for(int i = 0; i< [_numericalArr count]; i++){
            sum  += [[_numericalArr objectAtIndex:i] floatValue];
        }
    }
}

- (NSMutableArray *)numericalArr{
    if (_numericalArr == nil) {
        _numericalArr     = [NSMutableArray array];
    }
    return _numericalArr;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    //抗锯齿
    CGContextSetAllowsAntialiasing(context, TRUE);
    //设置标题
    float textMaxY = [self drawText:CGPointMake(DefaultMargins, DefaultMargins) text:self.title font:17];
    if (self.radius != 0 ) {
        CGContextMoveToPoint(context, viewW/2, self.radius*2 + textMaxY);
        center = CGPointMake(viewW/2,  self.radius*2 + textMaxY);
        
    }else{
        CGContextMoveToPoint(context, viewW/2, viewW/2 + textMaxY);
        center = CGPointMake(viewW/2,  viewW/2 + textMaxY);
        self.radius = viewW/2 - textMaxY;
    }
    float currentangel = 0;
    //饼图
    CGContextSaveGState(context);
    for(int i = 0; i< [_numericalArr count]; i++){
        float startAngle = [self calculateRadian:currentangel];
        currentangel += [[_numericalArr objectAtIndex:i] floatValue] / sum;
        float endAngle = [self calculateRadian:currentangel];
        
        CGContextBeginPath(context);
        //绘制上面的扇形
        CGContextMoveToPoint(context, center.x, center.y);
        [[_colorArr objectAtIndex:i %  [_colorArr count]] setFill];
        [[UIColor colorWithWhite:1.0 alpha:0.8] setStroke];
        CGContextAddArc(context, center.x, center.y, self.radius, startAngle, endAngle, 0);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFill);

        //获取各弧度的中点
        float radiansMidpointX = cos((endAngle - startAngle)/2 + startAngle) * self.radius  + center.x;;
        float radiansMidpointY = sin((endAngle - startAngle)/2 + startAngle) * self.radius +  center.y;;
        //获取各扇形平分线中点
        float fanMidpointX = (radiansMidpointX + center.x)/2;
        float fanMidpointY = (radiansMidpointY + center.y)/2;
        //绘制文字
        [self drawText:CGPointMake(fanMidpointX + 8, fanMidpointY - 9) text:_titleArr[i] font:17.0];
        
        
        //按圆绘制路径裁剪与路径绘制测试
        CGContextSaveGState(context);
        float starx = cos(startAngle) * self.radius  + center.x;//开始绘制弧的起点的X点坐标
        float stary = sin(startAngle) * self.radius +  center.y;//开始绘制弧的起点的Y点坐标
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, center.x, center.y);
        CGPathAddLineToPoint(path, nil, starx, stary);
        CGPathMoveToPoint(path, nil, starx, stary);
        CGPathAddArc(path, nil, center.x, center.y, self.radius, startAngle, endAngle, 0);
        CGPathCloseSubpath(path);
        CGContextAddPath(context, path);
        //按路径裁剪
        CGContextClip(context);
        CGPathRelease(path);
        
        //绘制各扇形平分线中点
        CGRect rect = CGRectMake(fanMidpointX, fanMidpointY, 2, 2);
        CAShapeLayer *graphPathLayer   = [CAShapeLayer layer];
        graphPathLayer.frame           = self.bounds;
        graphPathLayer.fillColor       = [UIColor clearColor].CGColor;
        graphPathLayer.backgroundColor = [UIColor clearColor].CGColor;
        if (i == 0 ) {
            [graphPathLayer setStrokeColor:[UIColor redColor].CGColor];
        }else if(i == 1){
            [graphPathLayer setStrokeColor:[UIColor greenColor].CGColor];
        }else if (i == 2){
            [graphPathLayer setStrokeColor:[UIColor cyanColor].CGColor];
        }else{
            [graphPathLayer setStrokeColor:[UIColor whiteColor].CGColor];
        }
        [graphPathLayer setLineWidth:2];
        CGMutablePathRef subPath = CGPathCreateMutable();
        CGPathAddRect(subPath, nil, rect);
        graphPathLayer.path = subPath;
        graphPathLayer.zPosition    = 2;
        [self.layer addSublayer:graphPathLayer];
        CGPathRelease(subPath);
        CGContextRestoreGState(context);
        

    }
    CGContextRestoreGState(context);

}

#pragma mark - 私有方法

//绘制文字
- (float)drawText:(CGPoint )point text:(NSString *)text font:(int)textFont{
    UIFont *font = [UIFont systemFontOfSize:textFont];//设置字体
    UIColor *color = [UIColor blackColor];//字体颜色
    NSMutableParagraphStyle *style= [[NSMutableParagraphStyle alloc]init];//段落样式
    NSTextAlignment align = NSTextAlignmentLeft;//对齐方式
    style.alignment = align;
    CGRect rect = CGRectZero;
    float textHeight = [self getTextHeight:text font:textFont];
    rect = CGRectMake(point.x, point.y, textWidth, textHeight);
    [text drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
    return point.y + textHeight;
}

//获取文本高度
- (float)getTextHeight:(NSString *)text font:(int)textFont{
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        //计算文本高度
        NSDictionary * extdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:textFont], NSFontAttributeName,nil];
        CGSize explainlabelSize = CGSizeZero;
        explainlabelSize =[text boundingRectWithSize:CGSizeMake(textWidth,21) options:NSStringDrawingUsesLineFragmentOrigin  attributes:extdic context:nil].size;
        return explainlabelSize.height;
    }else{
        //设置一个行高上限
        CGSize size = CGSizeMake(textWidth,21);
        //计算实际frame大小
        CGSize labelsize = [text sizeWithFont:[UIFont boldSystemFontOfSize:textFont] constrainedToSize:size lineBreakMode:0];
        return labelsize.height;
    }
}

//计算弧度
- (float)calculateRadian:(float)currentangel{
    return currentangel * M_PI * 2;
    //return 360 * currentangel * (M_PI/180);
}
@end
