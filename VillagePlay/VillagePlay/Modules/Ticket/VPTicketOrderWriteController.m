//
//  VPTicketOrderWriteController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketOrderWriteController.h"
#import "VPTiketDateUsedTableViewCell.h"
#import "VPTiketNumberTableViewCell.h"
#import "VPAddTiketTableViewCell.h"
#import "VPBuyTiketExplainTableViewCell.h"
#import "VPTraveOrderCell.h"
#import "VPPhoneNumberTableViewCell.h"
#import "VPTraveCouponTableViewCell.h"
#import "TiketOrderWriteModel.h"
#import "XXCellModel.h"
#import "UIColor+HUE.h"
#import "HGViewUpglide.h"
#import "VPSubmitOrderController.h"
#import "VPaddMoreTiketListController.h"
#import "UITableViewCell+DataSource.h"
#import "VPBlankLinesTableViewCell.h"
#import "VPTravelSubitLstGoods.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPCalendarOneController.h"

@interface VPTicketOrderWriteController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic)TiketOrderWriteModel *viewModel;
@property (strong ,nonatomic)HGViewUpglide *couponView;

/**
 提交数组
 */
@property (strong, nonatomic)NSMutableArray * submitArray;

/**
 默认选中门票总价
 */
@property (assign, nonatomic)CGFloat totalRealPrice;

@property (assign, nonatomic)CGFloat price;

/**
 优惠券的坐标
 */
@property (strong, nonatomic) NSIndexPath *indexPath;

/**
 选中的优惠券
 */
@property (strong, nonatomic) VPOrderCouponModel *selectOrderCouponModel;

/**
 优惠后的价格
 */
@property (assign, nonatomic) double actualPayment;



@end

@implementation VPTicketOrderWriteController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Ticket" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.price =0;
    self.submitArray =[NSMutableArray array];
    self.viewModel =[[TiketOrderWriteModel alloc]init];
    [self.viewModel tiketOrderWriteModel:self.ticketDetailModel];
    self.tableView.tableFooterView =[UIView new];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.view.backgroundColor =[UIColor controllerBackgroundColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTiketDateUsedTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTiketDateUsedTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTiketNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTiketNumberTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPAddTiketTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPAddTiketTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBuyTiketExplainTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBuyTiketExplainTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTraveOrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTraveOrderCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPPhoneNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPPhoneNumberTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTraveCouponTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTraveCouponTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(totalPriceChangeNotification) name:@"VPtotalPriceChangeNotification" object:nil];
    
}

