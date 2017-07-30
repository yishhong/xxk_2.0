//
//  VPTravelController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelController.h"
#import "UINavigationBar+Awesome.h"
#import "UIImageView+VPWebImage.h"
#import "Masonry.h"
#import "VPTravelTableViewCell.h"
#import "VPTravelDetailController.h"
#import "UIColor+HUE.h"
#import "VPTravelViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "UIScrollView+Refresh.h"
#import "NSError+Reason.h"
#import "VPActiveModel.h"
#import "UIViewController+Empty.h"

#define NAVBAR_CHANGE_POINT 50


@interface VPTravelController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) VPTravelViewModel *viewModel;
@end

@implementation VPTravelController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Travel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.viewModel =[[VPTravelViewModel alloc]init];
    self.viewModel.locationType = self.locationType;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView =[UIView new];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTravelTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTravelTableViewCell class])];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTravelListDate:) name:@"VPRefreshTravelListDate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCityTravel) name:@"SelectCityNotification" object:nil];

    
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadDataIsFirst:YES];
    }];
    [self.tableView xx_addFooterRefreshWithBlock:^{
        [self loadDataIsFirst:NO];
    }];
    [MBProgressHUD showLoading];
    [self loadDataIsFirst:YES];
    
}
- (void)refreshCityTravel{
    [self.tableView xx_beginRefreshing];
}
- (void)refreshTravelListDate:(NSNotification *)notification{

    NSDictionary * info =notification.userInfo;
    self.sortType = info[@"selectIndex"];
    [self.tableView xx_beginRefreshing];
}
- (void)loadDataIsFirst:(BOOL)isFirst{
    [self.viewModel travelListprovinceID:self.provinceID city:self.city isSuggest:@"0" sortType:self.sortType location:self.location tag:self.tag IsFirstLoading:isFirst success:^(BOOL isMore) {
        [self isShowViewType:1 message:@""];
        [self.tableView xx_isHasMoreData:isMore];
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

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel numberOfRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
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
    VPActiveModel *activeModel =cellModel.dataSource;
    VPTravelDetailController * travelDetailController =[VPTravelDetailController instantiation];
    travelDetailController.travelID =activeModel.vid;
    [self.navigationController pushViewController:travelDetailController animated:YES];
}

@end
