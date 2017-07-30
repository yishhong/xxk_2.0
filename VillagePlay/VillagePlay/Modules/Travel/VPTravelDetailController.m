//
//  VPTravelDetailController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelDetailController.h"
#import "VPTravelDetailTableViewCell.h"
#import "XXNibConvention.h"
#import "VPTravelTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPWeDetailbController.h"
#import "VPCommentController.h"
#import "MYSegmentView.h"
#import "VPTouchTableView.h"
#import "VPTravelDetailNameView.h"
#import "VPShareManage.h"
#import "UINavigationBar+Awesome.h"
#import "VPOrderWriteController.h"
#import "VPConsultingController.h"
#import "VPWantCommentController.h"
#import "VPBlankLinesTableViewCell.h"
#import "TravelDetailModel.h"
#import "XXCellModel.h"
#import "VPTravelDetailSlideTableViewCell.h"
#import "QMHeadView.h"
#import "UINavigationBar+Custom.h"
#import "UINavigationBar+Awesome.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPActiveDetailModel.h"
#import "UIImageView+VPWebImage.h"
#import "NSString+Others.h"
#import "VPCollectionRecordManager.h"
#import "VPLoginController.h"
#import "UIView+Frame.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPUserManager.h"
#import "AppKeFuLib.h"
#import "VPMapController.h"
#import "UIAlertController+Order.h"
#import "VPTravelOrderController.h"
#import "VPTabBarController.h"
#import "VPNavigationController.h"
#import "VPTravelOrderDetailController.h"
#import "VPMineController.h"
#import "VPTravelOrderOptionController.h"
#import "VPOrderController.h"
#import <SDImageCache.h>

#define Main_Screen_Height      [UIScreen mainScreen].bounds.size.height
#define Main_Screen_Width       [UIScreen mainScreen].bounds.size.width

#define NAVBAR_CHANGE_POINT -(50+64*2)


@interface VPTravelDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet VPTouchTableView *tableView;

@property (strong, nonatomic) IBOutlet UIButton *consultingButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (strong, nonatomic) IBOutlet UIButton *applyButton;

@property (nonatomic, strong) MYSegmentView * RCSegView;

@property (nonatomic, strong)QMHeadView * headView;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;

@property (strong, nonatomic)TravelDetailModel *viewModel;

@property (strong, nonatomic)VPActiveDetailModel *activeDetailModel;

@property (strong, nonatomic)UIView *rightBarView;

@property (strong, nonatomic)UIButton * collectionButton;

@property (strong, nonatomic)UIButton * shareButton;

@property (assign, nonatomic)BOOL isCollection;


@property (strong, nonatomic)VPCollectionRecordManager *collectionRecordManager;


@end

@implementation VPTravelDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Travel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title =@"旅游详情";
    self.collectionRecordManager =[[VPCollectionRecordManager alloc]init];
    self.view.backgroundColor =[UIColor controllerBackgroundColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.viewModel =[[TravelDetailModel alloc]init];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTravelDetailTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTravelDetailTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTravelDetailNameView class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTravelDetailNameView class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTravelDetailSlideTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTravelDetailSlideTableViewCell class])];
    
    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    self.headView = [[QMHeadView alloc] init];
    self.headView.frame = CGRectMake(0, -kHEIGHT, CGRectGetWidth(self.view.frame), kHEIGHT);
    [self.tableView addSubview:self.headView];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"标签" style:UIBarButtonItemStylePlain target:nil action:nil];

    /**
     *  离开头部通知
     *
     *  @param acceptMsg:
     *
     *  @return
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    
    /**
     刷新旅游详情
     @param ravelDetailRefresh <#ravelDetailRefresh description#>
     @return <#return value description#>
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ravelDetailRefresh) name:@"TravelDetailRefreshNotificationName" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ravelDetailRefresh) name:@"refundRefreshNotificationName" object:nil];
    [self loadNewDate];


}

- (void)loadNewDate{

    [MBProgressHUD showLoading];
    [self.viewModel travelDetailID:self.travelID success:^{
        self.activeDetailModel =[self.viewModel activeModel];
        [self.tableView reloadData];
        [MBProgressHUD hide];
        [self.tableView xx_endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

- (void)applyState{

    switch (self.activeDetailModel.state) {
        case 0:
            if ([self.activeDetailModel.actType isEqualToString:@"0"]) {
                
                [self.applyButton setTitle:@"暂不支持预定" forState:UIControlStateNormal];
                [self.applyButton setBackgroundColor:[UIColor VPDetailColor]];
                self.applyButton.userInteractionEnabled=NO;
                
            }else{
                
                [self.applyButton setTitle:@"立即报名" forState:UIControlStateNormal];
                [self.applyButton setBackgroundColor:[UIColor VPRedColor]];
                self.applyButton.userInteractionEnabled=YES;
            }
            break;
            
        case 1:
            
            [self.applyButton setTitle:@"报名已满" forState:UIControlStateNormal];
            [self.applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.applyButton setBackgroundColor:[UIColor VPDetailColor]];
            self.applyButton.userInteractionEnabled=NO;
            break;
            
        case 2:
            [self.applyButton setTitle:@"报名结束" forState:UIControlStateNormal];
            [self.applyButton setBackgroundColor:[UIColor VPDetailColor]];
            self.applyButton.userInteractionEnabled=NO;
            break;
            
        default:
            break;
    }

}

- (void)ravelDetailRefresh{

    [self loadNewDate];
}


-(void)acceptMsg: (NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**
     * 处理联动
     */
    //获取滚动视图y值的偏移量
    CGFloat tabOffsetY =[self.tableView rectForSection:0].origin.y+220-64;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY>=tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
    //修改导航栏颜色
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
    [self.headView updateFrameWith:scrollView];
}

