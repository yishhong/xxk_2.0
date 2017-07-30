
//  VPTicketReservationController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketReservationController.h"
#import "VPTicketReservationTableViewCell.h"
#import "VPTiketDescribeTableViewCell.h"
#import "VPTraveOrderCell.h"
#import "TicketReservationModel.h"
#import "XXCellModel.h"
#import "UIColor+HUE.h"
#import "VPTicketOrderWriteController.h"
#import "UITableViewCell+DataSource.h"
#import "VPWebTableViewCell.h"
#import "VPLoginController.h"
#import "VPUserManager.h"

@interface VPTicketReservationController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) TicketReservationModel *viewModel;

@end

@implementation VPTicketReservationController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Ticket" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel =[[TicketReservationModel alloc]init];
    [self.viewModel ticketReservationModel:self.ticketDetailModel];
    self.tableView.tableFooterView =[UIView new];
    self.view.backgroundColor =[UIColor controllerBackgroundColor];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTicketReservationTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTicketReservationTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTiketDescribeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTiketDescribeTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTraveOrderCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTraveOrderCell class])];
    
    [self.tableView registerClass:[VPWebTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VPWebTableViewCell class])];
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

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *activityGoodsArray =[[NSMutableArray alloc]init];
    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    if ([cellModel.identifier isEqualToString:@"VPTicketReservationTableViewCell"]) {
        if([VPUserManager sharedInstance].xx_userinfoID.length<1){
            UIViewController * loginController =[VPLoginController instantiation];
            [self presentViewController:loginController animated:YES completion:nil];
            return;
        }
        VPActivityGoodsModel *selectActivityGoodsModel =cellModel.dataSource;
        [activityGoodsArray addObject:selectActivityGoodsModel];
        
        for (VPActivityGoodsModel *activityGoodsModel in self.ticketDetailModel.ticketGoods) {
            if(selectActivityGoodsModel.pid == activityGoodsModel.pid){
                activityGoodsModel.type = 1;
            }else{
                activityGoodsModel.type = 2;
            }
        }
        VPTicketOrderWriteController *ticketOrderWriteController =[VPTicketOrderWriteController instantiation];
        ticketOrderWriteController.ticketDetailModel = self.ticketDetailModel;
        [self.navigationController pushViewController:ticketOrderWriteController animated:YES];
    }
}

@end
