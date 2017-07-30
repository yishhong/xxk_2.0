//
//  VPHotelOrderController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelOrderController.h"
#import "VPHotelOrderViewModel.h"
#import "UIColor+HUE.h"
#import "OrderTypeTableViewCell.h"
#import "OrderWayTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "VPHotelOrderDetailController.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "HotelOrderRoomNumTableViewCell.h"
#import "VPHotelDetailViewController.h"
#import "VPHotelOrderListModel.h"
#import "VPSubmitOrderController.h"
#import "VPHotelOrderDetailModel.h"
#import "UIAlertController+Order.h"
#import "VPStatusListController.h"
#import "QMCalendarFunction.h"
#import "UIViewController+Empty.h"

@interface VPHotelOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VPHotelOrderViewModel *viewModel;
@property (strong, nonatomic) QMCalendarFunction*calendarFunction;

@end

@implementation VPHotelOrderController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"HotelOrder" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.viewModel = [[VPHotelOrderViewModel alloc] init];
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    self.calendarFunction =[[QMCalendarFunction alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotelOrderRoomNumTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([HotelOrderRoomNumTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderTypeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([OrderTypeTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([OrderWayTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.tableView xx_addHeaderRefreshWithBlock:^{
         [self loadDataWithIsFirst:YES];
    }];
    
    [self.tableView xx_addFooterRefreshWithBlock:^{
         [self loadDataWithIsFirst:NO];
    }];
    
    [MBProgressHUD showLoading];
    [self loadDataWithIsFirst:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hotelRefresh) name:@"HotelRefreshOrderList" object:nil];
}

- (void)loadDataWithIsFirst:(BOOL)isFirst{
    [self.viewModel hotelOrderType:self.orderType key:@"" isFirstLoading:isFirst success:^(BOOL isMore) {
        [self isShowViewType:1 message:@""];
        [self.tableView xx_isHasMoreData:isMore];
        [self.tableView reloadData];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

//-(void)loadNewDate{
//
//    [MBProgressHUD showLoading];
//    [self.viewModel hotelOrderType:self.orderType key:@"" isFirstLoading:NO success:^(BOOL isMore) {
//        [self.tableView xx_isHasMoreData:isMore];
//        [self.tableView reloadData];
//        [MBProgressHUD hide];
//    } failure:^(NSError *error) {
//        [self.tableView xx_endRefreshing];
//        [MBProgressHUD showTip:[error errorMessage]];
//    }];
//}
//
//-(void)loadMoreDate{
//
////    [MBProgressHUD showLoading];
////    [self.viewModel hotelOrderType:self.orderType key:@"" isFirstLoading:YES success:^(BOOL isMore) {
////        [self.tableView xx_isHasMoreData:isMore];
////        [self.tableView reloadData];
////        [MBProgressHUD hide];
////    } failure:^(NSError *error) {
////        [self.tableView xx_endRefreshing];
////        [MBProgressHUD showTip:[error errorMessage]];
////    }];
//}

- (void)hotelRefresh{

    [self.tableView xx_beginRefreshing];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    return cellModel.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    VPHotelOrderListModel *hotelOrderListModel =cellModel.dataSource;
    if ([cellModel.identifier isEqualToString:@"HotelOrderGoodsTableViewCell"]) {
        VPHotelOrderDetailController *hotelOrderDetailController =[VPHotelOrderDetailController instantiation];
        hotelOrderDetailController.orderNum =hotelOrderListModel.orderNum;
        hotelOrderDetailController.tappBlock=^(){
            [self.tableView xx_beginRefreshing];
        };
        [self.navigationController pushViewController:hotelOrderDetailController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    VPHotelOrderListModel *hotelOrderListModel =cellModel.dataSource;
    switch (view.tag) {
        case 0:
            [self hotelPay:hotelOrderListModel];
            break;
            
            case 1:
            [self hotelDeleteOrder:hotelOrderListModel.orderNum message:@"确定删除订单?"];
            break;
            
//        case 2:
//            [self hotelPay:hotelOrderListModel];
//            break;
            
            case 5:
            [self hotelBookagain:hotelOrderListModel];
            break;
            
            case 6|7:
            [self hotelRefund:hotelOrderListModel];
            break;
            
            case 8:
            [self hotelBookagain:hotelOrderListModel];
            break;
            
            case 18:
            [self hotelBookagain:hotelOrderListModel];
            break;
            
            case 9:
            [self hotelRefund:hotelOrderListModel];
            break;
            
        default:
            break;
    }
}


- (void)hotelRefund:(VPHotelOrderListModel *)hotelOrderListModel{

    VPStatusListController * statusListController =[VPStatusListController instantiation];
    statusListController.orderNum =hotelOrderListModel.orderNum;
    statusListController.channelType =VPChannelTypeHotel;
    [self.navigationController pushViewController:statusListController animated:YES];
}

/**
 再次预订

 @param hotelID <#hotelID description#>
 */
- (void)hotelBookagain:(VPHotelOrderListModel*)hotelOrderListModel{
    
       NSDictionary * hotelInfo =[self dateTimeInfo];
        VPHotelDetailViewController *hotelDetailViewController =[VPHotelDetailViewController instantiation];
        hotelDetailViewController.hid =hotelOrderListModel.hotelId;
        hotelDetailViewController.dateInfo =[hotelInfo mutableCopy];
        [self.navigationController pushViewController:hotelDetailViewController animated:YES];
}

//TODO:这里需要修改 统一一个模式
- (NSDictionary *)dateTimeInfo{
    
    //使用日期
    NSString * todayString =[self.calendarFunction getCurrentTime];
    NSString * tomorrowDayString =[self.calendarFunction GetTomorrowDay:[NSDate date]];
    //转成MM-dd
    NSString * todayTime =[self.calendarFunction currentDatefromString:todayString];
    NSString *tomorrowTime =[self.calendarFunction currentDatefromString:tomorrowDayString];
    NSDictionary *dateInfo=@{@"todayDate":todayString,
                             @"tomorrowDate":tomorrowDayString,
                             @"todayTime":todayTime,
                             @"tomorrowTime":tomorrowTime};
    return dateInfo;
}
/**
 删除订单
 
 @param orderID 订单号
 */
-(void)hotelDeleteOrder:(NSString *)orderID message:(NSString *)message{
    UIAlertController * alertController =[UIAlertController selectOrderStateMessage:message deleteString:@"删除" block:^(NSInteger index) {
        if (index==1) {
            [MBProgressHUD showLoading];
            [self.viewModel hoteldeleteOrderID:orderID success:^{
                [self.tableView xx_beginRefreshing];
                [MBProgressHUD hide];
            } failure:^(NSError *error) {
                [MBProgressHUD showTip:[error errorMessage]];
            }];
        }
    }];
    [self presentViewController:alertController animated:YES completion:nil];

}

/**
 订单支付
 */
- (void)hotelPay:(VPHotelOrderListModel *)hotelOrderListModel{

    VPSubmitOrderController * submitOrderController =[VPSubmitOrderController instantiation];
    submitOrderController.title =@"选择支付方式";
    submitOrderController.name =hotelOrderListModel.hotelName;
    submitOrderController.price =hotelOrderListModel.price;
    submitOrderController.orderID =hotelOrderListModel.orderNum;
    submitOrderController.channelType =VPChannelTypeHotel;
    [self.navigationController pushViewController:submitOrderController animated:YES];
}

@end