- (void)viewWillAppear:(BOOL)animated{
   self.isCollection =[self.collectionRecordManager isCollectionWithType:VPChannelTypeTravel key:self.travelID];
    self.collectionButton.selected =self.isCollection;
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
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor navigationTitleColor]];
}
#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel numberOfRowsInSection:section];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    if ([cellModel.identifier isEqualToString:@"VPTravelDetailSlideTableViewCell"]) {
         [cell.contentView addSubview:self.setPageViewControllers];
    }
    [cell xx_configCellWithEntity:cellModel];

    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel *cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==4) {
        VPMapController * mapController =[VPMapController instantiation];
        mapController.mapTitle =self.activeDetailModel.address;
        mapController.location =self.activeDetailModel.location;
        [self.navigationController pushViewController:mapController animated:YES];
    }
    if (indexPath.row==5) {
        NSString * phoneString =self.activeDetailModel.phoneNumber;
        [phoneString takeTelephone];
    }
}

#pragma mark -Response Action
/**
 *  咨询
 *
 *  @param sender <#sender description#>
 */
- (IBAction)consultingAction:(id)sender {
    
//    VPConsultingController * consultingController =[VPConsultingController instantiation];
//    consultingController.title =@"在线咨询";
//    [self.navigationController pushViewController:consultingController animated:YES];
    UILabel *lb_title =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lb_title.text = @"联系客服";
    lb_title.textColor = [UIColor navigationTintColor];
    //第一种打开会话页面方式
    UIImage *userAvatarImage = nil;
    if([VPUserManager sharedInstance].xx_userinfoID.length>0){
        userAvatarImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[VPUserManager sharedInstance].xx_userInfo.smallHeadPhoto];
        [[AppKeFuLib sharedInstance] setTagNickname:[VPUserManager sharedInstance].xx_userInfo.nickname];
    }
//    UIImage *userAvatarImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[VPUserManager sharedInstance].xx_userInfo.smallHeadPhoto];
    
    
    [[AppKeFuLib sharedInstance] pushChatViewController:self.navigationController
                                      withWorkgroupName:@"workgroup_1"
                                 hideRightBarButtonItem:YES
                             rightBarButtonItemCallback:nil
                                 showInputBarSwitchMenu:NO
                                  withLeftBarButtonItem:nil
                                          withTitleView:lb_title
                                 withRightBarButtonItem:nil
                                        withProductInfo:nil
                             withLeftBarButtonItemColor:[UIColor navigationTintColor]
                               hidesBottomBarWhenPushed:YES
                                     showHistoryMessage:YES
                                           defaultRobot:NO
                                               mustRate:NO //注意：如果要强制用户在关闭会话的时候评价，需要首先设置参数：withLeftBarButtonItem，
     // 否则此参数不会生效
                                    withKefuAvatarImage:[UIImage imageNamed:@"share"]
                                    withUserAvatarImage:userAvatarImage?:[UIImage imageNamed:@"vp_headPhoto"]
                                    shouldShowGoodsInfo:FALSE
                                  withGoodsImageViewURL:nil
                                   withGoodsTitleDetail:nil
                                         withGoodsPrice:nil
                                           withGoodsURL:nil
                                    withGoodsCallbackID:nil
                               goodsInfoClickedCallback:nil
     
                             httpLinkURLClickedCallBack:nil
                         faqButtonTouchUpInsideCallback:nil];}
