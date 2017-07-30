//
//  VPHotelSubmitOrderController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelSubmitOrderController.h"
#import "VPSubmitOrderController.h"
#import "VPHotelInformtionTableViewCell.h"
#import "VPHotelRoomNumTableViewCell.h"
#import "VPPhoneNumberTableViewCell.h"
#import "VPTraveCouponTableViewCell.h"
#import "VPHotelRemoveTableViewCell.h"
#import "UIColor+HUE.h"
#import "HGViewUpglide.h"
#import "VPBlankLinesTableViewCell.h"
#import "HotelSubmitOrderModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "NSError+Reason.h"
#import "MBProgressHUD+Loading.h"
#import "QMActionView.h"
#import "NSError+Reason.h"
#import "UIScrollView+Refresh.h"

@interface VPHotelSubmitOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic)HGViewUpglide *upglideMenum;

@property(strong, nonatomic)HotelSubmitOrderModel *viewModel;

@property (assign, nonatomic) CGFloat totalRealPrice;

@property (assign, nonatomic) CGFloat price;

@end

@implementation VPHotelSubmitOrderController
+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Hotel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.totalRealPrice =0;
    self.price=0;
    self.title =@"订单填写";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.viewModel=[[HotelSubmitOrderModel alloc]init];
    self.tableView.tableFooterView =[UIView new];
    self.view.backgroundColor =[UIColor controllerBackgroundColor];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelInformtionTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelInformtionTableViewCell class])];
    
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelRoomNumTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelRoomNumTableViewCell class])];
    
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPPhoneNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPPhoneNumberTableViewCell class])];
    
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTraveCouponTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTraveCouponTableViewCell class])];
    
            [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelRemoveTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelRemoveTableViewCell class])];
         //空行
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];

    [MBProgressHUD showLoading];
    [self loadNewDate:self.submitInfo];
}

- (void)loadNewDate:(NSDictionary *)submitInfo{

    [self.viewModel hotelSubmitRoomId:self.submitInfo[@"roomID"] beginTime:self.submitInfo[@"checkTime"] endTime:self.submitInfo[@"outTime"] submitInfo:self.submitInfo success:^(NSString *price) {
        self.totalRealPrice =[price floatValue];
        self.priceLabel.text =[NSString stringWithFormat:@"￥%.2lf",self.totalRealPrice];
        [self.tableView reloadData];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
        [self.tableView xx_endRefreshing];
    }];
}

- (void)loadCouponDate{
    [MBProgressHUD showLoading];
    [self.viewModel tiketCoupontype:VPChannelTypeHotel price:self.totalRealPrice success:^(NSArray *travelCouponArray) {
        if (travelCouponArray.count>0) {
            [self.upglideMenum showAnimation:YES];
            [self.upglideMenum fouCouponArray:travelCouponArray totalRealPrice:self.totalRealPrice];
            [MBProgressHUD hide];
        }else{
            [MBProgressHUD showTip:@"暂无可用优惠券"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}


#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];

    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    if ([cellModel.identifier isEqualToString:@"VPTraveCouponTableViewCell"]) {
        
        [self loadCouponDate];
        if ([self respondsToSelector:cellModel.action]) {
            [self performSelector:cellModel.action withObject:indexPath];
        }
    }
    if ([cellModel.identifier isEqualToString:@"VPHotelRoomNumTableViewCell"]) {
        __weak typeof(VPHotelSubmitOrderController) * weakSelf = self;
        [QMActionView showActionViewType:QMActionViewTypeSelector withDetails:@{@"title":@"房间数",
                          @"dataSource":@[[self.viewModel hotelRoomNumber]]} confirm:^(id object) {
                              
                              [weakSelf.viewModel selectRoomNum:[object integerValue]];
                              
                              CGFloat payMoney = [weakSelf.viewModel paymentAmount];
                              
                              weakSelf.priceLabel.text =[NSString stringWithFormat:@"￥%.2lf",payMoney];
                              weakSelf.price =payMoney;
                              
//                              [weakSelf.viewModel updateSelectRoomNumber:object payMoney:payMoney];
                              [weakSelf.tableView reloadData];
        } cancel:^{
            
        }];
    }
}

- (void)couponPrice:(NSIndexPath *)indexPath{
//优惠券
    __weak typeof(VPHotelSubmitOrderController) *weakSelf = self;
    
    self.upglideMenum.tappBlock =^(VPOrderCouponModel *orderCouponModel,NSString * couponCode,CGFloat discountMoney){
        [weakSelf.viewModel selectConpon:orderCouponModel];
        
        XXCellModel *cellModel = [weakSelf.viewModel cellForRow:indexPath.row inSection:indexPath.section];
        
        discountMoney = [weakSelf.viewModel paymentAmount];

//        NSMutableDictionary *cellInfo = cellModel.dataSource;
        
//        cellInfo[@"value"] = [NSString stringWithFormat:@"已优惠%.2f元",[weakSelf.viewModel preferentialAmount]];
//        cellModel.dataSource =[NSString stringWithFormat:@"已优惠%.2f元",weakSelf.price-discountMoney];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        [weakSelf.viewModel totalRealPrice:weakSelf.price actualPayment:discountMoney conponCode:couponCode discount:weakSelf.price-discountMoney];
        weakSelf.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",discountMoney];
        weakSelf.price = discountMoney;
    };
}

- (IBAction)submitOrderAction:(id)sender {
    
    VPHotelRoomListRoomModel *roomListRoomModel =self.submitInfo[@"roomListRoomModel"];
    [MBProgressHUD showLoading];
    [self.viewModel hotelSubmitOrderSuccess:^(NSString *orderID) {
        VPSubmitOrderController * submitOrderController =[VPSubmitOrderController instantiation];
        submitOrderController.orderID =orderID;
        submitOrderController.name = roomListRoomModel.name;
        submitOrderController.price = [self.viewModel paymentAmount];
        submitOrderController.channelType = VPChannelTypeHotel;
        submitOrderController.title =@"选择支付方式";
        [self.navigationController pushViewController:submitOrderController animated:YES];
        NSMutableArray * submitArray = [self.navigationController.viewControllers mutableCopy];
        [submitArray removeObjectAtIndex:[submitArray count]-2];
        self.navigationController.viewControllers = submitArray;
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

#pragma mark -setter or getter
-(HGViewUpglide *)upglideMenum{
    
    if (!_upglideMenum) {
        _upglideMenum =[[HGViewUpglide alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _upglideMenum;
}

@end
