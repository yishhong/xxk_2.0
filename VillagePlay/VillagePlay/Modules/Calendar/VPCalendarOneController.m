//
//  VPCalendarOneController.mController
//  VillagePlay
//
//  Created by Apricot on 2016/12/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCalendarOneController.h"
#import "VPCalendarOneViewModel.h"

#import "QMCalendarView.h"
#import "UIColor+HUE.h"

@interface VPCalendarOneController ()<QMCalendarViewDelegate>

@property (nonatomic, strong) VPCalendarOneViewModel *viewModel;
@property (nonatomic, strong) QMCalendarView *calendarView;
@end

@implementation VPCalendarOneController

+ (instancetype)instantiation{
    VPCalendarOneController *vc = [[VPCalendarOneController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPCalendarOneViewModel alloc] init];
    self.title = @"选择日期";
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    [self.viewModel configSelectDate:self.selectDate];

    self.calendarView = [[QMCalendarView alloc] init];
    self.calendarView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64);
    [self.view addSubview:self.calendarView];
    
    self.calendarView.delegate = self;
    [self.calendarView setLayout];
    self.calendarView.dataArray = [self.viewModel fetchTimeData];
    self.calendarView.valueDict = [self.viewModel fetchValueData];
}

- (void)calendarSelectDay:(NSInteger)day withMonth:(NSInteger)month withyear:(NSInteger)year{
    if(self.selectDateBlock){
        self.selectDateBlock(day,month,year);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
