//
//  VPHotelOrderDetailController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelOrderDetailController.h"
#import "VPHotelOrderDetailViewModel.h"
#import "OrderTypeTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "TravelOrderNameTableViewCell.h"
#import "TravelTicketTypeTableViewCell.h"
#import "TravelPartakeWayTableViewCell.h"
#import "TravelReservationPeopleTableViewCell.h"
#import "TravelPayWayTableViewCell.h"
#import "UIColor+HUE.h"
#import "HotelOrderIDTableViewCell.h"
#import "TravelOrderTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPHotelOrderDetailModel.h"
#import "VPHotelDetailViewController.h"
#import "VPSubmitOrderController.h"
#import "UIScrollView+Refresh.h"
#import "NSError+Reason.h"
#import "UIAlertController+Order.h"
#import "NSMutableAttributedString+AttributedString.h"
#import "VPStatusListController.h"
#import "QMCalendarFunction.h"

@interface VPHotelOrderDetailController ()

@property (nonatomic, strong) VPHotelOrderDetailViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *botomView;

@property (strong, nonatomic) IBOutlet UILabel *refundLabel;
@property (strong, nonatomic) IBOutlet UILabel *chargeLabel;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIButton *subscribeButton;

@property (strong, nonatomic) QMCalendarFunction *calendarFunction;

@property (strong, nonatomic) VPHotelOrderDetailModel * hotelOrderDetailModel;

@end

@implementation VPHotelOrderDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"HotelOrder" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"订单详情";
    self.calendarFunction =[[QMCalendarFunction alloc]init];
    self.subscribeButton.hidden =YES;
    self.deleteButton.hidden =YES;
    self.refundLabel.hidden =YES;
    self.chargeLabel.hidden =YES;
    self.viewModel = [[VPHotelOrderDetailViewModel alloc] init];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.deleteButton.layer.borderWidth =1.0f;
    self.deleteButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    self.deleteButton.layer.cornerRadius =2.0f;
    [self.deleteButton setTitleColor:[UIColor VPContentColor] forState:UIControlStateNormal];
    self.subscribeButton.layer.borderWidth =1.0f;
    self.subscribeButton.layer.cornerRadius =2.0f;
    self.subscribeButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    [self.subscribeButton setTitleColor:[UIColor VPContentColor] forState:UIControlStateNormal];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotelOrderIDTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([HotelOrderIDTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelOrderTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelOrderTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelOrderNameTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelOrderNameTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelPartakeWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelPartakeWayTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelPayWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelPayWayTableViewCell class])];
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadNewDate];
    }];
    [self.tableView xx_beginRefreshing];
}

