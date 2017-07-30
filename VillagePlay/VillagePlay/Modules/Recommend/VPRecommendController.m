//
//  VPRecommendController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRecommendController.h"
#import "VPRecommendViewModel.h"
#import "UIColor+HUE.h"
#import "UITableViewCell+DataSource.h"
#import "UINavigationBar+Custom.h"
#import "UINavigationBar+Awesome.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"


#import "VPHotelController.h"
#import "VPSearchController.h"

#import "VPVillageModel.h"

#import "VPBeautifulVillageController.h"
#import "VPBeautifulVillageDetailController.h"

#import "VPLiveInfoModel.h"
#import "VPLiveViewController.h"
#import "VPLiveDetailController.h"

#import "VPMagazineModel.h"
#import "VPVickersController.h"
#import "VPVickersDetailController.h"

#import "VPTopicListModel.h"
#import "VPTopicController.h"
#import "VPTopicDetailController.h"

#import "VPTicketController.h"

#import "VPActiveModel.h"
#import "VPTravelMainController.h"
#import "VPTravelDetailController.h"

#import "VPGeneralWebController.h"

#import "VPPlayDetailController.h"

#import "VPAloneSearchView.h"

#import "VPHotelDetailViewController.h"

#import "UIViewController+Empty.h"
#import "VPTravelController.h"

#import "QMUpdateAndPraise.h"

#define NAVBAR_CHANGE_POINT (0)

@interface VPRecommendController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) VPRecommendViewModel *viewModel;

//@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) VPAloneSearchView *aloneSearchView;

@end

@implementation VPRecommendController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    self.viewModel = [[VPRecommendViewModel alloc] init];
    self.title = @"推荐";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];

    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];


    self.aloneSearchView = [[VPAloneSearchView alloc] initWithFrame:CGRectMake(0, 0, 285, 29)];
    self.navigationItem.titleView =  self.aloneSearchView;
    __weak typeof(VPRecommendController)* weakSelf = self;
    [self.aloneSearchView layerUIBlock:^{
        __strong typeof(VPRecommendController *)strongSelf = weakSelf;
        VPSearchController *searchVC = [VPSearchController instantiation];
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//        strongSelf.navigationItem.backBarButtonItem = backItem;
        searchVC.searchType = SearchTypeAll;
        
        [strongSelf.navigationController pushViewController:searchVC animated:YES];
    }];
    
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    //专题的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"VPTravelTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VPTravelTableViewCell"];
    [self isShowViewType:0 message:@""];

    

    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];

    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadData];
    }];
    [MBProgressHUD showLoading];
    [self loadData];
    [self applicationDidBecomeActiveNotification];
}

