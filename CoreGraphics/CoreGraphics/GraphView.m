//
//  GraphView.m
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
#import "GraphView.h"

#define PI 3.14159265358979323846
static inline float radians(double degrees) { return degrees * PI / 180; }

@implementation GraphView
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

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //抗锯齿
    CGContextSetAllowsAntialiasing(context, TRUE);
}


@end
