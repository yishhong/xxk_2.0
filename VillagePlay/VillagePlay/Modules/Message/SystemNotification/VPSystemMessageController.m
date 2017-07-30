//
//  VPSystemNotificationController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSystemMessageController.h"
#import "VPSystemMessageViewModel.h"
#import "VillageTitleTableViewCell.h"
#import "VillageImageTableViewCell.h"
#import "VillageSubTitleTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPSysMessageModel.h"
#import "VPGeneralWebController.h"
#import "UIViewController+Empty.h"

@interface VPSystemMessageController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) VPSystemMessageViewModel *viewModel;

@end

@implementation VPSystemMessageController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统通知";
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.viewModel =[[VPSystemMessageViewModel alloc]init];
    
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource =self;
    self.tableView.emptyDataSetDelegate = self;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadData];
    }];
    //首次加载
    [MBProgressHUD showLoading];
    [self loadData];
}
- (void)loadData{
    __weak typeof(VPSystemMessageController *)weakSelf = self;
    [self.viewModel loadSystemNotificationWithSuccess:^{
        [weakSelf isShowViewType:1 message:@""];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView xx_isHasMoreData:NO];
        [weakSelf.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [weakSelf isShowViewType:error.code message:error.errorMessage];
        [weakSelf.tableView reloadEmptyDataSet];
        [weakSelf.tableView xx_endRefreshing];
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

#pragma mark -UITableViewDelegate&&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    VPSysMessageModel * sysMessageModel = cellModel.dataSource;
    if(sysMessageModel.url.length>0){
        VPGeneralWebController *webController = [VPGeneralWebController instantiation];
        webController.url = sysMessageModel.url;
        webController.title = sysMessageModel.title;
        [self.navigationController pushViewController:webController animated:YES];
    }
}
@end