- (void)loadCouponDate{
    
    [self.viewModel tiketCoupontype:VPChannelTypeTicket price:self.totalRealPrice success:^(NSArray *travelCouponArray) {
        if (travelCouponArray.count>0) {
            [self.couponView showAnimation:YES];
            [self.couponView fouCouponArray:travelCouponArray totalRealPrice:self.totalRealPrice];
        }else{
            [MBProgressHUD showTip:@"暂无可用优惠券"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    for (VPActivityGoodsModel * activityGoodsModel in self.ticketDetailModel.ticketGoods){
        activityGoodsModel.selectedNum =@0;
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    if ([cellModel.identifier isEqualToString:@"VPTiketDateUsedTableViewCell"]) {
        
        //更多日期
    }else if ([cellModel.identifier isEqualToString:@"VPAddTiketTableViewCell"]){
    
        //添加门票
        VPaddMoreTiketListController *ticketReservationController =[VPaddMoreTiketListController instantiation];
        ticketReservationController.title =@"添加门票";
        ticketReservationController.tiketArray =[self.ticketDetailModel.ticketGoods copy];
        ticketReservationController.indexPath =indexPath;        
        ticketReservationController.tappedBlock=^(VPActivityGoodsModel *activityGoodsModel,NSIndexPath *index){
            if(self.indexPath){
                self.indexPath = [NSIndexPath indexPathForRow:self.indexPath.row+2 inSection:self.indexPath.section];
            }
            NSIndexPath * deleteIndexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            NSIndexPath * linkIndexPath =[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            [self.viewModel addTiketDate:activityGoodsModel indexPath:indexPath];
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[deleteIndexPath,linkIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        };
        [self.navigationController pushViewController:ticketReservationController animated:YES];
    }else if ([cellModel.identifier isEqualToString:@"VPTraveCouponTableViewCell"]) {
        self.indexPath = indexPath;
        [self loadCouponDate];
    }
    if ([self respondsToSelector:cellModel.action]) {
        [self performSelector:cellModel.action withObject:indexPath];
    }}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    if([cellModel.identifier isEqualToString:@"VPAddDeleteTableViewCell"]){
        VPActivityGoodsModel *activityGoodsModel =cellModel.dataSource;
        activityGoodsModel.type=2;
        if (view.tag==10) {
            activityGoodsModel.selectedNum = 0;
            if(self.indexPath){
                self.indexPath = [NSIndexPath indexPathForRow:self.indexPath.row-2 inSection:self.indexPath.section];
            }
            NSIndexPath * deleteIndexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            NSIndexPath * linkIndexPath =[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            [self.viewModel deleteTietDate:activityGoodsModel indexPath:indexPath];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[deleteIndexPath,linkIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            [self totalPriceChangeNotification];
        }
    }
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view data:(id)data{
    NSInteger index = [(NSNumber *)data integerValue];
    if(index==2){
        VPCalendarOneController *calendarOne = [VPCalendarOneController instantiation];
        calendarOne.selectDate =  self.viewModel.dayDict[@"selectDate"];
        calendarOne.selectDateBlock = ^(NSInteger day,NSInteger month, NSInteger year){
            NSLog(@"%zd %zd %zd",day,month,year);
            self.viewModel.dayDict[@"selectDate"] = [NSString stringWithFormat:@"%zd-%zd-%zd",year,month,day];
            self.viewModel.dayDict[@"selectTime"] = [NSString stringWithFormat:@"%zd-%zd",month,day];
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:calendarOne animated:YES];
    }else{
        NSMutableDictionary *dayDict = [self.viewModel.dayDict[@"lstActivityDate"] objectAtIndex:index];
        self.viewModel.dayDict[@"selectDate"] = dayDict[@"date"];
        self.viewModel.dayDict[@"selectTime"] = dayDict[@"time"];
        [self.tableView reloadData];
    }
}

- (void)couponPrice:(NSIndexPath *)indexPath{
    
    __weak typeof(VPTicketOrderWriteController) *weakSelf = self;
    self.couponView.tappBlock =^(VPOrderCouponModel *orderCouponModel,NSString * couponCode,CGFloat discountMoney){
        __strong typeof(VPTicketOrderWriteController) *strongSelf = weakSelf;
        XXCellModel *cellModel = [strongSelf.viewModel cellForRow:indexPath.row inSection:indexPath.section];
        weakSelf.selectOrderCouponModel = orderCouponModel;

        double money= 0.00f;
        if(weakSelf.selectOrderCouponModel){
            switch (weakSelf.selectOrderCouponModel.discountType) {
                case 0:
                case 1:{
                    //满减
                    money = weakSelf.selectOrderCouponModel.discountMoney;
                }break;
                case 2:{
                    //折扣
                    money = weakSelf.totalRealPrice - weakSelf.totalRealPrice*(self.selectOrderCouponModel.discountValue/100.0);
                }break;
                default:
                    break;
            }
        }else{
            money = 0.00f;
        }
        if(orderCouponModel){
            cellModel.dataSource =[NSString stringWithFormat:@"已优惠%.2f元",money];
        }else{
            cellModel.dataSource = @"未使用";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateConponInfo" object:nil];

        
        if(weakSelf.totalRealPrice-money<0){
            weakSelf.actualPayment = 0.01;
        }else{
            weakSelf.actualPayment = weakSelf.totalRealPrice - money;
        }
        [strongSelf.viewModel totalRealPrice:strongSelf.totalRealPrice actualPayment:weakSelf.actualPayment conponCode:couponCode discount:money];
        strongSelf.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",weakSelf.actualPayment];
        strongSelf.price = weakSelf.actualPayment;
    };
}

/**
 购买数量改变通知
 */
-(void)totalPriceChangeNotification{
    
    NSInteger number =0;//购买总数(多余)
    self.totalRealPrice=0;//购买总价
    [self.submitArray removeAllObjects];
    for (VPActivityGoodsModel * activityGoodsModel in self.ticketDetailModel.ticketGoods){
        self.totalRealPrice += [activityGoodsModel.selectedNum integerValue]*activityGoodsModel.presentPrice;
        self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",self.totalRealPrice];
        number +=[activityGoodsModel.selectedNum integerValue];
        if (![activityGoodsModel.selectedNum isEqualToNumber:@(0)]) {
            
            VPTravelSubitLstGoods * goodListModel = [VPTravelSubitLstGoods new];
            goodListModel.goodsID=[NSString stringWithFormat:@"%ld",(long)  activityGoodsModel.goodsID];
            goodListModel.number =[NSString stringWithFormat:@"%@",activityGoodsModel.selectedNum];
            goodListModel.corPersonNum = activityGoodsModel.corPersonNum;
            goodListModel.goodsName =activityGoodsModel.goodsName;
            [self.submitArray addObject:goodListModel];
        }
    }
    double money= 0.00f;
    if(self.selectOrderCouponModel){
        if(self.selectOrderCouponModel.amount !=0&& self.totalRealPrice<self.selectOrderCouponModel.amount){
            self.selectOrderCouponModel = nil;
            XXCellModel *cellModel = [self.viewModel cellForRow:self.indexPath.row inSection:self.indexPath.section];
            cellModel.dataSource = @"";
            //            [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateConponInfo" object:nil];
            if(self.totalRealPrice-money<0){
                self.actualPayment = 0.01;
            }else{
                self.actualPayment = self.totalRealPrice - money;
            }
            [self.viewModel totalRealPrice:self.totalRealPrice actualPayment:self.actualPayment conponCode:@"" discount:0];
//            [self.viewModel totalRealPrice:self.totalRealPrice actualPayment:self.actualPayment conponCode:@""];
        }else{
            XXCellModel *cellModel = [self.viewModel cellForRow:self.indexPath.row inSection:self.indexPath.section];
            if(self.selectOrderCouponModel){
                switch (self.selectOrderCouponModel.discountType) {
                    case 0:
                    case 1:{
                        //满减
                        money = self.selectOrderCouponModel.discountMoney;
                    }break;
                    case 2:{
                        //折扣
                        money = self.totalRealPrice - self.totalRealPrice*(self.selectOrderCouponModel.discountValue/100.0);
                    }break;
                    default:
                        break;
                }
            }else{
                money = 0.00f;
            }
            cellModel.dataSource =[NSString stringWithFormat:@"已优惠%.2f元",money];
            //            [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateConponInfo" object:nil];
            if(self.totalRealPrice-money<0){
                self.actualPayment = 0.01;
            }else{
                self.actualPayment = self.totalRealPrice - money;
            }
            [self.viewModel totalRealPrice:self.totalRealPrice actualPayment:self.actualPayment conponCode:self.selectOrderCouponModel.couponCode discount:money];
//            [self.viewModel totalRealPrice:self.totalRealPrice actualPayment:self.actualPayment conponCode:self.selectOrderCouponModel.couponCode];
        }
    }
    
    if(self.totalRealPrice-money<0){
        self.actualPayment = 0.01;
    }else{
        self.actualPayment = self.totalRealPrice - money;
    }
    [self.viewModel totalRealPrice:self.totalRealPrice lstGoods:self.submitArray totalNumber:number actualPayment:self.actualPayment discount:money];
    self.price = self.totalRealPrice;
    self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",self.actualPayment];
}

- (IBAction)submitAction:(id)sender {
    
    [MBProgressHUD showLoading];
    VPTicketListModel *ticketListModel =self.ticketDetailModel.ticket;
    [self.viewModel tiketOrderWriteSubitSuccess:^(NSString *orderNum) {
        VPSubmitOrderController *submitOrderController =[VPSubmitOrderController instantiation];
        [MBProgressHUD hide];
        submitOrderController.price =self.price;
        submitOrderController.channelType =VPChannelTypeTicket;
        submitOrderController.orderID =orderNum;
        submitOrderController.name =ticketListModel.title;
        submitOrderController.title =@"支付方式";
        [self.navigationController pushViewController:submitOrderController animated:YES];
        NSMutableArray * submitArray = [self.navigationController.viewControllers mutableCopy];
        [submitArray removeObjectAtIndex:[submitArray count]-2];
        self.navigationController.viewControllers = submitArray;
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

#pragma mark -setter or getter
-(HGViewUpglide *)couponView{
    
    if (!_couponView) {
        _couponView =[[HGViewUpglide alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _couponView;
}


@end
