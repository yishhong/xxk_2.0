//
//  VPaddMoreTiketListController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPaddMoreTiketListController.h"
#import "VPTicketReservationTableViewCell.h"
#import "XXCellModel.h"
#import "UIColor+HUE.h"
#import "VPActivityGoodsModel.h"
#import "VPaddMoreTiketListViewModel.h"
#import "UITableViewCell+DataSource.h"

@interface VPaddMoreTiketListController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) VPaddMoreTiketListViewModel *viewModel;


@end

@implementation VPaddMoreTiketListController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Ticket" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel =[[VPaddMoreTiketListViewModel alloc]init];
    [self.viewModel tiketAddMoreTiketListModel:self.tiketArray];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView =[UIView new];
    self.view.backgroundColor =[UIColor controllerBackgroundColor];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTicketReservationTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTicketReservationTableViewCell class])];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPTicketReservationTableViewCell*ticketReservationTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VPTicketReservationTableViewCell class])];
    [ticketReservationTableViewCell xx_configCellWithEntity:cellModel];
    return ticketReservationTableViewCell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPActivityGoodsModel * activityGoodsModel =(VPActivityGoodsModel *)cellModel.dataSource;
    activityGoodsModel.type=0;
    if (self.tappedBlock) {
        self.tappedBlock(activityGoodsModel,self.indexPath);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
