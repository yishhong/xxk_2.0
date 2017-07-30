//
//  VPTicketOrderDetailController.mController
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketOrderDetailController.h"
#import "VPTicketOrderDetailViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIScrollView+Refresh.h"
#import "NSError+Reason.h"
#import "MBProgressHUD+Loading.h"
#import "VPTiketOrderDetailOrderModel.h"
#import "UIColor+HUE.h"
#import "VPTicketDetailController.h"
#import "VPSubmitOrderController.h"
#import "UIAlertController+Order.h"
#import "OrderTypeTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "TravelOrderNameTableViewCell.h"
#import "TravelTicketTypeTableViewCell.h"
#import "TravelPartakeWayTableViewCell.h"
#import "TravelReservationPeopleTableViewCell.h"
#import "TravelPayWayTableViewCell.h"
#import "TravelIDCordTableViewCell.h"
#import "HotelOrderIDTableViewCell.h"
#import "VPStatusListController.h"

@interface VPTicketOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VPTicketOrderDetailViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UILabel *refundLabel;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *payButton;
@property (strong, nonatomic) VPTiketOrderDetailOrderModel *tiketOrderDetailOrderModel;

@end

@implementation VPTicketOrderDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TicketOrder" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"订单详情";
    self.refundLabel.hidden =YES;
    self.cancelButton.hidden =YES;
    self.payButton.hidden =YES;
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.refundLabel.textColor =[UIColor VPDetailColor];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.cancelButton.layer.borderWidth =1.0f;
    self.cancelButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    [self.cancelButton setTitleColor:[UIColor VPDetailColor] forState:UIControlStateNormal];
    self.cancelButton.layer.cornerRadius =2.0f;
    
    self.payButton.layer.borderWidth =1.0f;
    self.payButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    self.payButton.layer.cornerRadius =2.0f;
    [self.payButton setTitleColor:[UIColor VPDetailColor] forState:UIControlStateNormal];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotelOrderIDTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([HotelOrderIDTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelIDCordTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelIDCordTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelOrderNameTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelOrderNameTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelTicketTypeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelTicketTypeTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelPartakeWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelPartakeWayTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelReservationPeopleTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelReservationPeopleTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelPayWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelPayWayTableViewCell class])];
    
    self.viewModel = [[VPTicketOrderDetailViewModel alloc] init];
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadNewDate];
    }];
    [self.tableView xx_beginRefreshing];
}

