//
//  VPStatusListController.mController
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPStatusListController.h"
#import "VPStatusListViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPBlankLinesTableViewCell.h"
#import "UIColor+HUE.h"

@interface VPStatusListController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VPStatusListViewModel *viewModel;

@end

@implementation VPStatusListController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StatusList" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"退款详情";
    self.viewModel = [[VPStatusListViewModel alloc] init];
    self.tableView.estimatedRowHeight = 10;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadNewDate:self.channelType];
    self.view.backgroundColor =[UIColor controllerBackgroundColor];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
}

- (void)loadNewDate:(VPChannelType)channelType{

    if (channelType== VPChannelTypeTravel) {
        
        [self.viewModel travelRefundDetailRefundID:self.orderNum success:^{
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [MBProgressHUD showTip:[error errorMessage]];
        }];
    }else if (channelType==VPChannelTypeHotel){
    
        [self.viewModel hotelRefundDetailOrder:self.orderNum success:^{
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [MBProgressHUD showTip:[error errorMessage]];
        }];
    }else if (channelType ==VPChannelTypeTicket){
    
        [self.viewModel ticketRefundDetailOrderNum:self.orderNum success:^{
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [MBProgressHUD showTip:[error errorMessage]];
        }];
    }
}


#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXCellModel *cellModel = [self.viewModel cellForRowAtIndexPath:indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
