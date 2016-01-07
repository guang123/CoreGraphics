//
//  PieChartViewController.m
//  CoreGraphics
//
//  Created by Yx on 16/1/6.
//  Copyright © 2016年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "PieChartViewController.h"
#import "PieChartView.h"

@interface PieChartViewController ()
@property (strong, nonatomic) PieChartView *pieChartView;
@end

@implementation PieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0){
        self.edgesForExtendedLayout = 0;
        self.extendedLayoutIncludesOpaqueBars = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    self.pieChartView              = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    NSMutableArray *arrNum         = [NSMutableArray arrayWithObjects:@"25",@"30",@"40",@"5",nil];
    NSMutableArray *arrColor       = [NSMutableArray arrayWithObjects:[UIColor yellowColor], [UIColor blueColor], [UIColor brownColor], [UIColor purpleColor],nil];
    NSMutableArray *arrTitle       = [NSMutableArray arrayWithObjects:@"25",@"30",@"40",@"5",nil];
    self.pieChartView.colorArr     = arrColor;
    self.pieChartView.numericalArr = arrNum;
    self.pieChartView.titleArr     = arrTitle;
    [self.pieChartView startDraw];
    self.pieChartView.title = @"一张大饼";
    [self.view addSubview:self.pieChartView];
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