- (void)loadNewDate{

    [self.viewModel hotelDetailOrderid:self.orderNum success:^{
        self.hotelOrderDetailModel =[self.viewModel orederDetailModel];
        [self.tableView reloadData];
        [self.tableView xx_endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
        [self.tableView xx_endRefreshing];
    }];
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

#pragma mark - getter or setter
- (void)setHotelOrderDetailModel:(VPHotelOrderDetailModel *)hotelOrderDetailModel{

    _hotelOrderDetailModel =hotelOrderDetailModel;
    NSString *subscribeString =[self.viewModel subscribeButtonString:hotelOrderDetailModel];
    [self.deleteButton setTitle:[self.viewModel deleteButtonString:hotelOrderDetailModel] forState:UIControlStateNormal];
    if (![subscribeString isEqualToString:@""]) {
        self.subscribeButton.hidden =NO;
        [self.subscribeButton setTitle:subscribeString forState:UIControlStateNormal];
    }

    NSMutableDictionary * moenyInfo =[self.viewModel refundString:hotelOrderDetailModel];
    self.deleteButton.hidden =NO;
    if (![moenyInfo[@"refundString"] isEqualToString:@""]) {
        self.refundLabel.attributedText =moenyInfo[@"attributedRefundString"];
        self.refundLabel.hidden =NO;
    }
    if (![moenyInfo[@"deductionsString"] isEqualToString:@""]) {
        self.chargeLabel.attributedText =moenyInfo[@"attributedDeductionsString"];
        self.chargeLabel.hidden =NO;
    }

}

- (IBAction)subscribeAction:(id)sender {
    
//    房间状态(0待付款,1预订取消，2待确认，3等待入住，5已完成（已入住），6已取消退款中，7已取消退款中，8已完成未入住，9已取消已退款)
    switch (self.hotelOrderDetailModel.orderState) {
        case 0:
            [self hotelCancelOrder:self.hotelOrderDetailModel.orderNum message:@"确定取消订单"];
            break;
            
        case 1:
            [self hotelBookagain:self.hotelOrderDetailModel.hotelId];
            break;
            
        default:
            break;
    }
}

//最右边按钮
- (IBAction)deleteAction:(id)sender {
    
    switch (self.hotelOrderDetailModel.orderState) {
        case 0:
            [self hotelPay];
            break;
        case 1:
            [self hotelDeleteOrder:self.hotelOrderDetailModel.orderNum message:@"取消订单后,本单享有的优惠可能会一并取消。确定继续取消吗？"];
            break;
        case 2:
            [self hotelCancelOrder:self.hotelOrderDetailModel.orderNum message:@"取消订单后,本单享有的优惠可能会一并取消。确定继续取消吗？"];
            break;
        case 3:
            [self hotelCancelOrder:self.hotelOrderDetailModel.orderNum message:@"取消订单后,本单享有的优惠可能会一并取消。确定继续取消吗？"];
            break;
        case 5:
            [self hotelBookagain:self.hotelOrderDetailModel.hotelId];
            break;
            
        case 6|7:
            [self hotelRefund:self.hotelOrderDetailModel];
            break;
            
        case 8:
            [self hotelBookagain:self.hotelOrderDetailModel.hotelId];
            break;
            
        case 9:
            [self hotelRefund:self.hotelOrderDetailModel];
            break;
        default:
            break;
    }
}

- (void)hotelRefund:(VPHotelOrderDetailModel *)hotelOrderDetailModel{
    
    VPStatusListController * statusListController =[VPStatusListController instantiation];
    statusListController.orderNum =hotelOrderDetailModel.orderNum;
    statusListController.channelType =VPChannelTypeHotel;
    [self.navigationController pushViewController:statusListController animated:YES];
}

/**
 取消订单

 @param orderID 定点号
 */
-(void)hotelCancelOrder:(NSString *)orderID message:(NSString *)message{

    UIAlertController * alertController =[UIAlertController selectOrderStateMessage:message deleteString:@"确定" block:^(NSInteger index) {
        if (index==1) {
            [MBProgressHUD showLoading];
            [self.viewModel hotelCancelOrderID:orderID success:^{
                [self.tableView xx_beginRefreshing];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HotelRefreshOrderList" object:self];
                [MBProgressHUD hide];
            } failure:^(NSError *error) {
                [MBProgressHUD showTip:[error errorMessage]];
            }];
        }
    }];
    [self presentViewController:alertController animated:YES completion:nil];
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
                [self.navigationController popViewControllerAnimated:YES];
                [MBProgressHUD hide];
                if (self.tappBlock) {
                    self.tappBlock();
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showTip:[error errorMessage]];
            }];
        }
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}
/**
 再次预订
 
 @param hotelID <#hotelID description#>
 */
- (void)hotelBookagain:(NSInteger)hotelID{
    
        NSDictionary * hotelInfo =[self dateTimeInfo];
        VPHotelDetailViewController *hotelDetailViewController =[VPHotelDetailViewController instantiation];
        hotelDetailViewController.hid =hotelID;
        hotelDetailViewController.dateInfo =[hotelInfo mutableCopy];
        [self.navigationController pushViewController:hotelDetailViewController animated:YES];
}

//TODO:这里需要修改 统一一个模式
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
 立即支付
 */
- (void)hotelPay{
    
    VPSubmitOrderController * submitOrderController =[VPSubmitOrderController instantiation];
    submitOrderController.title =@"选择支付方式";
    submitOrderController.name =self.hotelOrderDetailModel.hotelName;
    submitOrderController.price =self.hotelOrderDetailModel.price;
    submitOrderController.channelType =VPChannelTypeHotel;
    submitOrderController.orderID =self.hotelOrderDetailModel.orderNum;
    [self.navigationController pushViewController:submitOrderController animated:YES];
}

@end
