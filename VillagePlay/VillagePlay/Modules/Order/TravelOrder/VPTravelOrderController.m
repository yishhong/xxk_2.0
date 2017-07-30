//
//  VPTravelOrderController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelOrderController.h"
#import "VPTravelOrderViewModel.h"
#import "UIColor+HUE.h"
#import "TravelOrderTableViewCell.h"
#import "OrderTypeTableViewCell.h"
#import "TravelOrderWayTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "VPTravelOrderDetailController.h"
#import "UITableViewCell+DataSource.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPTravelOrdersListModel.h"
#import "TravelBarcodeTableViewCell.h"
#import "UIAlertController+Order.h"
#import "VPSubmitOrderController.h"
#import "VPTravelDetailController.h"
#import "VPStatusListController.h"
#import "UIViewController+Empty.h"

@interface VPTravelOrderController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) VPTravelOrderViewModel *viewModel;

@end

@implementation VPTravelOrderController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TravelOrder" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPTravelOrderViewModel alloc] init];
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelOrderTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelOrderTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelBarcodeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelBarcodeTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderTypeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([OrderTypeTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelOrderWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelOrderWayTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(orderRefresh) name:@"refundRefreshNotificationName" object:nil];
    
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
}

- (void)loadDataWithIsFirst:(BOOL)isFirst{
    [self.viewModel travelOrderListState:self.orderState isFirstLoading:isFirst success:^(BOOL isMore) {
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
    NSDictionary *cellInfo =cellModel.dataSource;
    if ([cellModel.identifier isEqualToString:@"TravelOrderTableViewCell"]) {
     
        VPTravelOrderDetailController *travelOrderDetailController =[VPTravelOrderDetailController instantiation];
        travelOrderDetailController.ceid =cellInfo[@"ceid"];
        travelOrderDetailController.type =[self.orderState integerValue];
        [self.navigationController pushViewController:travelOrderDetailController animated:YES];
    }

}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    NSDictionary *orderStateInfo =cellModel.dataSource;
    VPTravelOrdersListModel * travelOrdersListModel =orderStateInfo[@"travelOrderListModel"];
         /**
         0待付款,4已完成,2已取消,3已退款,1待出行
         //退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】
         */
    switch (view.tag) {
        case 0:
            NSLog(@"立即支付");
            [self travelPay:travelOrdersListModel];
            break;
        case 2:
            [self travelBookagain:travelOrdersListModel.activeId];
            break;
        case 3:
            [self travelRefund:travelOrdersListModel];
            break;
        case 4:
            [self travelBookagain:travelOrdersListModel.activeId];
            break;
        case 18:
            [self travelBookagain:travelOrdersListModel.activeId];
            break;
        default:
            break;
    }
}

- (void)orderRefresh{

    [self.tableView xx_beginRefreshing];
}

/**
 退款单详情

 @param travelOrdersListModel <#travelOrdersListModel description#>
 */
- (void)travelRefund:(VPTravelOrdersListModel *)travelOrdersListModel{
    
    VPStatusListController * statusListController =[VPStatusListController instantiation];
    statusListController.orderNum =travelOrdersListModel.ceID;
    statusListController.channelType =VPChannelTypeTravel;
    [self.navigationController pushViewController:statusListController animated:YES];
}

/**
 再次预订
 
 @param hotelID <#hotelID description#>
 */
- (void)travelBookagain:(NSString *)activeId{
    
        VPTravelDetailController *travelDetailController =[VPTravelDetailController instantiation];
        travelDetailController.travelID =activeId;
        [self.navigationController pushViewController:travelDetailController animated:YES];
}

/**
 删除订单
 
 @param orderID 订单号
 */
-(void)travelDeleteOrder:(NSString *)orderID message:(NSString *)message{
    UIAlertController * alertController =[UIAlertController selectOrderStateMessage:message deleteString:@"删除" block:^(NSInteger index) {
        if (index==1) {
            [self presentViewController:alertController animated:YES completion:nil];
//            [MBProgressHUD showLoading];
//            [self.viewModel hoteldeleteOrderID:orderID success:^{
//                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                [self.tableView xx_beginRefreshing];
//                [MBProgressHUD hide];
//            } failure:^(NSError *error) {
//                [MBProgressHUD showTip:[error errorMessage]];
//            }];
        }
    }];
}

/**
 订单支付
 */
- (void)travelPay:(VPTravelOrdersListModel *)travelOrdersListModel{
    
    VPSubmitOrderController * submitOrderController =[VPSubmitOrderController instantiation];
    submitOrderController.title =@"选择支付方式";
    submitOrderController.name =travelOrdersListModel.activitieName;
    submitOrderController.price =travelOrdersListModel.totalRealPrice;
    submitOrderController.orderID =travelOrdersListModel.orderNum;
    submitOrderController.channelType =VPChannelTypeTravel;
    [self.navigationController pushViewController:submitOrderController animated:YES];
}

@end
