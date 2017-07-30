//
//  VPMineController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMineController.h"
#import "VPMineViewModel.h"
#import "UIImageView+VPWebImage.h"
#import "UINavigationBar+Awesome.h"
#import "QMHeadView.h"
#import "UIColor+HUE.h"
#import "UIBarButtonItem+Custom.h"
#import "UINavigationBar+Custom.h"
#import "UITableViewCell+DataSource.h"
#import <Masonry.h>
#import "UIImageView+VPWebImage.h"
#import "VPMessageController.h"
#import "VPSettingController.h"
#import "VPEditUserInfoController.h"
#import "VPMemberCenterController.h"
#import "VPCollectionController.h"
#import "VPGiftController.h"
#import "VPAboutController.h"
#import "VPOrderController.h"
#import "VPCouponOptionController.h"
#import "AppKeFuLib.h"
#import "VPNotLoginView.h"
#import "VPLoginView.h"
#import "VPUserManager.h"
#import "VPNavigationController.h"
#import "VPLoginController.h"
#import "VPRegisterController.h"
#import "VPGeneralWebController.h"
#import <SDImageCache.h>
//#define NAVBAR_CHANGE_POINT -(50+64*2)
#define NAVBAR_CHANGE_POINT -(kHEIGHT-3)

@interface VPMineController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) VPMineViewModel *viewModel;
@property (strong, nonatomic) QMHeadView *headView;
/**
 *  未登录的View
 */
@property (strong, nonatomic) VPNotLoginView *notLoginView;
/**
 *  登录后的View
 */
@property (strong, nonatomic) VPLoginView *loginView;
@end

@implementation VPMineController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我的";
    self.viewModel = [[VPMineViewModel alloc] init];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"vp_mine_message"] style:UIBarButtonItemStylePlain target:self action:@selector(leftMessage)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"vp_mine_setup"] style:UIBarButtonItemStylePlain target:self action:@selector(rightSetting)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self.navigationItem.leftBarButtonItem xx_barButtonTitleFont];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    self.headView = [[QMHeadView alloc] init];
    self.headView.frame = CGRectMake(0, -kHEIGHT, CGRectGetWidth(self.view.frame), kHEIGHT);
    self.headView.imageView.image = [UIImage imageNamed:@"vp_mine_background"];
    [self.tableView addSubview:self.headView];

    [self.viewModel layerUI];
    
    //布局未登录的UI
    self.notLoginView = [[VPNotLoginView alloc] init];
    [self.headView addSubview:self.notLoginView];
    [self.notLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.headView.mas_leading).offset(+10);
        make.trailing.mas_equalTo(self.headView.mas_trailing).offset(-10);
        make.centerY.mas_equalTo(self.headView.mas_centerY).offset(+32);
        make.height.mas_equalTo(80);
    }];
    //布局已登录的UI
    self.loginView = [[VPLoginView alloc] init];
    [self.headView addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.headView.mas_leading).offset(+10);
        make.trailing.mas_equalTo(self.headView.mas_trailing).offset(-15);
        make.top.mas_equalTo(self.headView.mas_top).offset(64);
        make.bottom.mas_equalTo(self.headView.mas_bottom).offset(-10);
    }];
}

/**
 消息中心
 */
- (void)leftMessage{
    if([VPUserManager sharedInstance].xx_userinfoID.length>1){
        [self.navigationController pushViewController:[VPMessageController instantiation] animated:YES];
    }else{
        //未登录时不能打开消息中心
        [self presentViewController:[VPLoginController instantiation] animated:YES completion:nil];
    }
}

/**
 设置
 */
- (void)rightSetting{
    [self.navigationController pushViewController:[VPSettingController instantiation] animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //修改导航栏颜色
    UIColor * color = [UIColor navigationBarTintColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat scale = 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64);
        CGFloat alpha = MIN(1, scale<0?0:(scale>0.94)?0.94:scale);
        
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
    [super viewWillAppear:YES];
    
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setTranslucent:YES];

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    //已登录
    if([VPUserManager sharedInstance].xx_userinfoID.length>0){
        self.notLoginView.hidden = YES;
        self.loginView.hidden = NO;
        [self.loginView loadData:[VPUserManager sharedInstance].xx_userInfo block:^{
            [self.navigationController pushViewController:[VPEditUserInfoController instantiation] animated:YES];
        }];
    }else{
        self.notLoginView.hidden = NO;
        self.loginView.hidden = YES;
        [self.notLoginView clickEvent:^(BOOL isRegister) {
            //isRegister YES 为注册 NO为登录
            UIViewController *vc = nil;
            if(!isRegister){
                vc = [VPLoginController instantiation];
            }else{
                //由于注册页面本身不带有Navigation 所以需要实例化一个
                vc = [[VPNavigationController alloc] initWithRootViewController:[VPRegisterController instantiation]];
            }
            [self presentViewController:vc animated:YES completion:nil];
        }];
    }
    
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
    if([self respondsToSelector:cellModel.action]){

        if([VPUserManager sharedInstance].xx_userinfoID.length<1){
            if(![NSStringFromSelector(cellModel.action) isEqualToString:@"go_about"]){
                [self presentViewController:[VPLoginController instantiation] animated:YES completion:nil];
                return;
            }
        }
        [self performSelector:cellModel.action];
    }
}

- (void)go_order{
    [self.navigationController pushViewController:[VPOrderController instantiation] animated:YES];
}

- (void)go_coupon{
    [self.navigationController pushViewController:[VPCouponOptionController instantiation] animated:YES];
}

- (void)go_collection{
    [self.navigationController pushViewController:[VPCollectionController instantiation] animated:YES];
}

- (void)go_memberCenter{
    [self.navigationController pushViewController:[VPMemberCenterController instantiation] animated:YES];
}

- (void)go_gift{
//    http://apipage.xiaxiangke.com/edm/yqyl/index.html
    VPGeneralWebController * webVC = [VPGeneralWebController instantiation];
    webVC.title = @"邀请有礼";
    webVC.channelType = VPChannelTypeGift;
    
#ifdef DEBUG
    webVC.url = @"http://apipage.xiaxiangke.com/edm/yqyl1/index.html";
#else
    webVC.url = @"http://apipage.xiaxiangke.com/edm/yqyl/index.html";
#endif
    [self.navigationController pushViewController:webVC animated:YES];
}

/**
 联系客服
 */
- (void)go_service{
     UILabel *lb_title =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lb_title.text = @"联系客服";
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.textColor = [UIColor navigationTintColor];
    //第一种打开会话页面方式
    //获取用户头像
    UIImage *userAvatarImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[VPUserManager sharedInstance].xx_userInfo.smallHeadPhoto];
    
    [[AppKeFuLib sharedInstance] setTagNickname:[VPUserManager sharedInstance].xx_userInfo.nickname];
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
                         faqButtonTouchUpInsideCallback:nil];
}
- (void)go_about{
    
    [self.navigationController pushViewController:[VPAboutController instantiation] animated:YES];
}

@end
