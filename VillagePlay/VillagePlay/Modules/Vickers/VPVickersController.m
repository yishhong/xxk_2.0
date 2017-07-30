//
//  VPVickersController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPVickersController.h"
#import "VPVickersViewModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPVickersDetailController.h"
#import "MBProgressHUD+Loading.h"
#import "UIScrollView+Refresh.h"
#import "NSError+Reason.h"
#import "VPGeneralWebController.h"
#import "VPMagazineModel.h"
#import "UIViewController+Empty.h"

@interface VPVickersController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPVickersViewModel *viewModel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIView * footView;

@end

@implementation VPVickersController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Vickers" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"微刊";
    self.viewModel = [[VPVickersViewModel alloc] init];
    self.tableView.tableHeaderView =self.footView;
    
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource =self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadDataWithIsFirst:YES];
    }];
    [self.tableView xx_addFooterRefreshWithBlock:^{
        [self loadDataWithIsFirst:NO];
    }];
    [MBProgressHUD showLoading];
    [self loadDataWithIsFirst:YES];
}

- (void)loadDataWithIsFirst:(BOOL)isFirst{
    [self.viewModel vickListIsFirstLoading:isFirst success:^(BOOL isMore) {
        [self isShowViewType:1 message:@""];
        [self.tableView reloadData];
        [self.tableView xx_isHasMoreData:isMore];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

//- (void)loadNewDate{
//
//   [self.viewModel vickListIsFirstLoading:NO success:^(BOOL isMore) {
//       [self.tableView reloadData];
//       [self.tableView xx_isHasMoreData:isMore];
//   } failure:^(NSError *error) {
//       [self.tableView xx_endRefreshing];
//       [MBProgressHUD showTip:[error errorMessage]];
//   }];
//}
//
//- (void)loadMoreDate{
//
//    [self.viewModel vickListIsFirstLoading:YES success:^(BOOL isMore) {
//        [self.tableView reloadData];
//        [self.tableView xx_isHasMoreData:isMore];
//    } failure:^(NSError *error) {
//        [self.tableView xx_endRefreshing];
//        [MBProgressHUD showTip:[error errorMessage]];
//    }];
//}

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPMagazineModel *magazineModel =cellModel.dataSource;
    VPGeneralWebController * generalWebController =[VPGeneralWebController instantiation];
    generalWebController.title =@"微刊详情";
    generalWebController.shareTitle =magazineModel.title;
    generalWebController.url =magazineModel.magazineUrl;
    generalWebController.channelType =VPChannelTypeMagazine;
    [self.navigationController pushViewController:generalWebController animated:YES];
//    VPVickersDetailController * vickersDetailController =[VPVickersDetailController instantiation];
//    vickersDetailController.title =@"微刊详情";
//    [self.navigationController pushViewController:vickersDetailController animated:YES];
}

-(UIView *)footView{

    if (!_footView) {
        _footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    }
    return _footView;
}

@end
