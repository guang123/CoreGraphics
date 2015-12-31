//
//  ChartView.h
//  CoreGraphics
//
//  Created by Yx on 15/12/28.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

//图表类型
typedef NS_ENUM(NSInteger, ChartType) {
    ChartTypeDefault,   //默认折线图
    ChartTypeAnimation, //带动画折线图
    ChartTypeAnimationAndFillColor, //带填充色与动画的折线图
};

@interface ChartView : UIView{
    float viewH;//当前视图宽
    float viewW;//当前视图高
}


/**
 *  设置图表类型
 *
 *  @param chartType 图表类型
 */
@property (assign, nonatomic) ChartType                                         chartType;

/**
 *  设置比例
 *
 *  @param percentage 单位比例yInterval/Y轴上相邻两条横线所代表的单位距离
 */
@property (assign, nonatomic) NSInteger                                         percentage;

/**
 *  设置图表X坐标
 *
 *  @param chartX 图表X坐标
 */
@property (assign, nonatomic) NSInteger                                         chartX;

/**
 *  设置图表Y坐标
 *
 *  @param chartY 图表Y坐标
 */
@property (assign, nonatomic) NSInteger                                         chartY;

/**
 *  设置间隔
 *
 *  @param xInterval x轴上每个行标距离间隔多少
 */
@property (assign, nonatomic) NSInteger                                         xInterval;

/**
 *  设置间隔
 *
 *  @param yInterval y轴上每个列标距离间隔多少
 */
@property (assign, nonatomic) NSInteger                                         yInterval;

/**
 *  设置X轴上列标
 *
 *  @param xAxisUnit X轴上列标
 */
@property (strong, nonatomic) NSMutableArray                                    *xAxisMark;

/**
 *  设置Y轴上行标
 *
 *  @param yAxisUnit Y轴上行标
 */
@property (strong, nonatomic) NSMutableArray                                    *yAxisMark;

/**
 *  设置X轴坐标单位
 *
 *  @param xAxis X轴上单位
 */
@property (strong, nonatomic) NSMutableArray                                    *xAxis;

/**
 *  设置Y轴上坐标单位
 *
 *  @param yAxis Y轴上单位
 */
@property (strong, nonatomic) NSMutableArray                                    *yAxis;

//开始绘制表格
- (void)startDraw;
@end
