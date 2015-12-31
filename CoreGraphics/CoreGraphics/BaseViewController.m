//
//  BaseViewController.m
//  CoreGraphics
//
//  Created by Yx on 15/12/28.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "ChartView.h"


@interface BaseViewController ()
@property (strong, nonatomic) ChartView *chartView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.chartView            = [[ChartView alloc] initWithFrame:CGRectMake(0, 50, 320, 400)];
    NSMutableArray *arr       = [NSMutableArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", @"周日",nil];
    NSMutableArray *arrY      = [NSMutableArray arrayWithObjects:@"0",@"10",@"20",@"30",@"40",@"50", @"60",nil];
    NSMutableArray *arrYAxis  = [NSMutableArray arrayWithObjects:@"2",@"10",@"20",@"5",@"30",@"55", @"60",nil];
    self.chartView.xAxisMark  = arr;
    self.chartView.yAxisMark  = arrY;
    self.chartView.yAxis      = arrYAxis;
    self.chartView.xInterval  = 48;
    self.chartView.yInterval  = 50;
    self.chartView.percentage = 50/10;
    [self.chartView startDraw];
    self.chartView.chartType  = ChartTypeAnimationAndFillColor;
    [self.view addSubview:self.chartView];
}


- (IBAction)changeAction:(id)sender {
    NSMutableArray *arrYAxis = [NSMutableArray arrayWithObjects:@"2",@"15",@"20",@"35",@"30",@"55", @"20",nil];
    self.chartView.chartType = ChartTypeAnimationAndFillColor;
    self.chartView.yAxis     = arrYAxis;
    [self.chartView startDraw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
