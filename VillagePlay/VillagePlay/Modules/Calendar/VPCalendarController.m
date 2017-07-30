//
//  VPCalendarController.mController
//  VillagePlay
//
//  Created by Apricot on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCalendarController.h"
#import "VPCalendarViewModel.h"
#import "QMCalendarView.h"
#import "UIColor+HUE.h"

@interface VPCalendarController ()<QMCalendarViewDelegate>

@property (nonatomic, strong) VPCalendarViewModel *viewModel;

@property (nonatomic, strong) QMCalendarView *calendarView;


@end

@implementation VPCalendarController

+ (instancetype)instantiation{
    VPCalendarController *vc = [[VPCalendarController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择日期";
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    self.viewModel = [[VPCalendarViewModel alloc] init];
    [self.viewModel configBeginDate:self.beginDate endDate:self.endDate];
    self.calendarView = [[QMCalendarView alloc] init];
    self.calendarView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64);
    [self.view addSubview:self.calendarView];
    
    self.calendarView.delegate = self;
    [self.calendarView setLayout];
    self.calendarView.dataArray = [self.viewModel fetchTimeData];
    self.calendarView.valueDict = [self.viewModel fetchValueData];
    
}

- (void)calendarSelectDay:(NSInteger)day withMonth:(NSInteger)month withyear:(NSInteger)year{
    if([self.viewModel selectDay:day withMonth:month withyear:year]){
        self.endDate = [NSString stringWithFormat:@"%zd-%zd-%zd",year,month,day];
        if(self.selectDate){
            self.selectDate(self.beginDate,self.endDate);
            [self.navigationController popViewControllerAnimated:YES];

        }
//        if([self.delegate respondsToSelector:@selector(selectBeginDate:endDate:)]){
////            NSDictionary *dateDict = [self.viewModel fetchValueData];
//            [self.delegate selectBeginDate:self.beginDate endDate:self.endDate];
//        }
    }
    self.beginDate = [NSString stringWithFormat:@"%zd-%zd-%zd",year,month,day];
    [self.calendarView reloadData];
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
