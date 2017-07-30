//
//  VPRefundApplyController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRefundApplyController.h"
#import "VPRefundApplyViewModel.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPTraveOrderCell.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "TravelRefundReasonTableViewCell.h"
#import "TravelWritRefundReasonTableViewCell.h"

@interface VPRefundApplyController ()<UITableViewDelegate,UITableViewDataSource,TravelWritRefundReasonTableViewCellDetegate>

@property (nonatomic, strong) VPRefundApplyViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger selectIndex;
@property (strong, nonatomic) NSString * reasonString;

@end

@implementation VPRefundApplyController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TravelOrder" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex =-1;
    self.title =@"申请退款";
    self.reasonString =@"";
    self.viewModel = [[VPRefundApplyViewModel alloc] init];
    [self.viewModel layerUI:nil];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTraveOrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTraveOrderCell class])];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==2||section==3) {
        return 1;
    }else if (section==1){
    
        return [self.viewModel refundReason].count;
    }
    return [self.viewModel numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        VPTraveOrderCell * traveOrderCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VPTraveOrderCell class])];
        traveOrderCell.nameLabel.text =@"退款原因(至少选取一项)";
        return traveOrderCell;
    }else if (indexPath.section==1){
    
        TravelRefundReasonTableViewCell * travelRefundReasonTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TravelRefundReasonTableViewCell class])];
        travelRefundReasonTableViewCell.nameLabel.text =[self.viewModel refundReason][indexPath.row];
        if (self.selectIndex ==indexPath.row) {
            
            travelRefundReasonTableViewCell.slectImageView.image =[UIImage imageNamed:@"icon_round_sel"];
            
        }else{
            
            travelRefundReasonTableViewCell.slectImageView.image =[UIImage imageNamed:@"icon_collection_nor_white"];
            
        }
        return travelRefundReasonTableViewCell;
        
    }else if (indexPath.section==2){
        
        VPTraveOrderCell * traveOrderCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VPTraveOrderCell class])];
        traveOrderCell.nameLabel.text =@"其他,请手动填写";
        return traveOrderCell;
    }else if (indexPath.section==3){
    
        TravelWritRefundReasonTableViewCell *travelWritRefundReasonTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TravelWritRefundReasonTableViewCell class])];
        travelWritRefundReasonTableViewCell.detegate =self;
        return travelWritRefundReasonTableViewCell;
    }else{
        
        XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
        [cell xx_configCellWithEntity:cellModel];
        return cell;
    }
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
     
        self.selectIndex =indexPath.row;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==4) {
     
        XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
        return cellModel.height;
        
    }else if (indexPath.section==3){
    
        return 100;
    }else{
    
        return 45;
    }
}

#pragma TravelWritRefundReasonTableViewCellDetegate
- (void)refundReasonString:(NSString *)refundReasonString{

    self.reasonString=refundReasonString;
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    [MBProgressHUD showLoading];

    if (self.selectIndex==-1) {
     
        [MBProgressHUD showTip:@"请选择退款原因"];
    }else{
        [MBProgressHUD hide];
        NSString *redundReason =[NSString stringWithFormat:@"%@;%@",[self.viewModel refundReason][self.selectIndex],self.reasonString];
        [self.viewModel travelRefunReason:redundReason orderNum:self.orderNum success:^{
            [MBProgressHUD showTip:@"退款成功"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refundRefreshNotificationName" object:self];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            [MBProgressHUD showTip:[error errorMessage]];
        }];
    }
}

@end
