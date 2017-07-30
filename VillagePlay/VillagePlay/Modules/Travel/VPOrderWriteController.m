//
//  VPOrderWriteController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPOrderWriteController.h"
#import "VPSubmitOrderController.h"
#import "VPDateSelectTableViewCell.h"
#import "VPNumberTableViewCell.h"
#import "VPWritInformationTableViewCell.h"
#import "VPTraveCouponTableViewCell.h"
#import "XXNibConvention.h"
#import "UIColor+HUE.h"
#import "HGViewUpglide.h"
#import "XXCellModel.h"
#import "TravelOrderWriteModel.h"
#import "VPTraveOrderCell.h"
#import "UITableViewCell+DataSource.h"
#import "VPTravelSubitLstGoods.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPExpiryDateTravelTableViewCell.h"

#define dtScreenHeight [UIScreen mainScreen].bounds.size.height
#define dtScreenWidth [UIScreen mainScreen].bounds.size.width


@interface VPOrderWriteController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property(strong, nonatomic)HGViewUpglide * couponView;

@property (strong, nonatomic)TravelOrderWriteModel *viewModel;

@property (assign, nonatomic) CGFloat price;

/**
 提交数据模型
 */
@property (strong, nonatomic)NSMutableArray * submitArray;

/**
 总价
 */
@property (assign, nonatomic) double totalRealPrice;

@property (assign, nonatomic) double actualPayment;


/**
 优惠券的坐标
 */
@property (strong, nonatomic) NSIndexPath *indexPath;

/**
 选中的优惠券
 */
@property (strong, nonatomic) VPOrderCouponModel *selectOrderCouponModel;

@end

@implementation VPOrderWriteController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Travel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

#pragma mark - cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel =[[TravelOrderWriteModel alloc]init];
    [self.viewModel travelModel:self.activeDetailModel];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    [self.tableView registerClass:[VPDateSelectTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VPDateSelectTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPNumberTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPNumberTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPWritInformationTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPWritInformationTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTraveCouponTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTraveCouponTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTraveOrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTraveOrderCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPExpiryDateTravelTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPExpiryDateTravelTableViewCell class])];

    self.tableView.tableFooterView =[UIView new];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(totalPriceChangeNotification) name:@"VPtotalPriceChangeNotification" object:nil];
    
    self.price= 0;
    self.actualPayment = 0.00f;
}

- (void)loadCouponDate{
    [MBProgressHUD showLoading];
    [self.viewModel travelCoupontype:VPChannelTypeTravel price:self.totalRealPrice success:^(NSArray *travelCouponArray) {
        if (travelCouponArray.count>0) {
            [self.couponView showAnimation:YES];
            [self.couponView fouCouponArray:travelCouponArray totalRealPrice:self.totalRealPrice];
            [MBProgressHUD hide];
        }else{
            [MBProgressHUD showTip:@"暂无可用优惠券"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    for (VPActivityGoodsModel * activityGoodsModel in self.activeDetailModel.lstActivityGoods){
        activityGoodsModel.selectedNum =@0;
    }
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.viewModel numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    if ([cellModel.identifier isEqualToString:@"VPTraveCouponTableViewCell"]) {
        self.indexPath = indexPath;
        [self loadCouponDate];
    }
    if ([self respondsToSelector:cellModel.action]) {
        [self performSelector:cellModel.action withObject:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    
}


- (void)couponPrice:(NSIndexPath *)indexPath{

    __weak typeof(VPOrderWriteController) *weakSelf = self;
    self.couponView.tappBlock =^(VPOrderCouponModel *orderCouponModel,NSString * couponCode,CGFloat discountMoney){
        weakSelf.selectOrderCouponModel = orderCouponModel;
        XXCellModel *cellModel = [weakSelf.viewModel cellForRow:indexPath.row inSection:indexPath.section];
        double money = 0.0;
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
//        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        //使用通知刷新界面
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateConponInfo" object:nil];
        if(weakSelf.totalRealPrice-money<0){
            weakSelf.actualPayment = 0.01;
        }else{
            weakSelf.actualPayment = weakSelf.totalRealPrice - money;
        }
        [weakSelf.viewModel totalRealPrice:weakSelf.totalRealPrice actualPayment:weakSelf.actualPayment conponCode:couponCode];
        weakSelf.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",weakSelf.actualPayment];
        weakSelf.price = weakSelf.actualPayment;
    };
}


/**
 购买数量改变通知
 */
-(void)totalPriceChangeNotification{
    
    NSInteger number =0;//购买总数
    self.totalRealPrice=0;//购买总价
    [self.submitArray removeAllObjects];
    for (VPActivityGoodsModel * activityGoodsModel in self.activeDetailModel.lstActivityGoods){
        self.totalRealPrice += [activityGoodsModel.selectedNum integerValue]*activityGoodsModel.presentPrice;
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
            cellModel.dataSource = @"未使用";
//            [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateConponInfo" object:nil];
            if(self.totalRealPrice-money<0){
                self.actualPayment = 0.01;
            }else{
                self.actualPayment = self.totalRealPrice - money;
            }
            [self.viewModel totalRealPrice:self.totalRealPrice actualPayment:self.actualPayment conponCode:@""];
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
            [self.viewModel totalRealPrice:self.totalRealPrice actualPayment:self.actualPayment conponCode:self.selectOrderCouponModel.couponCode];
        }
    }
    
    
    
//    else{
//        if(self.indexPath){
//            //无优惠券
//            XXCellModel *cellModel = [self.viewModel cellForRow:self.indexPath.row inSection:self.indexPath.section];
//            cellModel.dataSource = @"";
//            [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
////            [self.tableView reloadData];
//            [self.viewModel totalRealPrice:self.totalRealPrice actualPayment:0 conponCode:@""];
//
//        }
//    }
    if(self.totalRealPrice-money<0){
        self.actualPayment = 0.01;
    }else{
        self.actualPayment = self.totalRealPrice - money;
    }
    self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",self.actualPayment];
    self.price = self.totalRealPrice;
    //价格已经计算好的
    [self.viewModel totalRealPrice:self.totalRealPrice lstGoods:self.submitArray totalNumber:number actualPayment:self.actualPayment];
}

#pragma mark -respond Action
- (IBAction)submitAction:(id)sender {
    
    [MBProgressHUD showLoading];
    [self.viewModel travelWriteOrderSuccess:^(NSString *orderNum) {
        [MBProgressHUD hide];
        VPSubmitOrderController * submitOrderController =[VPSubmitOrderController instantiation];
        submitOrderController.title =@"支付方式";
        submitOrderController.price =self.price;
        submitOrderController.name =self.activeDetailModel.title;
        submitOrderController.channelType =VPChannelTypeTravel;
        submitOrderController.orderID =orderNum;

        [self.navigationController pushViewController:submitOrderController animated:YES];
        NSMutableArray * submitArray = [self.navigationController.viewControllers mutableCopy];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TravelDetailRefreshNotificationName" object:self];
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

-(NSMutableArray *)submitArray{
    
    if (!_submitArray) {
        _submitArray =[[NSMutableArray alloc]init];
    }
    return _submitArray;
}
@end
