//
//  VPSubmitOrderController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSubmitOrderController.h"
#import "VPSubmitTableViewCell.h"
#import "VPPayWayTableViewCell.h"
#import "VPPayTableViewCell.h"
#import "VPOrdercompleteController.h"
#import "UIColor+HUE.h"
#import "VPSubmitOrderModel.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "VPNavigationController.h"

@interface VPSubmitOrderController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (assign, nonatomic)NSInteger selectIndex;

@property (strong, nonatomic)VPSubmitOrderModel *viewModel;

@end

@implementation VPSubmitOrderController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Travel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel =[[VPSubmitOrderModel alloc]init];
    [self.viewModel payWayModel:nil];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPSubmitTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPSubmitTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPPayWayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPPayWayTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPPayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPPayTableViewCell class])];
    self.selectIndex=0;
    self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",self.price];
    self.tableView.tableFooterView =[UIView new];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccessNotification) name:@"VPWeChatPaySuccessChangeNotification" object:nil];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            VPSubmitTableViewCell * submitTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VPSubmitTableViewCell  class])];
            submitTableViewCell.nameLabel.text =self.name;
            submitTableViewCell.priceLabel.text =[NSString stringWithFormat:@"应付总额:%.2f",self.price];
            submitTableViewCell.selectionStyle =UITableViewCellSelectionStyleNone;
            return submitTableViewCell;
        }else{
            
            VPPayWayTableViewCell *payWayTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VPPayWayTableViewCell class])];
            payWayTableViewCell.selectionStyle =UITableViewCellSelectionStyleNone;
            return payWayTableViewCell;
        }

    }else{
    
        VPPayTableViewCell *payTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VPPayTableViewCell class])];
        if (indexPath.row==0) {
            
            payTableViewCell.payWayImageView.image =[UIImage imageNamed:@"tab_pay_wechat"];
            payTableViewCell.payTypeLabel.text =@"微信支付";
        }else{
        
            payTableViewCell.payWayImageView.image =[UIImage imageNamed:@"tab_pay_alipay"];
            payTableViewCell.payTypeLabel.text =@"支付宝支付";
        }
        if (self.selectIndex==indexPath.row) {
            payTableViewCell.selectImageView.image =[UIImage imageNamed:@"icon_round_sel"];
        }else{
            payTableViewCell.selectImageView.image =[UIImage imageNamed:@""];
        }
        return payTableViewCell;
    }
    
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            return 95;
        }else{
            
            return 70;
        }
    }else{
    
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        self.selectIndex =indexPath.row;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)orderAction:(id)sender {
    
    if (self.selectIndex==0) {
        [MBProgressHUD showLoading];
        [self.viewModel travelWeChatPay:self.orderID channelType:self.channelType success:^(VPWeChatModel *weChatModel) {
            VPWeChatModel * wxpayModel =weChatModel;
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = wxpayModel.appid;
            req.partnerId           = wxpayModel.partnerid;
            req.prepayId            = wxpayModel.prepayid;
            req.nonceStr            = wxpayModel.noncestr;
            req.timeStamp           = wxpayModel.timestamp.intValue;
            req.package             = wxpayModel.package;
            req.sign                = wxpayModel.sign;
            [WXApi sendReq:req];
            [MBProgressHUD hide];
        } failure:^(NSError *error) {
            [MBProgressHUD showTip:[error errorMessage]];
        }];
    }else{
        [MBProgressHUD showLoading];
        [self.viewModel travelAlipayOutTradeNo:self.orderID channelType:self.channelType success:^(NSString *orderString) {
            NSString *appScheme = @"VillagePlayAlipay";
            NSString *orderStr = orderString;
            NSLog(@"%@",orderString);
            [MBProgressHUD hide];
            [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                NSString * resultStatus = resultDic[@"resultStatus"];
//                if([resultStatus isEqualToString:@"9000"]){
//                    [MBProgressHUD hide];
//                    [MBProgressHUD showTip:@"支付成功"];
//                    
//                }else if([resultStatus isEqualToString:@"4000"]) {
//                    [MBProgressHUD hide];
//                    [MBProgressHUD showTip:@"订单重复"];
//                    
//                }else{
//                    [MBProgressHUD hide];
//                    [MBProgressHUD showTip:@"支付失败"];
//                    
//                }
            }];
        } failure:^(NSError *error) {
            [MBProgressHUD showTip:[error errorMessage]];
        }];
    }
}

- (void)paySuccessNotification{
                        VPOrdercompleteController *ordercompleteController =[VPOrdercompleteController instantiation];
                        VPNavigationController *navigation = [[VPNavigationController alloc] initWithRootViewController:ordercompleteController];
                        ordercompleteController.price =self.price;
                        ordercompleteController.paymethod =@"在线支付";
                        ordercompleteController.channelType =self.channelType;
                        ordercompleteController.title =@"订单支付成功";
                        [self presentViewController:navigation animated:YES completion:^{
                            NSArray *navArray = self.navigationController.viewControllers;
                            NSMutableArray *navMutableArray =[NSMutableArray arrayWithObject:[navArray objectAtIndex:0]];
                            self.navigationController.viewControllers = navMutableArray;
                        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
