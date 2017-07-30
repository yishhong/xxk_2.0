//
//  VPTopicController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicController.h"
#import "VPTopicViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPTopicDetailController.h"
#import "VPSearchController.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPTopicListModel.h"
#import "VPGeneralWebController.h"
#import "UIViewController+Empty.h"

@interface VPTopicController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPTopicViewModel *viewModel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)UIBarButtonItem *searchButtonItem;

@property (strong, nonatomic)UIView * footView;

@end

@implementation VPTopicController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Topic" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"专题";
//    self.navigationItem.rightBarButtonItem =self.searchButtonItem;
    self.viewModel = [[VPTopicViewModel alloc] init];
    self.tableView.tableFooterView =self.footView;
    
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
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
    [self.viewModel topicListIsFirstLoading:isFirst success:^(BOOL isMore) {
        [self.tableView xx_isHasMoreData:isMore];
        [self isShowViewType:1 message:@""];
        [self.tableView reloadData];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView reloadEmptyDataSet];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:error.errorMessage];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPTopicListModel *topicListModel = cellModel.dataSource;

//    VPTopicDetailController *topicDetailController =[VPTopicDetailController instantiation];
//    topicDetailController.title =topicListModel.projectName;
//    topicDetailController.topicID =topicListModel.projectID;
//    [self.navigationController pushViewController:topicDetailController animated:YES];
    VPGeneralWebController *webVC = [VPGeneralWebController instantiation];
    webVC.url = topicListModel.projectUrl;
    webVC.shareTitle = topicListModel.projectName;
    webVC.channelType =VPChannelTypeTopic;
    webVC.title =@"专题详情";
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark Action - respond
/**
 *  搜索
 */
-(void)searchAction{

    VPSearchController *searchVC = [VPSearchController instantiation];
    //暂无搜索 如果需要加上需要添加城市和搜索类型
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark -setter or getter
-(UIBarButtonItem*)searchButtonItem{
    
    if (!_searchButtonItem) {
        _searchButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    }
    return _searchButtonItem;
}

-(UIView *)footView{

    if (!_footView) {
        _footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
        _footView.backgroundColor =[UIColor whiteColor];
    }
    return _footView;
}

@end
