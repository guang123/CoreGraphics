//
//  BaseView.m
//  CoreGraphics
//
//  Created by Yx on 15/12/31.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//
/*
 CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, intclockwise)
 CGContextRef: 图形上下文
 x,y: 开始画的坐标
 radius: 半径
 startAngle, endAngle: 开始的弧度,结束的弧度
 clockwise: 画的方向(顺时针,逆时针)
 
 */
#import "BaseView.h"

#define selfWith self.frame.size.width
#define selfHeight self.frame.size.height

@implementation BaseView
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

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext(); //设置上下文
    
    //绘制三角形
    CGContextSaveGState(context);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);//设置保真
    
    CGContextTranslateCTM(context,20, 20);//平移
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线条颜色
    CGContextSetLineCap(context ,kCGLineCapRound);//设置线段首尾两端的样式
    CGContextSetLineJoin(context, kCGLineJoinMiter);//设置线条连接点样式
    CGContextSetMiterLimit(context, 0.5);//设置连接点处的斜角大小
    CGContextSetLineWidth(context, 5.0);//线条宽度
    CGContextMoveToPoint(context, 0, 10); //开始画线, x，y 为开始点的坐标
    CGContextAddLineToPoint(context, selfWith-50, 10);//画直线, x，y 为线条结束点的坐标
    CGContextAddLineToPoint(context, selfWith-50, 60);//画直线, x，y 为线条结束点的坐标
    CGContextClosePath(context);//闭合当前子路径（相当于画了一条直线连接了点（0，10）（selfWith-50, 60））
    CGContextStrokePath(context); //开始画线
    CGContextRestoreGState(context);

    
    
    CGContextSaveGState(context);
    //绘制连续的曲线(虚线)
    CGContextBeginPath(context);
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, [UIColor grayColor].CGColor);//设置阴影

    CGContextAddArc(context,160,240,160,0,2*M_PI,1);
    CGContextClip(context);//创建一个路径，然后裁剪该路径。之后绘制的路径在这个裁剪区便会显示出来，不在就不显示
    CGContextSetLineWidth(context, 2.0);
    float dashArray3[] = {3, 2, 10, 20, 5};
    CGContextSetAlpha(context, 0.5);//设置透明度
    CGContextSetLineDash(context, 0, dashArray3, 5);//画虚线
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, 5, 400);//开始画线, x，y 为开始点的坐标
    CGContextAddCurveToPoint(context, 50, 200, 80, 300, 100, 220);//画三次点曲线
    CGContextAddQuadCurveToPoint(context, 150, 100, 200, 200);//画二次点曲线
    CGContextAddCurveToPoint(context, 240, 400, 10, 50, 300, 300);//画三次点曲线
    CGContextStrokePath(context);
    CGContextRestoreGState(context);//此处若不用CGContextSaveGState与CGContextRestoreGState 下面矩形的线条将是虚线
    
    CGContextSaveGState(context);
    //矩形，并填充颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    CGContextSetFillColor(context, CGColorGetComponents( [[UIColor colorWithRed:99/255.0 green:14/255.0 blue:255/255.0 alpha:1 ] CGColor]));
    //CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);//填充颜色 等价与上一句
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);//线框颜色
    CGContextAddRect(context,CGRectMake(140, 80, 90, 60));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
    CGContextRestoreGState(context);
    
    //绘制矩形与椭圆
    CGContextSaveGState(context);
    CGContextBeginPath(context);//新建路径
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetBlendMode(context, kCGBlendModePlusDarker);//设置绑定模式
    /*
    CGContextSetLineWidth(context,5);
    CGContextAddRect(context,CGRectMake(5,5,60,40));
    CGContextStrokePath(context);*/
    CGContextStrokeRectWithWidth(context,CGRectMake(5,5,60,40), 5);//等价于前三行，无法使用CGContextSetFillColorWithColor 填充颜色
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextStrokeEllipseInRect(context,CGRectMake(5,5,60,40));//绘制椭圆

    CGContextRestoreGState(context);
    
    //径向渐变
    CGContextSaveGState(context);
    CGContextAddRect(context, CGRectMake(0, 300, 150, 150));
    CGContextEOClip(context);//裁剪
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceRGB();
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        218.0/255.0,186.0/255.0,6.0/255.0,1,
        29.0/255.0,127.0/255.0,27.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 300), CGPointMake(150, 450), kCGGradientDrawsBeforeStartLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
    
    
    //放射渐变
    CGContextSaveGState(context);
    UIRectClip(CGRectMake(150, 300, 150, 150));
    CGFloat compoentss[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locationss[3]={0,0.3,1.0};
    CGGradientRef gradients= CGGradientCreateWithColorComponents(colorSpace, compoentss, locationss, 3);
    
    /*绘制径向渐变
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradients, CGPointMake(150+(150/2), 300+(150/2)),0, CGPointMake(150+(150/2), 300+(150/2)), 150/2, kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
}


@end