- (void)loadData{
    [self.viewModel loadDataSuccess:^{
        [self isShowViewType:1 message:@"暂无数据"];
        [self.tableView xx_endRefreshing];
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
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0] lineView:[[UIColor navigationBottonLineView] colorWithAlphaComponent:0]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
}
- (void)applicationDidBecomeActiveNotification{
    //调用版本更新
    [self.viewModel loadVersionSuccess:^(BOOL isUpdate) {
        if(isUpdate){
            [[QMUpdateAndPraise sharedManager] showUpdateWithMessage:self.viewModel.versionModel.desc isForced:self.viewModel.versionModel.isForced];
        }
    } failure:^(NSError *error) {
    }];
    //调用好评
    [[QMUpdateAndPraise sharedManager] showPraise];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor navigationTitleColor]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRows];
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
    //点击了标题的
    if([cellModel.identifier isEqualToString:@"VPRecommendTitleCell"]){
        if([self respondsToSelector:cellModel.action]){
            [self performSelector:cellModel.action];
        }
    }else if ([cellModel.identifier isEqualToString:@"VPVickersTableViewCell"]){
        //微刊
        VPMagazineModel *magazineModel = cellModel.dataSource;
        VPGeneralWebController *webVC = [VPGeneralWebController instantiation];
        webVC.url = magazineModel.magazineUrl;
        webVC.title = @"微刊详情";
        webVC.channelType =VPChannelTypeMagazine;
        webVC.imageString = magazineModel.photoUrl;
        webVC.shareTitle =magazineModel.title;
        [self.navigationController pushViewController:webVC animated:YES];
//        
//        VPVickersDetailController * vickersDetailController =[VPVickersDetailController instantiation];
//        vickersDetailController.magazineID = [@(magazineModel.magazineID) stringValue];
//        [self.navigationController pushViewController:vickersDetailController animated:YES];

    }else if ([cellModel.identifier isEqualToString:@"TopicTableViewCell"]){
        //专题
        VPTopicListModel * topicListModel = cellModel.dataSource;
        VPGeneralWebController *webVC = [VPGeneralWebController instantiation];
        webVC.url = topicListModel.projectUrl;
        webVC.shareTitle =topicListModel.projectName;
        webVC.imageString = [NSString stringWithFormat:@"%@?imageView2/1/w/50/h/50",topicListModel.photoUrl];
        webVC.channelType =VPChannelTypeTopic;
        webVC.title =@"专题详情";
//        VPTopicDetailController *topicDetailController =[VPTopicDetailController instantiation];
//        topicDetailController.topicID = topicListModel.projectID;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if ([cellModel.identifier isEqualToString:@"VPTravelTableViewCell"]){
        //旅游
        VPActiveModel * activeModel = cellModel.dataSource;
        VPTravelDetailController *travelDetailController =[VPTravelDetailController instantiation];
        travelDetailController.travelID = activeModel.vid;
        [self.navigationController pushViewController:travelDetailController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([cellModel.identifier isEqualToString:@"VPRecommendMenuCell"]){
        NSDictionary *menuDict = [cellModel.dataSource objectAtIndex:view.tag];
        if([self respondsToSelector:NSSelectorFromString(menuDict[@"action"])]){
            [self performSelector:NSSelectorFromString(menuDict[@"action"])];
        }
    }else{
        if ([cellModel.identifier isEqualToString:@"VPRecommendVillageCell"]){
            //最美乡村
            NSDictionary *modelDict = cellModel.dataSource;
            VPVillageModel *villageModel = nil;
            if(view.tag == 0){
                villageModel = modelDict[@"left"];
            }else{
                villageModel = modelDict[@"right"];
            }
            VPBeautifulVillageDetailController *villageDetailController = [VPBeautifulVillageDetailController instantiation];
            villageDetailController.villageID = villageModel.vid;
            [self.navigationController pushViewController:villageDetailController animated:YES];
        }else if ([cellModel.identifier isEqualToString:@"VPRecommendLiveCell"]){
            //直播
            NSDictionary *modelDict = cellModel.dataSource;
            VPLiveInfoModel *liveModel = nil;
            if(view.tag == 0){
                liveModel = modelDict[@"left"];
            }else{
                liveModel = modelDict[@"right"];
            }
            //直播
            VPLiveDetailController *liveDetailController = [VPLiveDetailController instantiation];
            liveDetailController.liveInfoModel =liveModel;
            [self.navigationController pushViewController:liveDetailController animated:YES];
        }
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
    }
}

- (void)menuTravel{
    //旅游列表
    VPTravelMainController *vc = [VPTravelMainController instantiation];
    vc.locationType = LocationCoordinateTypeTravel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)menuHotel{
    //民宿列表
    VPHotelController *vc = [VPHotelController instantiation];
    vc.locationType = LocationCoordinateTypeHotel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)menuTicket{
    //门票
    VPTicketController *vc = [VPTicketController instantiation];
    vc.locationType = LocationCoordinateTypeTicket;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)menuTopic{
    //专题
    [self.navigationController pushViewController:[VPTopicController instantiation] animated:YES];
}

- (void)menuWeikan{
    //微刊
    [self.navigationController pushViewController:[VPVickersController instantiation] animated:YES];
}

- (void)menuLive{
    //直播
    [self.navigationController pushViewController:[VPLiveViewController instantiation] animated:YES];
}
- (void)travelList{
    VPTravelController *vc = [VPTravelController instantiation];
    vc.locationType = LocationCoordinateTypeNow;
    vc.title =@"旅游列表";
    vc.tag = @"";
    vc.sortType = @"0";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)menuVillage{
    //乡村
    VPBeautifulVillageController *vc = [VPBeautifulVillageController instantiation];
    vc.locationType = LocationCoordinateTypeVillage;
    [self.navigationController pushViewController:vc animated:YES];
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
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
////                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
//                                 NSParagraphStyleAttributeName: paragraph};
//    
//    return [[NSAttributedString alloc] initWithString:@"请下拉重新连接" attributes:attributes];
//
//    
////    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0f]};
////    return [[NSAttributedString alloc] initWithString:@"下拉重新连接" attributes:attributes];
//}
//
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
    [self loadData];
}
////- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
////    return [UIImage imageNamed:@"NotNetWork_icon"];
////}
//
//- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
//    //刷新界面
//}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return [self.showViewType integerValue]==0?NO:YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
