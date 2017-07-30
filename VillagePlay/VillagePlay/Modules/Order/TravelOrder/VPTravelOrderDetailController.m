//
//  VPTravelOrderDetailController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelOrderDetailController.h"
#import "VPTravelOrderDetailViewModel.h"
#import "UIColor+HUE.h"
#import "OrderTypeTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "TravelOrderNameTableViewCell.h"
#import "TravelTicketTypeTableViewCell.h"
#import "TravelPartakeWayTableViewCell.h"
#import "TravelReservationPeopleTableViewCell.h"
#import "TravelPayWayTableViewCell.h"
#import "TravelIDCordTableViewCell.h"
#import "VPRefundApplyController.h"
#import "UIScrollView+Refresh.h"
#import "NSError+Reason.h"
#import "MBProgressHUD+Loading.h"
#import "VPTravelOrderDetailModel.h"
#import "UITableViewCell+DataSource.h"
#import "NSMutableAttributedString+AttributedString.h"
#import "VPTravelDetailController.h"
#import "VPSubmitOrderController.h"
#import "UIAlertController+Order.h"
#import "HotelOrderIDTableViewCell.h"
#import "VPStatusListController.h"


@interface VPTravelOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPTravelOrderDetailViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *orderExplainLabel;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *payButton;
@property (strong, nonatomic) VPTravelOrderDetailModel *travelOrderDetailModel;

@end

@implementation VPTravelOrderDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TravelOrder" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"订单详情";
    self.orderExplainLabel.hidden =YES;
    self.cancelButton.hidden =YES;
    self.payButton.hidden =YES;
    self.orderExplainLabel.textColor =[UIColor VPDetailColor];
    self.viewModel = [[VPTravelOrderDetailViewModel alloc] init];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.cancelButton.layer.borderWidth =1.0f;
    self.cancelButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    [self.cancelButton setTitleColor:[UIColor VPDetailColor] forState:UIControlStateNormal];
    self.cancelButton.layer.cornerRadius =2.0f;

    self.payButton.layer.borderWidth =1.0f;
    self.payButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    self.payButton.layer.cornerRadius =2.0f;
    [self.payButton setTitleColor:[UIColor VPDetailColor] forState:UIControlStateNormal];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderTypeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([OrderTypeTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelIDCordTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelIDCordTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelOrderNameTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelOrderNameTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelTicketTypeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelTicketTypeTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelPartakeWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelPartakeWayTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelReservationPeopleTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelReservationPeopleTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelPayWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelPayWayTableViewCell class])];
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadNewDate];
    }];
    [self.tableView xx_beginRefreshing];
}

- (void)loadNewDate{

    [self.viewModel travelOrderDetailCeid:self.ceid type:self.type success:^{
        
        self.travelOrderDetailModel =[self.viewModel orderDetailModel];
        
        [self.tableView reloadData];
        [self.tableView xx_endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
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

#pragma mark - Action response
- (IBAction)cancelAction:(id)sender {
    
    switch (self.travelOrderDetailModel.isAccept) {
        case 0:
            [self travelDeleteOrder:self.travelOrderDetailModel.orderNum message:@"取消订单后,本单享有的优惠可能会一并取消。确定继续取消吗？"];
            break;
        default:
            break;
    }
}

- (IBAction)payAction:(id)sender {
    
    /**
     0待付款,4已完成,2已取消,3已退款,1待出行
     //退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】
     */
    switch (self.travelOrderDetailModel.isAccept) {
        case 0:
            NSLog(@"立即支付");
            [self travelPay:self.travelOrderDetailModel];
            break;
        case 1:
            [self applyRefund];
            break;
        case 2:
            [self travelBookagain:self.travelOrderDetailModel.activeId];
            break;
        case 3:
            [self travelRefund:self.travelOrderDetailModel];
            break;
        case 4:
            [self travelBookagain:self.travelOrderDetailModel.activeId];
            break;
        default:
            break;
    }
}

#pragma mark -setter or getter
- (void)setTravelOrderDetailModel:(VPTravelOrderDetailModel *)travelOrderDetailModel{

    _travelOrderDetailModel =travelOrderDetailModel;
    NSString * refundString =[self.viewModel refundString:travelOrderDetailModel];
    if (refundString.length>0) {
        NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc]init];
        attributedString =[attributedString changeColorString:refundString location:2 length:2];
        self.orderExplainLabel.attributedText =attributedString;
        self.orderExplainLabel.hidden =NO;
    }
    NSDictionary * buttonStatusInfo =[self.viewModel orderStatus:travelOrderDetailModel.isAccept refundState:travelOrderDetailModel.refundState];
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
 退款单详情

 @param travelOrderDetailModel <#travelOrderDetailModel description#>
 */
- (void)travelRefund:(VPTravelOrderDetailModel *)travelOrderDetailModel{
    
    VPStatusListController * statusListController =[VPStatusListController instantiation];
    statusListController.orderNum =[NSString stringWithFormat:@"%zd",travelOrderDetailModel.ceID];
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
 取消订单
 
 @param orderID 订单号
 */
-(void)travelDeleteOrder:(NSString *)orderID message:(NSString *)message{
    UIAlertController * alertController =[UIAlertController selectOrderStateMessage:message deleteString:@"确定" block:^(NSInteger index) {
        if (index==1) {
            [MBProgressHUD showLoading];
            [self.viewModel travelCancelOrderNum:self.travelOrderDetailModel.orderNum success:^{
                self.cancelButton.hidden =YES;
                [self.tableView xx_beginRefreshing];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refundRefreshNotificationName" object:self];
                [MBProgressHUD hide];
            } failure:^(NSError *error) {
                [MBProgressHUD showTip:[error errorMessage]];
            }];
        }
    }];
    [self presentViewController:alertController animated:YES completion:nil];

}

/**
 申请退款
 */
- (void)applyRefund{
    
    VPRefundApplyController * refundApplyController =[VPRefundApplyController instantiation];
    refundApplyController.orderNum =self.travelOrderDetailModel.orderNum;
    [self.navigationController pushViewController:refundApplyController animated:YES];
    NSMutableArray * refundApply =[NSMutableArray array];
    refundApply=[self.navigationController.viewControllers mutableCopy];
    [refundApply removeObjectAtIndex:refundApply.count-2];
    self.navigationController.viewControllers =refundApply;
    
}

/**
 订单支付
 */
- (void)travelPay:(VPTravelOrderDetailModel *)travelOrderDetailModel{
    
    VPSubmitOrderController * submitOrderController =[VPSubmitOrderController instantiation];
    submitOrderController.title =@"选择支付方式";
    submitOrderController.name =travelOrderDetailModel.activitieName;
    submitOrderController.price =travelOrderDetailModel.totalRealPrice;
    submitOrderController.orderID =travelOrderDetailModel.orderNum;
    submitOrderController.channelType =VPChannelTypeTravel;
    [self.navigationController pushViewController:submitOrderController animated:YES];
}

@end
