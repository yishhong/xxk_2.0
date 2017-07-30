//
//  VPTicketController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketController.h"
#import "VPTicketDropView.h"
#import "UIColor+HUE.h"
#import "VPTicketTableViewCell.h"
#import "VPTicketDetailController.h"
#import "VPTicketViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "VPTicketListModel.h"
#import "UIScrollView+Refresh.h"
#import "NSError+Reason.h"
#import "VPLocationAndSearchView.h"
#import "VPSearchController.h"
#import "VPCityListController.h"
#import "UIViewController+Empty.h"

@interface VPTicketController()<UITableViewDelegate,UITableViewDataSource,VPTicketDropViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet VPTicketDropView *menuView;

@property (strong, nonatomic) VPTicketViewModel *viewModel;

@property (strong, nonatomic) VPLocationAndSearchView *locationAndSearchView;

@property (strong, nonatomic)UIBarButtonItem *searchButtonItem;

@property (strong, nonatomic) VPOpenCityInfoModel *cityModel;

@end

@implementation VPTicketController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Ticket" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.viewModel =[[VPTicketViewModel alloc]init];
    self.viewModel.locationType = self.locationType;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCityTicket) name:@"SelectCityNotification" object:nil];

    [MBProgressHUD showLoading];
    [[VPLocationManager sharedManager] loadRealCityListWithType:self.locationType success:^(NSArray *cityArray) {
        self.title = @"门票";
        self.tableView.delegate = self;
        self.tableView.dataSource = self;

        self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
        if(self.locationType == LocationCoordinateTypeTicket){
            self.locationAndSearchView = [[VPLocationAndSearchView alloc] initWithFrame:CGRectMake(0, 0, 235, 30)];
            self.navigationItem.titleView = self.locationAndSearchView;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)]];
            [self.locationAndSearchView.locationButton setTitle:self.cityModel.cityName forState:UIControlStateNormal];
            [self.locationAndSearchView.searchButton setTitle:@"输入景点名称" forState:UIControlStateNormal];
            [self.locationAndSearchView layerUIBlock:^(NSInteger tag) {
                if(tag == 1){
                    [self selectCityAction];
                }else{
                    [self searchAction];
                }
            }];
        }else{
            self.navigationItem.rightBarButtonItem = self.searchButtonItem;
        }
        [self isShowViewType:0 message:@""];
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        self.tableView.tableFooterView =[UIView new];
        self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTicketTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTicketTableViewCell class])];
        [self.tableView xx_addHeaderRefreshWithBlock:^{
            [self loadNewDateFirstLoading:YES];
        }];
        [self.tableView xx_addFooterRefreshWithBlock:^{
            [self loadNewDateFirstLoading:NO];
        }];
        [self loadNewWhereTag];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}
- (void)refreshCityTicket{
    self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    [self.locationAndSearchView.locationButton setTitle:self.cityModel.cityName forState:UIControlStateNormal];
    [self.tableView xx_beginRefreshing];
}

-(void)loadNewDateFirstLoading:(BOOL)firstLoading{

    [self.viewModel ticketIsFirstLoading:firstLoading success:^(BOOL isMore) {
        [self.tableView xx_isHasMoreData:isMore];
        [self.tableView reloadData];
        [self isShowViewType:1 message:@""];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView reloadEmptyDataSet];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

- (void)loadNewWhereTag{
    [self.viewModel TikicketWhereStrSuccess:^{
        [self.menuView configLeftData:[self.viewModel dropMenuWithLeft:YES]
                            rightData:[self.viewModel dropMenuWithLeft:NO]];
        self.menuView.delegate = self;
        //请求玩tag后请求界面
        [self loadNewDateFirstLoading:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
        [self.tableView xx_endRefreshing];
    }];
}


#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel numberOfRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPTicketTableViewCell * ticketTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VPTicketTableViewCell  class])];
    [ticketTableViewCell xx_configCellWithEntity:cellModel];
    return ticketTableViewCell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPTicketListModel *ticketListModel=cellModel.dataSource;
    VPTicketDetailController * ticketDetailController =[VPTicketDetailController instantiation];
    ticketDetailController.pid =[NSString stringWithFormat:@"%ld",ticketListModel.pid];
    [self.navigationController pushViewController:ticketDetailController animated:YES];
}

//orderby 0默认排序，1按价格排序，2.按推荐排序,3按热门排序
//whereStr tagName
#pragma mark -VPTicketDropViewDelegate
//orderby 0默认排序，1按价格排序，2.按推荐排序,3按热门排序
- (void)orderby:(NSInteger)orderby{
    [self.viewModel orderby:orderby];
    [self.tableView xx_beginRefreshing];

}

//whereStr tagName
- (void)whereStr:(NSString *)whereStr{

    [self.viewModel whereStr:whereStr];
    [self.tableView xx_beginRefreshing];

}

-(UIBarButtonItem*)searchButtonItem{
    
    if (!_searchButtonItem) {
        _searchButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    }
    return _searchButtonItem;
}
-(void)searchAction{
    VPSearchController *searchVC = [VPSearchController instantiation];
    searchVC.searchType = SearchTypeTicket;
    searchVC.cityID = self.cityModel.vid;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)selectCityAction{
    VPCityListController *cityVC = [VPCityListController instantiation];
    cityVC.locationType = self.locationType;
    [self.navigationController pushViewController:cityVC animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
