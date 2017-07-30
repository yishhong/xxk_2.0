//
//  VPDestinationController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDestinationController.h"
#import "VPDestinationViewModel.h"

#import "UIImageView+VPWebImage.h"
#import "UIScrollView+Refresh.h"
#import "UINavigationBar+Awesome.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "UINavigationBar+Custom.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"

#import "VPTicketController.h"

#import "VPCityListController.h"

#import "VPVillageModel.h"
#import "VPBeautifulVillageController.h"
#import "VPBeautifulVillageDetailController.h"

#import "VPActiveModel.h"
#import "VPTravelMainController.h"
#import "VPTravelDetailController.h"

#import "VPPlayListModel.h"
#import "VPPlayController.h"
#import "VPPlayDetailController.h"

#import "VPHotelListModel.h"
#import "VPHotelController.h"
#import "VPHotelDetailViewController.h"

#import "VPAloneSearchView.h"
#import "VPSearchController.h"
#import "VPDestinationCityView.h"

#import "VPBannerInfoModel.h"
#import "VPGeneralWebController.h"

#import "UIViewController+Empty.h"

#define NAVBAR_CHANGE_POINT 50

@interface VPDestinationController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) VPDestinationViewModel *viewModel;

@property (nonatomic, strong) VPAloneSearchView *aloneSearchView;

@property (nonatomic, strong) VPDestinationCityView *cityView;

@property (nonatomic, strong) VPOpenCityInfoModel *cityModel;

@end

@implementation VPDestinationController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Destination" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];

    self.viewModel = [[VPDestinationViewModel alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCityDestination) name:@"SelectCityNotification" object:nil];

    [self.tableView registerNib:[UINib nibWithNibName:@"VPTravelTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VPTravelTableViewCell"];

    self.viewModel.locationType = LocationCoordinateTypeDestination;
    
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"目的地";
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    

    [[VPLocationManager sharedManager] loadRealCityListWithType:self.viewModel.locationType
                                                        success:^(NSArray *cityArray) {
                                                            //开始布局
                                                            self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.viewModel.locationType];
                                                            
                                                            self.aloneSearchView = [[VPAloneSearchView alloc] initWithFrame:CGRectMake(0, 0, 285, 29)];
                                                            self.navigationItem.titleView =  self.aloneSearchView;
                                                            self.cityView = [[VPDestinationCityView alloc] init];
                                                            self.cityView.frame = CGRectMake(10, 80, 100, 50);
                                                            [self.tableView addSubview:self.cityView];
                                                            [self.cityView.cityButton setTitle:self.cityModel.cityName forState:UIControlStateNormal];
                                                            
                                                            [self.cityView layerUIBlock:^{
                                                                [self selectCity];
                                                            }];
                                                            
                                                            __weak typeof(VPDestinationController)* weakSelf = self;
                                                            [self.aloneSearchView layerUIBlock:^{
                                                                __strong typeof(VPDestinationController *)strongSelf = weakSelf;
                                                                VPSearchController *searchVC = [VPSearchController instantiation];
                                                                
                                                                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
                                                                strongSelf.navigationItem.backBarButtonItem = backItem;
                                                                searchVC.cityID = self.cityModel.vid;
                                                                searchVC.searchType = SearchTypeAll;
                                                                [strongSelf.navigationController pushViewController:searchVC animated:YES];
                                                            }];

                                                            [self isShowViewType:0 message:@""];
                                                            [self.tableView reloadEmptyDataSet];
                                                            [self.tableView xx_addHeaderRefreshWithBlock:^{
                                                                [self loadBanner];
                                                            }];
                                                            [MBProgressHUD showLoading];
                                                            [self loadBanner];
                                                            
                                                        } failure:^(NSError *error) {
                                                            [self isShowViewType:error.code message:error.errorMessage];
                                                            [self.tableView reloadEmptyDataSet];
                                                            [MBProgressHUD showTip:error.errorMessage];
                                                        }];
}

- (void)refreshCityDestination{
    [self.tableView reloadData];
    
    self.cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.viewModel.locationType];

    [self.cityView.cityButton setTitle:self.cityModel.cityName forState:UIControlStateNormal];

    [MBProgressHUD showLoading];
    [self loadBanner];
}