-(void)loadNewDate{

    [MBProgressHUD showLoading];
    [self.viewModel ticketOrderDetailOrderNum:self.ceid success:^{
        self.tiketOrderDetailOrderModel =[self.viewModel orderDetailModel];
        [MBProgressHUD hide];
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

- (IBAction)cancelAction:(id)sender {
    
    
    VPTicketRegisteRecord * ticketRegisteRecord =[self.tiketOrderDetailOrderModel.ticketRegisteRecord firstObject];
    if (ticketRegisteRecord.isAccept==0) {
        [self tiketDeleteOrder:ticketRegisteRecord.orderNum message:@"取消订单后,本单享有的优惠可能会一并取消。确定继续取消吗？"];
    }
}
- (IBAction)payAction:(id)sender {
    
    VPTicketRegisteRecord * ticketRegisteRecord =[self.tiketOrderDetailOrderModel.ticketRegisteRecord firstObject];
    switch (ticketRegisteRecord.isAccept) {
        case 0:
            [self tiketPay:ticketRegisteRecord];
            break;
        case 1:
            [self tiketRefund:ticketRegisteRecord.orderNum message:@"确定申请退款吗？"];
            break;
        case 2:
            [self ticketBookagain:ticketRegisteRecord.orderNum];

            break;
        case 3:
            [self ticketRefund:ticketRegisteRecord];
            break;
        case 4:
            [self ticketBookagain:ticketRegisteRecord.orderNum];
            break;
        default:
            break;
    }
}

-(void)setTiketOrderDetailOrderModel:(VPTiketOrderDetailOrderModel *)tiketOrderDetailOrderModel{

    _tiketOrderDetailOrderModel =tiketOrderDetailOrderModel;
    VPTicketRegisteRecord * ticketRegisteRecord =[self.tiketOrderDetailOrderModel.ticketRegisteRecord firstObject];
    NSMutableDictionary * refundInfo =[self.viewModel refundString:tiketOrderDetailOrderModel];
    if (![refundInfo[@"refundString"] isEqualToString:@""]) {

        self.refundLabel.attributedText =refundInfo[@"attributedRefundString"];
        self.refundLabel.hidden =NO;
    }
    NSDictionary * buttonStatusInfo =[self.viewModel orderStatus:ticketRegisteRecord.isAccept refundState:ticketRegisteRecord.refundState];
    NSString *cancelString =buttonStatusInfo[@"placeString"];
    NSString *payString =buttonStatusInfo[@"payString"];
    if (cancelString.length>0) {
        [self.cancelButton setTitle:cancelString forState:UIControlStateNormal];
        self.cancelButton.hidden =NO;
    }if (payString.length>0) {
        [self.payButton setTitle:payString forState:UIControlStateNormal];
        self.payButton.hidden =NO;
    }
}

/**
 退款详情

 @param ticketRegisteRecord <#ticketRegisteRecord description#>
 */
- (void)ticketRefund:(VPTicketRegisteRecord *)ticketRegisteRecord{
    
    VPStatusListController * statusListController =[VPStatusListController instantiation];
    statusListController.orderNum =ticketRegisteRecord.orderNum;
    statusListController.channelType =VPChannelTypeTicket;
    [self.navigationController pushViewController:statusListController animated:YES];
}

/**
 再次预订
 
 @param hotelID <#hotelID description#>
 */
- (void)ticketBookagain:(NSString *)ticketId{
    
    VPTicketDetailController *travelDetailController =[VPTicketDetailController instantiation];
    travelDetailController.pid =ticketId;
    [self.navigationController pushViewController:travelDetailController animated:YES];
}

/**
 取消订单
 
 @param orderID 订单号
 */
-(void)tiketDeleteOrder:(NSString *)orderID message:(NSString *)message{
    UIAlertController * alertController =[UIAlertController selectOrderStateMessage:message deleteString:@"确定" block:^(NSInteger index) {
        if (index==1) {
            [MBProgressHUD showLoading];
            [self.viewModel ticketOrderCancelOrderNum:orderID success:^{
                [self.tableView xx_beginRefreshing];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"TiketRefreshNotificationName" object:self];
                [MBProgressHUD hide];
            } failure:^(NSError *error) {
                [MBProgressHUD showTip:[error errorMessage]];
            }];
        }
    }];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)tiketRefund:(NSString *)orderID message:(NSString *)message{

    UIAlertController * alertController =[UIAlertController selectOrderStateMessage:message deleteString:@"确定" block:^(NSInteger index) {
        if (index==1) {
            [MBProgressHUD showLoading];
            [self.viewModel ticketRefundOrderNum:orderID success:^{
                [self.tableView xx_beginRefreshing];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"TiketRefreshNotificationName" object:self];
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
- (void)tiketPay:(VPTicketRegisteRecord *)tiketOrdersListModel{
    
    VPSubmitOrderController * submitOrderController =[VPSubmitOrderController instantiation];
    submitOrderController.title =@"选择支付方式";
    submitOrderController.name =tiketOrdersListModel.ticketName;
    submitOrderController.price =tiketOrdersListModel.rechargeMoney;
    submitOrderController.orderID =tiketOrdersListModel.orderNum;
    submitOrderController.channelType =VPChannelTypeTicket;
    [self.navigationController pushViewController:submitOrderController animated:YES];
}
@end
