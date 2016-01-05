//
//  BaseViewController.m
//  CoreGraphics
//
//  Created by Yx on 15/12/28.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseView.h"


@interface BaseViewController ()
@property (strong, nonatomic) IBOutlet BaseView *baseView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0){
        self.edgesForExtendedLayout = 0;
        self.extendedLayoutIncludesOpaqueBars = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

//    self.baseView = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    [self.baseView startDraw];
//    [self.view addSubview:self.baseView];
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
