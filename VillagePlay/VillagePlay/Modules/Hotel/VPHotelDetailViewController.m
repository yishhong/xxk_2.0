//
//  VPHotelDetailViewController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelDetailViewController.h"
#import "VPHotelHeadView.h"
#import "VPHotelNameTableViewCell.h"
#import "VPAddressTableViewCell.h"
#import "VPHotelReservationsTableViewCell.h"
#import "VPMoreCommentTableViewCell.h"
#import "VPHotelSubmitOrderController.h"
#import "VPHotelRoomListUpSlideView.h"
#import "UINavigationBar+Awesome.h"
#import "VPShareManage.h"
#import "VPBlankLinesTableViewCell.h"
#import "XXCellModel.h"
#import "HotelDetailModel.h"
#import "UIColor+HUE.h"
#import "VPAddressDateTableViewCell.h"
#import "VPFacilitiesTableViewCell.h"
#import "VPAddressImageTableViewCell.h"
#import "UINavigationBar+Custom.h"
#import "UINavigationBar+Awesome.h"
#import "VPCommentTableViewCell.h"
#import "VPCommentContentTableViewCell.h"
#import "VPCommentContentImageViewTableViewCell.h"
#import "VillageLookMoreCommentTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXNibConvention.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPHotelRoomListRoomModel.h"
#import "XXCellModel.h"
#import "VPMapController.h"
#import "VPHotelDetailModel.h"
#import "VPHotelInformationView.h"
#import "VPCalendarController.h"
#import "UIView+Frame.h"
#import "VPCollectionRecordManager.h"
#import "VPLoginController.h"
#import "VPHotelDetailModel.h"
#import "VPWantCommentController.h"
#import "CommentDetaileEnum.h"
#import "VPCommentListController.h"
#import "QMCalendarFunction.h"
#import "VPUserManager.h"
#import "VPLoginController.h"
#import "VPHotelCommentNoDataTableViewCell.h"
#import "VPCommentLineTableViewCell.h"
#import "IDMPhotoBrowser.h"

#define NAVBAR_CHANGE_POINT -(50+64*2)

@interface VPHotelDetailViewController ()<UITableViewDataSource,UITableViewDelegate,VPHotelReservationsTableViewCellDelegate,VPHotelRoomListUpSlideViewDelegate,VPHotelHeadViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)VPHotelRoomListUpSlideView *hotelRoomUpSlideView;

@property (strong, nonatomic) VPHotelInformationView *hotelInformationView;

@property (strong, nonatomic)HotelDetailModel *viewModel;

@property (strong, nonatomic)VPHotelHeadView * hotelHeadView;

@property (strong, nonatomic)UIView *rightBarView;

@property (strong, nonatomic)UIButton * collectionButton;

@property (strong, nonatomic)UIButton * shareButton;

@property (strong, nonatomic)UIButton * commentButton;

@property (assign, nonatomic)BOOL isCollection;

@property (strong, nonatomic)VPCollectionRecordManager *collectionRecordManager;

@property (strong, nonatomic)VPHotelDetailModel *hotelDetailModel;

@property (strong, nonatomic) QMCalendarFunction *calendarFunction;

@end

@implementation VPHotelDetailViewController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Hotel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

#pragma mark -cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"民宿详情";
    self.calendarFunction =[[QMCalendarFunction alloc]init];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    self.viewModel =[[HotelDetailModel alloc]init];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    [self.tableView addSubview:self.hotelHeadView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelNameTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelNameTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPAddressTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPAddressTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelReservationsTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelReservationsTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPMoreCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPMoreCommentTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentContentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentContentTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentContentImageViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentContentImageViewTableViewCell class])];
    
      [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageLookMoreCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageLookMoreCommentTableViewCell class])];
    
     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPAddressDateTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPAddressDateTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPAddressImageTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPAddressImageTableViewCell class])];
    
     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPFacilitiesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPFacilitiesTableViewCell class])];
    
    //空行
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    //空行
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelCommentNoDataTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelCommentNoDataTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentLineTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentLineTableViewCell class])];
    
    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self loadNewDate];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshComment) name:@"commentRefreshNotificationName" object:nil];
}

