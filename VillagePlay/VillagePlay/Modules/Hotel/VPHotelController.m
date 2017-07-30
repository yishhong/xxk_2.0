 //
//  VPHotelController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelController.h"
#import "VPHotelDropView.h"
#import "UIColor+HUE.h"
#import "VPHotelTableViewCell.h"
#import "VPHotelDetailViewController.h"
#import "VPHotelViewModel.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPHotelListModel.h"
#import "VPCalendarController.h"
#import "QMCalendarFunction.h"
#import "VPLocationAndSearchView.h"
#import "VPLocationManager.h"
#import "VPSearchController.h"
#import "VPCityListController.h"
#import "UIViewController+Empty.h"

@interface VPHotelController()<UITableViewDelegate,UITableViewDataSource,VPHotelDropViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *todayDateLabel;

@property (strong, nonatomic) IBOutlet UILabel *checkOutDateLabel;
@property (strong, nonatomic) IBOutlet UIView *checkOutView;

@property (strong, nonatomic) VPHotelViewModel *viewModel;

@property (strong, nonatomic) IBOutlet VPHotelDropView *menuView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString * startPrice;

@property (strong, nonatomic) NSString * endPrice;

//0默认排序，1价格由低到高，2距离排序
@property (strong, nonatomic) NSString *orderByType;

@property (strong, nonatomic)NSMutableDictionary * dateInfo;

@property (strong, nonatomic) QMCalendarFunction *calendarFunction;

@property (strong, nonatomic) VPLocationAndSearchView *locationAndSearchView;

@property (strong, nonatomic) UIBarButtonItem *searchButtonItem;

@property (strong, nonatomic) VPOpenCityInfoModel *cityModel;

@end

@implementation VPHotelController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Hotel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"民宿";
    self.calendarFunction =[[QMCalendarFunction alloc]init];
    self.viewModel =[[VPHotelViewModel alloc]init];
    [self.menuView configLeftData:nil rightData:nil];
    self.menuView.delegate =self;
//    self.menuView.layer.borderWidth = 2;
    
    self.viewModel.locationType = self.locationType;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCityHotel) name:@"SelectCityNotification" object:nil];
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    [[VPLocationManager sharedManager] loadRealCityListWithType:self.locationType success:^(NSArray *cityArray) {
        
        self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
        if(self.locationType == LocationCoordinateTypeHotel){
            self.locationAndSearchView = [[VPLocationAndSearchView alloc] initWithFrame:CGRectMake(0, 0, 235, 30)];
            self.navigationItem.titleView = self.locationAndSearchView;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)]];
            [self.locationAndSearchView.locationButton setTitle:self.cityModel.cityName forState:UIControlStateNormal];
            [self.locationAndSearchView.searchButton setTitle:@"输入民宿名称" forState:UIControlStateNormal];
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
        self.dateInfo = [[self.viewModel dateTimeInfo] mutableCopy];
        self.todayDateLabel.text =self.dateInfo[@"todayTime"];
        self.checkOutDateLabel.text =self.dateInfo[@"tomorrowTime"];
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"icon_back_bule"];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"icon_back_bule"];
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        self.checkOutView.userInteractionEnabled=YES;
        [self.checkOutView addGestureRecognizer:tap];
        
        self.view.backgroundColor =[UIColor controllerBackgroundColor];
        self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
        self.tableView.tableFooterView =[UIView new];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelTableViewCell class])];
        
        [self.tableView xx_addHeaderRefreshWithBlock:^{
            [self loadNewDateFirstLoading:YES];
        }];
        [self.tableView xx_addFooterRefreshWithBlock:^{
            [self loadNewDateFirstLoading:NO];
        }];
        [MBProgressHUD showLoading];
        [self loadNewDateFirstLoading:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
        [self isShowViewType:error.code message:error.errorMessage];
    }];
}

- (void)viewWillAppear:(BOOL)animated{

    self.todayDateLabel.text =self.dateInfo[@"todayTime"];
    self.checkOutDateLabel.text =self.dateInfo[@"tomorrowTime"];
}

- (void)refreshCityHotel{
    self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    [self.locationAndSearchView.locationButton setTitle:self.cityModel.cityName forState:UIControlStateNormal];
    [self.tableView xx_beginRefreshing];
}
-(void)loadNewDateFirstLoading:(BOOL)isFirstLoading{

    [self.viewModel hotelListIsFirstLoading:isFirstLoading success:^(BOOL isMore) {
        [self.tableView xx_isHasMoreData:isMore];
        [self isShowViewType:1 message:@"暂无数据"];
        [self.tableView reloadEmptyDataSet];
        [self.tableView reloadData];
        [MBProgressHUD hide];

    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView reloadEmptyDataSet];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:error.errorMessage];
        
    }];
}

- (void)tapGesture:(UITapGestureRecognizer *)tap{
    
    VPCalendarController *vc = [VPCalendarController instantiation];
    vc.beginDate = self.dateInfo[@"todayDate"];
    vc.endDate = self.dateInfo[@"tomorrowDate"];
    vc.selectDate = ^(NSString *beginDate, NSString *endDate){
        [self.dateInfo setValue:beginDate forKey:@"todayDate"];
        [self.dateInfo setValue:endDate forKey:@"tomorrowDate"];
        //转成MM-dd
        NSString * todayTime =[self.calendarFunction currentDatefromString:beginDate];
        NSString *tomorrowTime =[self.calendarFunction currentDatefromString:endDate];
        self.todayDateLabel.text =todayTime;
        self.checkOutDateLabel.text =tomorrowTime;
        [self.dateInfo setValue:todayTime forKey:@"todayTime"];
        [self.dateInfo setValue:tomorrowTime forKey:@"tomorrowTime"];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * hotelTableViewCell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [hotelTableViewCell xx_configCellWithEntity:cellModel];
    return hotelTableViewCell;
}
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPHotelListModel * hotelListModel =cellModel.dataSource;
    VPHotelDetailViewController *hotelDetailViewController =[VPHotelDetailViewController instantiation];
    hotelDetailViewController.dateInfo =self.dateInfo;
    hotelDetailViewController.hid =hotelListModel.hid;
    [self.navigationController pushViewController:hotelDetailViewController animated:YES];
}

#pragma mark -VPHotelDropViewDelegate
/**
 tag菜单
 
 @param startPrice 开始价格
 @param endPrice 结束价格
 */
- (void)hotelStartPrice:(double)hotelStartPrice hotelEndPrice:(double)hotelEndPrice{

    [self.viewModel hotelStartPrice:hotelStartPrice hotelEndPrice:hotelEndPrice];
    [self.tableView xx_beginRefreshing];
}

/**
 排序
 @param orderByType 0默认排序，1价格由低到高，2距离排序
 */
- (void)orderByType:(NSInteger)orderByType{
    [self.viewModel orderByType:orderByType];
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
    searchVC.searchType = SearchTypeHotel;
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