- (void)loadBanner{
    [self.viewModel loadDestinationBannerSuccess:^() {
        [self loadPlay];
        [self loadTrave];
        [self loadHotel];
        [self loadVillage];
        [self.tableView reloadData];
        [self.tableView xx_endRefreshing];
        [self isShowViewType:1 message:@""];
        [self.tableView reloadEmptyDataSet];

        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView reloadEmptyDataSet];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:error.errorMessage];
    }];
}
- (void)loadPlay{
    [self.viewModel loadDestinationPlaySuccess:^() {
//        NSIndexSet *indexSet = []
//        [self.tableView reloadSections:<#(nonnull NSIndexSet *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadTrave{
    [self.viewModel loadDestinationTraveSuccess:^() {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadHotel{
    [self.viewModel loadDestinationHotelSuccess:^() {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)loadVillage{
    [self.viewModel loadDestinationVillageSuccess:^() {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //修改导航栏颜色
    UIColor * color = [UIColor navigationBarTintColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        //往上滑动时的修改
        CGFloat scale = 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64);
        CGFloat alpha = MIN(1, scale<0?0:(scale>0.94)?0.94:scale);
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha] lineView:[[UIColor navigationBottonLineView] colorWithAlphaComponent:alpha]];
        //设置按钮的颜色
        [self.navigationController.navigationBar setTintColor:[[UIColor navigationTintColor] colorWithAlphaComponent:alpha]];
        //设置标题的颜色
        [self.navigationController.navigationBar xx_titleStyleWithColor:[[UIColor navigationTitleColor] colorWithAlphaComponent:alpha]];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        if(alpha==0.94){
            [self.aloneSearchView.searchButton setImage:[UIImage imageNamed:@"vp_tab_search_gray"] forState:UIControlStateNormal];
            [self.aloneSearchView.searchButton setTitleColor:[UIColor colorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0] forState:UIControlStateNormal];
        }
    } else {
        //进入页面时的状态
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
        [self.aloneSearchView.searchButton setImage:[UIImage imageNamed:@"vp_tab_search_white"] forState:UIControlStateNormal];
        [self.aloneSearchView.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]
                                                              lineView:[[UIColor navigationBottonLineView] colorWithAlphaComponent:0]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self.tableView reloadData];

    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar lt_reset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor navigationTintColor]];
    //还原系统的标题颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor navigationTitleColor] ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowsInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    return cellModel.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:[self.viewModel cellModelForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([cellModel.identifier isEqualToString:@"VPListMoreCell"]){
        if([self respondsToSelector:cellModel.action]){
            [self performSelector:cellModel.action];
        }
    }else if([cellModel.identifier isEqualToString:@"VPTravelTableViewCell"]){
        VPActiveModel * activeModel = cellModel.dataSource;
        VPTravelDetailController *travelDetailController =[VPTravelDetailController instantiation];
        travelDetailController.travelID = activeModel.vid;
        [self.navigationController pushViewController:travelDetailController animated:YES];
    }else if([cellModel.identifier isEqualToString:@"VPDestinationPlayCell"]){
        VPPlayListModel *playListModel = cellModel.dataSource;
        VPPlayDetailController *playDetailController = [VPPlayDetailController instantiation];
        playDetailController.playID = playListModel.fpId;
        [self.navigationController pushViewController:playDetailController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([cellModel.identifier isEqualToString:@"VPRecommendMenuCell"]){
        NSDictionary *menuDict = [cellModel.dataSource objectAtIndex:view.tag];
        if([self respondsToSelector:NSSelectorFromString(menuDict[@"action"])]){
            [self performSelector:NSSelectorFromString(menuDict[@"action"])];
        }
    }else if([cellModel.identifier isEqualToString:@"VPDestinationVillageCell"]){
        
        NSArray *villageArray = cellModel.dataSource;
        VPVillageModel *villageModel = villageArray[view.tag];
        VPBeautifulVillageDetailController *villageDetailController = [VPBeautifulVillageDetailController instantiation];
        villageDetailController.villageID = villageModel.vid;
        [self.navigationController pushViewController:villageDetailController animated:YES];
        
    }else{

    }
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view data:(id)data{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([cellModel.identifier isEqualToString:@"VPRecommendBannerCell"]){
        if(data){
            NSInteger index = [data integerValue];
            NSArray *bannerArray = cellModel.dataSource;
            if(index<[bannerArray count]){
                [self didTappedBannerModel:bannerArray[index]];
            }
        }
    }else if([cellModel.identifier isEqualToString:@"VPDestinationHotelCell"]){
        NSIndexPath *selectIndexPath = data;
        VPHotelListModel *hotelListModel = cellModel.dataSource[selectIndexPath.row];
        VPHotelDetailViewController *hotelDetailViewController =[VPHotelDetailViewController instantiation];
        hotelDetailViewController.dateInfo = [[self.viewModel dateTimeInfo] mutableCopy];
        hotelDetailViewController.hid = hotelListModel.hid;
        [self.navigationController pushViewController:hotelDetailViewController animated:YES];
    }
}

- (void)selectCity{
    //指定类型的城市列表
    VPCityListController *cityVC = [VPCityListController instantiation];
    cityVC.locationType = LocationCoordinateTypeDestination;
    [self.navigationController pushViewController:cityVC animated:YES];
}

- (void)menuVillage{
    VPBeautifulVillageController *vc = [VPBeautifulVillageController instantiation];
    vc.locationType = self.viewModel.locationType;
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)menuHotel{
    VPHotelController *hotelVC = [VPHotelController instantiation];
    hotelVC.locationType = self.viewModel.locationType;
    [self.navigationController pushViewController:hotelVC animated:YES];
}

- (void)menuTicket{
    VPTicketController * ticketVC = [VPTicketController instantiation];
    ticketVC.locationType = self.viewModel.locationType;
    [self.navigationController pushViewController:ticketVC animated:YES];
}

- (void)morePlay{
    [self.navigationController pushViewController:[VPPlayController instantiation] animated:YES];
}
- (void)moreActivity{
    VPTravelMainController * travelVC =  [VPTravelMainController instantiation];
    travelVC.locationType = self.viewModel.locationType;
    [self.navigationController pushViewController:travelVC animated:YES];
}
- (void)moreVillage{
    VPBeautifulVillageController * villageVC = [VPBeautifulVillageController instantiation];
    villageVC.locationType = self.viewModel.locationType;
    villageVC.type = 2;
    [self.navigationController pushViewController:villageVC animated:YES];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didTappedBannerModel:(VPBannerInfoModel *)item{
    switch (item.channelId) {
        case VPChannelTypeTravel:{
            VPTravelDetailController *travelDetailController =[VPTravelDetailController instantiation];
            travelDetailController.travelID = item.vid;
            [self.navigationController pushViewController:travelDetailController animated:YES];
        }break;
        case VPChannelTypeHotel:{
            VPHotelDetailViewController *hotelDetailViewController =[VPHotelDetailViewController instantiation];
            hotelDetailViewController.dateInfo = [[self.viewModel dateTimeInfo] mutableCopy];
            hotelDetailViewController.hid = [item.vid integerValue];
            [self.navigationController pushViewController:hotelDetailViewController animated:YES];
        }break;
        case VPChannelTypeVillage:{//村庄
            VPBeautifulVillageDetailController *villageDetailController = [VPBeautifulVillageDetailController instantiation];
            villageDetailController.villageID = item.vid;
            [self.navigationController pushViewController:villageDetailController animated:YES];
        }break;
        case VPChannelTypePlay:{
            VPPlayDetailController *playDetailController = [VPPlayDetailController instantiation];
            playDetailController.playID = [item.vid integerValue];
            [self.navigationController pushViewController:playDetailController animated:YES];
        }break;
        case VPChannelTypeTicket:{
            VPTravelDetailController *travelDetailVC = [VPTravelDetailController instantiation];
            travelDetailVC.travelID = item.vid;
            [self.navigationController pushViewController:travelDetailVC animated:YES];
        }break;
        case VPChannelTypeMagazine:
        case VPChannelTypeLive:
        case VPChannelTypeTopic:
        case VPChannelTypeNews:{
            VPGeneralWebController *webVC = [VPGeneralWebController instantiation];
            webVC.url = item.detailUrl;
            webVC.title = item.title;
            [self.navigationController pushViewController:webVC animated:YES];
        }break;
        default:
            break;
    }
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 0;
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"网络出现异常 重新加载";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    [attributedString addAttributes:attributes range:NSMakeRange(0, text.length-4)];
    NSDictionary *subAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                    NSForegroundColorAttributeName: [UIColor navigationTintColor],
                                    NSParagraphStyleAttributeName: paragraph};
    [attributedString addAttributes:subAttributes range:NSMakeRange(text.length-4, 4)];
    
    return attributedString;
}

- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [MBProgressHUD showLoading];
    [self loadBanner];
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
//    return NO;
    return [self.showViewType integerValue]==0?NO:YES;
}


@end