/**
 *  评论
 *
 *  @param sender <#sender description#>
 */
- (IBAction)commentAction:(id)sender {
    
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        UIViewController * loginController =[VPLoginController instantiation];
        [self presentViewController:loginController animated:YES completion:nil];
        return;
    }
    VPWantCommentController * wantCommentController =[VPWantCommentController instantiation];
    wantCommentController.channelType = VPChannelTypeTravel;
    wantCommentController.objeID = [self.travelID integerValue];
    wantCommentController.title =@"评论";
    [self.navigationController pushViewController:wantCommentController animated:YES];
}
/**
 *  报名
 *
 *  @param sender <#sender description#>
 */

- (IBAction)enterAction:(id)sender {
    
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        UIViewController * loginController =[VPLoginController instantiation];
        [self presentViewController:loginController animated:YES completion:nil];
    }else{
        if ([self.activeDetailModel.ifSignUp isEqualToString:@"0"]) {
            
            UIAlertController * alertController =[UIAlertController selectOrderStateMessage:@"该订单还有未支付订单请支付或取消订单" deleteString:@"去支付" block:^(NSInteger index) {
                if (index==1) {
                    
                    VPTravelOrderDetailController *travelOrderDetailController =[VPTravelOrderDetailController instantiation];
                    travelOrderDetailController.ceid = self.activeDetailModel.orderNum;
                    travelOrderDetailController.type = 0;
                    [self.navigationController pushViewController:travelOrderDetailController animated:YES];
                }
            }];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
        
            VPOrderWriteController * orderWriteController =[VPOrderWriteController instantiation];
            orderWriteController.title =@"订单提交";
            orderWriteController.activeDetailModel =self.activeDetailModel;
            [self.navigationController pushViewController:orderWriteController animated:YES];
        }
    }
}

/**
 *  收藏
 *
 */
-(void)collectionAction:(UIButton *)sender{

    __weak VPTravelDetailController *weakSelf =self;
    if (self.collectionButton.selected==NO) {
        [self.collectionRecordManager addCollectionRecordWithType:VPChannelTypeTravel key:self.travelID model:self.activeDetailModel block:^(NSError *error, BOOL isSucceed) {
            if (isSucceed==NO) {
                UIViewController * loginController =[VPLoginController instantiation];
                [weakSelf presentViewController:loginController animated:YES completion:nil];
            }else{
                weakSelf.collectionButton.selected=YES;
            }
        }];

    }else{
        [self.collectionRecordManager removeCollectionRecordWithType:VPChannelTypeTravel key:self.travelID block:^(NSError *error, BOOL isSucceed) {
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
 *  分享
 */
-(void)shareButtonAction{

   [VPShareManage getShareWebPageToPlatform:VPChannelTypeTravel title:self.activeDetailModel.title  descr:self.activeDetailModel.title shareUrl:self.activeDetailModel.vid thumImage:[self.activeDetailModel.imageUrl absoluteString]];
}

#pragma mark -setter or getter

-(UIView *)setPageViewControllers
{
    if (!_RCSegView) {
        
        VPWeDetailbController * weDetailbControlle=[VPWeDetailbController instantiation];
        weDetailbControlle.stringUrl =self.activeDetailModel.detailUrl;
        weDetailbControlle.channelType =VPChannelTypeTravel;
        
        VPCommentController * commentController=[VPCommentController instantiation];
        commentController.villageID =self.activeDetailModel.vid;
        commentController.channelType = VPChannelTypeTravel;
        NSArray *controllers=@[weDetailbControlle,commentController];
        NSArray *titleArray =@[@"活动详情",@"评论"];
        
        MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-(64+49)) controllers:controllers titleArray:titleArray ParentController:self lineWidth:Main_Screen_Width/5 lineHeight:3.];
        
        _RCSegView = rcs;
    }
    return _RCSegView;
}

- (void)setActiveDetailModel:(VPActiveDetailModel *)activeDetailModel{

    _activeDetailModel =activeDetailModel;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.rightBarView];
    NSString * urlString =[NSString stringWithFormat:@"%@",self.activeDetailModel.imageUrl];
    [self.headView.imageView xx_setImageWithURLStr:urlString placeholder:[UIImage imageNamed:@"vp_topicDetail_Image"]];
    [self applyState];

}

-(UIView *)rightBarView{
    
    if (!_rightBarView) {
        _rightBarView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 61, 44)];
        [_rightBarView addSubview:self.collectionButton];
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

@end
