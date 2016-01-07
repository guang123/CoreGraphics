//
//  PieChart.h
//  CoreGraphics
//
//  Created by Yx on 16/1/6.
//  Copyright © 2016年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView{
    float viewH;    //当前视图宽
    float viewW;    //当前视图高
    float sum;      //数值之和
    CGPoint center; //圆心
}

/**
 *  设置饼状图颜色数组
 *
 *  @param colorArr 饼图上各部分颜色
 */
@property (strong, nonatomic) NSMutableArray                                    *colorArr;

/**
 *  设置饼状图数组数组
 *
 *  @param numericalArr 饼图上各部分数值
 */
@property (strong, nonatomic) NSMutableArray                                    *numericalArr;

/**
 *  设置饼状图各部分标题数组
 *
 *  @param titleArr 饼图上各部分数值
 */
@property (strong, nonatomic) NSMutableArray                                    *titleArr;

/**
 *  设置饼状图标题
 *
 *  @param title 饼图标题
 */
@property (strong, nonatomic) NSString                                          *title;

/**
 *  设置饼状图半径
 *
 *  @param radius 饼图半径
 */
@property (assign, nonatomic) NSInteger                                          radius;

//开始绘制图表
- (void)startDraw;
@end
