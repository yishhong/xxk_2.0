//
//  VPTicketOrderController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketOrderController.h"
#import "VPTicketOrderViewModel.h"
#import "UIColor+HUE.h"
#import "TravelOrderTableViewCell.h"
#import "OrderTypeTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "VPTravelOrderDetailController.h"
#import "TravelOrderWayTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "UIScrollView+Refresh.h"
#import "TravelBarcodeTableViewCell.h"
#import "VPSubmitOrderController.h"
#import "UIAlertController+Order.h"
#import "VPTicketDetailController.h"
#import "VPTiketOrderListOrderModel.h"
#import "VPTicketOrderDetailController.h"
#import "VPStatusListController.h"
#import "UIViewController+Empty.h"

@interface VPTicketOrderController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VPTicketOrderViewModel *viewModel;

@end

@implementation VPTicketOrderController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TicketOrder" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPTicketOrderViewModel alloc] init];
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelOrderTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelOrderTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderTypeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([OrderTypeTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelOrderWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelOrderWayTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelBarcodeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelBarcodeTableViewCell class])];

    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadNewDate:YES];
    }];
    
    [self.tableView xx_addFooterRefreshWithBlock:^{
        [self loadNewDate:NO];
    }];
    
    [MBProgressHUD showLoading];
    [self loadNewDate:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tiketRefresh) name:@"TiketRefreshNotificationName" object:nil];
}

- (void)loadNewDate:(BOOL)isFirstLoading{
    [self.viewModel ticketOrderListType:self.type isFirstLoading:isFirstLoading success:^(BOOL isMore) {
        [self isShowViewType:1 message:@""];
        [self.tableView reloadData];
        [self.tableView xx_isHasMoreData:isMore];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

- (void)tiketRefresh{

    [self.tableView xx_beginRefreshing];
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
    NSDictionary *cellInfo =cellModel.dataSource;
    if ([cellModel.identifier isEqualToString:@"TravelOrderTableViewCell"]) {
        
        VPTicketOrderDetailController * ticketOrderDetailController =[VPTicketOrderDetailController instantiation];
        ticketOrderDetailController.ceid =cellInfo[@"ceid"];
        [self.navigationController pushViewController:ticketOrderDetailController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    NSDictionary *orderStateInfo =cellModel.dataSource;
    VPTiketOrderListOrderModel * riketOrderListOrderModel =orderStateInfo[@"travelOrderListModel"];
    switch (view.tag) {
        case 0:
            [self tiketPay:riketOrderListOrderModel];
            break;
//        case 1:
//            [self tiketPay:riketOrderListOrderModel];
//            break;
        case 2:
            [self ticketBookagain:riketOrderListOrderModel.ticketId];
            break;
        case 3:
            [self ticketRefund:riketOrderListOrderModel];
            break;
        case 4:
            [self ticketBookagain:riketOrderListOrderModel.ticketId];
            break;
            
        default:
            break;
    }
}

- (void)ticketRefund:(VPTiketOrderListOrderModel *)riketOrderListOrderModel{
    
    VPStatusListController * statusListController =[VPStatusListController instantiation];
    statusListController.orderNum =riketOrderListOrderModel.orderNum;
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
 订单支付
 */
- (void)tiketPay:(VPTiketOrderListOrderModel *)tiketOrdersListModel{
    
    VPSubmitOrderController * submitOrderController =[VPSubmitOrderController instantiation];
    submitOrderController.title =@"选择支付方式";
    submitOrderController.name =tiketOrdersListModel.activitieName;
    submitOrderController.price =tiketOrdersListModel.price;
    submitOrderController.orderID =tiketOrdersListModel.orderNum;
    submitOrderController.channelType =VPChannelTypeTicket;
    [self.navigationController pushViewController:submitOrderController animated:YES];
}

@end
