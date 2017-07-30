//
//  VPPlayController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayController.h"
#import "VPPlayViewModel.h"
#import "UIColor+HUE.h"
#import "PlayTableViewCell.h"
#import "VPPlayDetailController.h"
#import "VPSearchController.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "UITableViewCell+DataSource.h"
#import "VPPlayListModel.h"
#import "UIViewController+Empty.h"

@interface VPPlayController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPPlayViewModel *viewModel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)UIBarButtonItem *searchButtonItem;

@end

@implementation VPPlayController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Play" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"玩法";
    self.viewModel = [[VPPlayViewModel alloc] init];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
//    self.navigationItem.rightBarButtonItem =self.searchButtonItem;
    self.tableView.tableFooterView =[UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PlayTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([PlayTableViewCell class])];
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadDataIsFirst:YES];
    }];
    [self.tableView xx_addFooterRefreshWithBlock:^{
        [self loadDataIsFirst:NO];
    }];
    
    [MBProgressHUD showLoading];
    [self loadDataIsFirst:YES];

}

- (void)loadDataIsFirst:(BOOL)isFirst{
    [self.viewModel palyListlineName:@"" title:@"" tag:@"" orderColumn:@"" orderDir:@"" isFirstLoading:isFirst success:^(BOOL isMore) {
        [self isShowViewType:1 message:@""];
        [self.tableView reloadData];
        [self.tableView xx_isHasMoreData:isMore];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView reloadEmptyDataSet];
        [self.tableView xx_endRefreshing];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPPlayListModel * playListModel =cellModel.dataSource;
    VPPlayDetailController *playDetailController =[VPPlayDetailController instantiation];
    playDetailController.playID =playListModel.fpId;
    [self.navigationController pushViewController:playDetailController animated:YES];
}

#pragma mark -Action respond
-(void)searchAction{
    
    VPSearchController *searchVC = [VPSearchController instantiation];
    //如果需要加上搜索功能 这里需要添加城市和类型
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark -setter or getter
-(UIBarButtonItem*)searchButtonItem{
    
    if (!_searchButtonItem) {
        _searchButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    }
    return _searchButtonItem;
}

@end