-(void)refreshComment{

    [self loadCommentNewDate];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)loadNewDate{

    [MBProgressHUD showLoading];
    [self.viewModel hotelDetailHid:[NSString stringWithFormat:@"%ld",(long)self.hid] infoDate:self.dateInfo success:^{
        self.hotelDetailModel =[self.viewModel hotelModel];
        [self.hotelHeadView focusImageItemsArray:self.hotelDetailModel.imgList isRight:NO];
        [self loadRoomListNewDate];
        [self.tableView reloadData];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

- (void)loadRoomListNewDate{

    [self.viewModel hotelRoomListHotelID:[NSString stringWithFormat:@"%ld",(long)self.hid] beginTime:self.dateInfo[@"todayDate"] endTime:self.dateInfo[@"tomorrowDate"] type:@"1" success:^{
        [self loadCommentNewDate];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

- (void)loadCommentNewDate{

    [self.viewModel hotelCommentListVillageID:[NSString stringWithFormat:@"%zd",self.hid] commendType:VPChannelTypeHotel success:^{
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    UIColor * color = [UIColor navigationBarTintColor];
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha] lineView:[[UIColor navigationBottonLineView] colorWithAlphaComponent:alpha]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        //设置按钮的颜色
        [self.navigationController.navigationBar setTintColor:[[UIColor navigationTintColor] colorWithAlphaComponent:alpha]];
        //设置标题的颜色
        [self.navigationController.navigationBar xx_titleStyleWithColor:[[UIColor navigationTitleColor] colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0] lineView:[[UIColor navigationBottonLineView] colorWithAlphaComponent:0]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.isCollection =[self.collectionRecordManager isCollectionWithType:VPChannelTypeHotel key:[NSString stringWithFormat:@"%ld", (long)self.hid]];
    self.collectionButton.selected =self.isCollection;
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.tableView reloadData];
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

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;

}
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    if ([cellModel.identifier isEqualToString:@"VPAddressTableViewCell"]||[cellModel.identifier isEqualToString:@"VPAddressImageTableViewCell"]) {
        VPMapController * mapController =[VPMapController instantiation];
        mapController.mapTitle =self.hotelDetailModel.title;
        mapController.location =[NSString stringWithFormat:@"%f,%f",self.hotelDetailModel.lat,self.hotelDetailModel.lon];
        [self.navigationController pushViewController:mapController animated:YES];
    }
    if ([cellModel.identifier isEqualToString:@"VPHotelReservationsTableViewCell"]) {
        VPHotelRoomListRoomModel *hotelRoomListRoom =cellModel.dataSource;
        [self.hotelRoomUpSlideView showAnimation:YES];
        self.hotelRoomUpSlideView.hotelRoomListRoomModel =hotelRoomListRoom;
    }
    if ([cellModel.identifier isEqualToString:@"VPAddressDateTableViewCell"]) {
        
        VPCalendarController *vc = [VPCalendarController instantiation];
        vc.beginDate = self.dateInfo[@"todayDate"];
        vc.endDate = self.dateInfo[@"tomorrowDate"];
        __weak typeof(VPHotelDetailViewController)* weakSelf = self;
        vc.selectDate = ^(NSString *beginDate, NSString *endDate){
            __strong typeof(VPHotelDetailViewController)* strongSelf = weakSelf;
            [strongSelf.dateInfo setValue:beginDate forKey:@"todayDate"];
            [strongSelf.dateInfo setValue:endDate forKey:@"tomorrowDate"];
            //转成MM-dd
            NSString * todayTime =[strongSelf.calendarFunction currentDatefromString:beginDate];
            NSString *tomorrowTime =[strongSelf.calendarFunction currentDatefromString:endDate];
            [strongSelf.dateInfo setValue:todayTime forKey:@"todayTime"];
            [strongSelf.dateInfo setValue:tomorrowTime forKey:@"tomorrowTime"];
            [strongSelf loadRoomListNewDate];
            [strongSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([cellModel.identifier isEqualToString:@"VillageLookMoreCommentTableViewCell"]) {
        if([VPUserManager sharedInstance].xx_userinfoID.length<1){
            UIViewController * loginController =[VPLoginController instantiation];
            [self presentViewController:loginController animated:YES completion:nil];
            return;
        }
        VPCommentListController * commentListController =[VPCommentListController instantiation];
        commentListController.villageID =[NSString stringWithFormat:@"%zd",self.hid];
        commentListController.channelType = VPChannelTypeHotel;
        commentListController.title =@"评论列表";
        [self.navigationController pushViewController:commentListController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    VPHotelRoomListRoomModel* hotelRoomListRoomModel =cellModel.dataSource;
    if (view.tag==10) {
        //立即预定
        if([VPUserManager sharedInstance].xx_userinfoID.length<1){
            UIViewController * loginController =[VPLoginController instantiation];
            [self presentViewController:loginController animated:YES completion:nil];
            return;
        }
        NSDictionary * submitInfo =@{@"checkTime":self.dateInfo[@"todayDate"],
                                     @"outTime":self.dateInfo[@"tomorrowDate"],
                                     @"hid":[NSString stringWithFormat:@"%ld",self.hid],
                                     @"orderNum":[NSString stringWithFormat:@"%ld",self.hotelDetailModel.orderNum],
                                     @"roomListRoomModel":hotelRoomListRoomModel,
                                     @"updteDate":self.hotelDetailModel.updteDate,
                                     @"roomID":[NSString stringWithFormat:@"%ld",hotelRoomListRoomModel.rid],
                                     @"roomNum":hotelRoomListRoomModel.roomnum};
        VPHotelSubmitOrderController *hotelSubmitOrderController =[VPHotelSubmitOrderController instantiation];
        hotelSubmitOrderController.submitInfo =submitInfo;
        [self.navigationController pushViewController:hotelSubmitOrderController animated:YES];
    }
    if (view.tag==20) {
        
        [self.hotelInformationView showAnimation:YES];
        self.hotelInformationView.hotelDetailModel =[self.viewModel hotelModel];
    }
    if (view.tag ==58) {
        if([VPUserManager sharedInstance].xx_userinfoID.length<1){
            UIViewController * loginController =[VPLoginController instantiation];
            [self presentViewController:loginController animated:YES completion:nil];
            return;
        }
        VPWantCommentController * wantCommentController =[VPWantCommentController instantiation];
         wantCommentController.channelType =VPChannelTypeHotel;
         wantCommentController.objeID =self.hid;
         [self.navigationController pushViewController:wantCommentController animated:YES];
    }
}

#pragma mark -VPHotelRoomListUpSlideViewDelegate
//立即支付
-(void)roomListRoomModel:(VPHotelRoomListRoomModel *) roomListRoomModel;
{
    [self.hotelRoomUpSlideView hideAnimation:YES];
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        UIViewController * loginController =[VPLoginController instantiation];
        [self presentViewController:loginController animated:YES completion:nil];
        return;
    }
    NSDictionary * submitInfo =@{@"checkTime":self.dateInfo[@"todayDate"],
                                 @"outTime":self.dateInfo[@"tomorrowDate"],
                                 @"hid":[NSString stringWithFormat:@"%ld",(long)self.hid],
                                 @"orderNum":[NSString stringWithFormat:@"%ld",(long)self.hotelDetailModel.orderNum],
                                 @"roomListRoomModel":roomListRoomModel,
                                 @"updteDate":self.hotelDetailModel.updteDate,
                                 @"roomID":[NSString stringWithFormat:@"%ld",(long)roomListRoomModel.rid],
                                 @"roomNum":roomListRoomModel.roomnum};
   VPHotelSubmitOrderController *hotelSubmitOrderController =[VPHotelSubmitOrderController instantiation];
    hotelSubmitOrderController.submitInfo =submitInfo;
            [self.navigationController pushViewController:hotelSubmitOrderController animated:YES];
}
- (void)VPHotelHeadViewSelectImage:(NSInteger)selectImageIndex roomListRoomModel:(VPHotelRoomListRoomModel *) roomListRoomModel{
    
    NSMutableArray *photos = [NSMutableArray array];
    
    for (VPImgListModel*imgListModel in roomListRoomModel.imgUrlArray) {
        NSURL * urlImage =[NSURL URLWithString:imgListModel.originalImg];
        IDMPhoto *photo = [IDMPhoto photoWithURL:urlImage];
        [photos addObject:photo];
    }
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton =NO;
    [browser setInitialPageIndex:selectImageIndex];
    [self presentViewController:browser animated:YES completion:nil];
}

#pragma mark -VPHotelHeadViewDelegate
- (void)VPHotelHeadViewSelectImage:(NSInteger)selectImage imageList:(NSArray *)imageList{
    
    NSMutableArray *photos = [NSMutableArray array];

    for (VPImgListModel*imgListModel in self.hotelDetailModel.imgList) {
        NSURL * urlImage =[NSURL URLWithString:imgListModel.originalImg];
        IDMPhoto *photo = [IDMPhoto photoWithURL:urlImage];
        [photos addObject:photo];
    }
        IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
        browser.displayActionButton =NO;
        [browser setInitialPageIndex:selectImage];
        [self presentViewController:browser animated:YES completion:nil];
}

#pragma mark -VPNavigationRightBarViewDelegate

/**
 *  收藏
 *
 */
-(void)collectionAction:(UIButton *)sender{
        
    __weak VPHotelDetailViewController *weakSelf =self;
    if (self.collectionButton.selected==NO) {
        [self.collectionRecordManager addCollectionRecordWithType:VPChannelTypeHotel key:[NSString stringWithFormat:@"%ld", (long)self.hid] model:self.hotelDetailModel block:^(NSError *error, BOOL isSucceed) {
            if (isSucceed==NO) {
                UIViewController * loginController =[VPLoginController instantiation];
                [weakSelf presentViewController:loginController animated:YES completion:nil];
            }else{
                weakSelf.collectionButton.selected=YES;
            }
        }];
        
    }else{
        [self.collectionRecordManager removeCollectionRecordWithType:VPChannelTypeHotel key:[NSString stringWithFormat:@"%ld", (long)self.hid] block:^(NSError *error, BOOL isSucceed) {
            if (isSucceed==NO) {
                UIViewController * loginController =[VPLoginController instantiation];
                [weakSelf presentViewController:loginController animated:YES completion:nil];
            }else{
                weakSelf.collectionButton.selected=NO;
            }
        }];
    }
}

/**
 评论
 */
-(void)commentAction{

    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        UIViewController * loginController =[VPLoginController instantiation];
        [self presentViewController:loginController animated:YES completion:nil];
        return;
    }
    VPWantCommentController * wantCommentController =[VPWantCommentController instantiation];
    wantCommentController.channelType=VPChannelTypeHotel;
    wantCommentController.objeID =self.hid;
    wantCommentController.title =@"评论";
    [self.navigationController pushViewController:wantCommentController animated:YES];
}

/**
 *  分享
 */
-(void)shareButtonAction{
    
    [VPShareManage getShareWebPageToPlatform:VPChannelTypeHotel title:self.hotelDetailModel.title descr:self.hotelDetailModel.title shareUrl:[NSString stringWithFormat:@"%zd",self.hid] thumImage:self.hotelDetailModel.imgUrl];
}

#pragma mark -setter or getter
-(void)setHotelDetailModel:(VPHotelDetailModel *)hotelDetailModel{

    _hotelDetailModel =hotelDetailModel;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.rightBarView];
}

-(VPHotelRoomListUpSlideView *)hotelRoomUpSlideView{

    if (!_hotelRoomUpSlideView) {
        _hotelRoomUpSlideView =[[VPHotelRoomListUpSlideView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _hotelRoomUpSlideView.delegate =self;
    }
    return _hotelRoomUpSlideView;
}

-(VPHotelInformationView*)hotelInformationView{
    
    if (!_hotelInformationView) {
        _hotelInformationView =[[VPHotelInformationView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _hotelInformationView;
}


-(UIView *)rightBarView{
    
    if (!_rightBarView) {
        _rightBarView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 61, 44)];
//        [_rightBarView addSubview:self.collectionButton];
        [_rightBarView addSubview:self.commentButton];
        [_rightBarView addSubview:self.shareButton];

    }
    return _rightBarView;
}

//- (UIButton *)collectionButton{
//    
//    if (!_collectionButton) {
//        _collectionButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        _collectionButton.frame =CGRectMake(self.shareButton.left-(17+22), 11, 22, 22);
//        [_collectionButton setImage:[[UIImage imageNamed:@"icon_collection_nor_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//        
//        [_collectionButton setImage:[[UIImage imageNamed:@"icon_collection_sel_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
//        
//        [_collectionButton addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    return _collectionButton;
//}

-(UIButton *)shareButton{
    
    if (!_shareButton) {
        _shareButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame =CGRectMake(self.rightBarView.width-22, 11, 22, 22);
        [_shareButton setImage:[[UIImage imageNamed:@"icon_share_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        [_shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

-(UIButton *)commentButton{
    
    if (!_commentButton) {
        _commentButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame =CGRectMake(self.shareButton.width-22, 11, 22, 22);
        [_commentButton setImage:[[UIImage imageNamed:@"icon_comment_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        [_commentButton addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

-(VPHotelHeadView *)hotelHeadView{

    if (!_hotelHeadView) {
        _hotelHeadView =[[VPHotelHeadView alloc]initWithFrame:CGRectMake(0, -250, self.view.bounds.size.width, 250)];
        _hotelHeadView.delegate =self;
    }
    return _hotelHeadView;
}

@end
