//
//  VPBeautifulVillageController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBeautifulVillageController.h"
#import "VPBeautifulVillageViewModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "BeautifulVillageTableViewCell.h"
#import "VPBeautifulVillageDetailController.h"
#import "VPSearchController.h"
#import "VPVillageDropView.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "UIScrollView+Refresh.h"
#import "VPVillageModel.h"
#import "VPLocationAndSearchView.h"
#import "NSError+Reason.h"
#import "VPCityListController.h"
#import "UIViewController+Empty.h"

@interface VPBeautifulVillageController ()<UITableViewDataSource,UITableViewDelegate,VPVillageDropViewDelegate>

@property (nonatomic, strong) VPBeautifulVillageViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet VPVillageDropView *menuView;
@property (strong, nonatomic)UIBarButtonItem *searchButtonItem;
@property (strong, nonatomic) VPLocationAndSearchView *locationAndSearchView;

@property (strong, nonatomic) VPOpenCityInfoModel *cityModel;


@end

@implementation VPBeautifulVillageController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Village" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"乡村";
    self.menuView.delegate =self;
    self.viewModel = [[VPBeautifulVillageViewModel alloc] init];
    self.viewModel.type = self.type;
    //刷新城市的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCityVillage) name:@"SelectCityNotification" object:nil];
    
    self.viewModel.locationType = self.locationType;
    [MBProgressHUD showLoading];
    
    self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    
    if(self.locationType == LocationCoordinateTypeVillage){
        //最美乡村的全部精选的村庄
        self.viewModel.type =2;
        self.title = @"最美乡村";
        self.navigationItem.rightBarButtonItem = self.searchButtonItem;
    }else{
        if(self.viewModel.type !=2){
            self.title = @"乡村";
        }else{
            self.title = @"必玩乡村";
        }
        self.navigationItem.rightBarButtonItem = self.searchButtonItem;
    }
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BeautifulVillageTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([BeautifulVillageTableViewCell class])];
    
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadDataWithIsFirst:YES];
    }];
    [self.tableView xx_addFooterRefreshWithBlock:^{
        [self loadDataWithIsFirst:NO];
    }];
    
    [MBProgressHUD showLoading];
    [self loadNewTag];
}

- (void)refreshCityVillage{
    self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    [self.locationAndSearchView.locationButton setTitle:self.cityModel.cityName forState:UIControlStateNormal];
    [self.tableView xx_beginRefreshing];
}

- (void)loadNewTag{

    [self.viewModel villageTagListSuccess:^(NSArray *tags) {
        [self.menuView configLeftData:tags rightData:nil];
        [self loadDataWithIsFirst:YES];

    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

- (void)loadDataWithIsFirst:(BOOL) isFirst{
    
    [self.viewModel villageListWithIsFirst:isFirst success:^(BOOL isMore) {
        [self.tableView xx_isHasMoreData:isMore];
        [self isShowViewType:1 message:@""];
        [self.tableView reloadData];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPVillageModel *villageModel =cellModel.dataSource;
    VPBeautifulVillageDetailController * beautifulVillageDetailController =[VPBeautifulVillageDetailController instantiation];
    beautifulVillageDetailController.villageID =villageModel.vid;
    [self.navigationController pushViewController:beautifulVillageDetailController animated:YES];
}

#pragma mark -VPVillageDropViewDelegate
/**
 tag刷新
 
 @param tagName tag名
 */
- (void)villageTagName:(NSString *)tagName{

    [self.viewModel villageTagName:tagName];

    [self.tableView xx_beginRefreshing];


}

/**
 排序
 @param sortType 排序 0 热门 1 按距离 2 默认
 */
-(void)sortType:(NSInteger)sortType{

//    UI排序  0 默认 1 热门 2 按距离
//    接口排序 0 热门 1 按距离 2 默认
    NSInteger sortTypeWay=0;
    switch (sortType) {
        case 0:{
            sortTypeWay=2;
        }break;
        case 1:{
            sortType = 0;
        }break;
        case 2:{
            sortType = 1;
        }break;
        default:
            break;
    }
    [self.viewModel sortType:sortType];
    [self.tableView xx_beginRefreshing];

}



#pragma mark -setter or getter
-(UIBarButtonItem*)searchButtonItem{
    
    if (!_searchButtonItem) {
        _searchButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    }
    return _searchButtonItem;
}

#pragma mark -Action respond
-(void)searchAction{
    VPSearchController *searchVC = [VPSearchController instantiation];
    searchVC.searchType = SearchTypeVillage;
    searchVC.cityID = self.cityModel.vid;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)selectCityAction{
    VPCityListController *cityVC = [VPCityListController instantiation];
    cityVC.locationType = LocationCoordinateTypeVillage;
    [self.navigationController pushViewController:cityVC animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
