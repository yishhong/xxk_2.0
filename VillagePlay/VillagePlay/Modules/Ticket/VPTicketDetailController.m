//
//  VPTicketDetailController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketDetailController.h"
#import "VPTicketAddressTableViewCell.h"
#import "VPTicketOpenDateTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "VPTravelDetailSlideTableViewCell.h"
#import "MYSegmentView.h"
#import "UINavigationBar+Awesome.h"
#import "TicketDetailModel.h"
#import "VPWeDetailbController.h"
#import "VPCommentController.h"
#import "VPShareManage.h"
#import "VPTicketReservationController.h"
#import "VPTouchTableView.h"
#import "UIColor+HUE.h"
#import "QMHeadView.h"
#import "UINavigationBar+Custom.h"
#import "UINavigationBar+Awesome.h"
#import "AMRatingControl.h"
#import <Masonry.h>
#import "VPNavigationRightBarView.h"
#import "VPCollectionRecordManager.h"
#import "UIView+Frame.h"
#import "VPWantCommentController.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPTicketDetailModel.h"
#import "UIImageView+VPWebImage.h"
#import "VPLoginController.h"
#import "VPUserManager.h"
#import "VPTicketListModel.h"


#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define NAVBAR_CHANGE_POINT -(50+64*2)

@interface VPTicketDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet VPTouchTableView *tableView;
@property (nonatomic, strong) MYSegmentView * RCSegView;

@property(nonatomic, strong)QMHeadView * headView;

@property(nonatomic,strong)UIImageView * avatarImage;
@property(nonatomic,strong)UILabel *countentLabel;
@property(nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic, strong) TicketDetailModel *viewModel;

@property (strong, nonatomic)  UIView *rightBarView;

@property (strong, nonatomic) UIButton * collectionButton;

@property (strong, nonatomic) UIButton * shareButton;

@property (strong, nonatomic) UIButton * commentButton;

@property (assign, nonatomic) BOOL isCollection;

@property (strong, nonatomic) AMRatingControl * rateCtl;

@property (strong, nonatomic) VPTicketDetailModel *ticketDetailModel;

@property (strong, nonatomic) VPCollectionRecordManager *collectionRecordManager;

@property (strong, nonatomic) UILabel * commentNumberLabel;

@end

@implementation VPTicketDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Ticket" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"门票详情";
    self.viewModel=[[TicketDetailModel alloc]init];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.rightBarView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTicketAddressTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTicketAddressTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTicketOpenDateTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTicketOpenDateTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTravelDetailSlideTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTravelDetailSlideTableViewCell class])];
    
    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    self.headView = [[QMHeadView alloc] init];
    self.headView.frame = CGRectMake(0, -kHEIGHT, CGRectGetWidth(self.view.frame), kHEIGHT);
    [self.tableView addSubview:self.headView];
    
    UIView * starView =[[UIView alloc]init];
    [self.headView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.left.mas_equalTo(14);
        make.bottom.mas_equalTo(self.headView.mas_bottom).offset(-8);
    }];
    AMRatingControl * rateCtl=[[AMRatingControl alloc]initWithLocation:CGPointMake(0, 0) emptyImage:[UIImage imageNamed:@"tab_white_star_nor"] solidImage:[UIImage imageNamed:@"tab_white_star_sel"] andMaxRating:5];
    rateCtl.frame=CGRectMake(0, 0, 20*5, 15);
    rateCtl.userInteractionEnabled = NO;
    rateCtl.rating = 5;
    [starView addSubview:rateCtl];
    self.rateCtl=rateCtl;
    
//    UILabel * commentNumberLabel =[[UILabel alloc]init];
//    commentNumberLabel.text =@"588条评论";
//    commentNumberLabel.textColor =[UIColor whiteColor];
//    commentNumberLabel.font =[UIFont systemFontOfSize:11];
//    [self.headView addSubview:commentNumberLabel];
//    [commentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(11);
//        make.left.mas_equalTo(starView.mas_right).offset(13);
//        make.bottom.mas_equalTo(self.headView.mas_bottom).offset(-10);
//    }];
//    self.commentNumberLabel=commentNumberLabel;
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.font =[UIFont systemFontOfSize:16];
    [self.headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(14);
        make.bottom.mas_equalTo(self.headView.mas_bottom).offset(-15-9-10);
    }];
    self.titleLabel =titleLabel;
    
    /**
     *  离开头部通知
     *
     *  @param acceptMsg:
     *
     *  @return
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    [self loadNewDate];
}

- (void)loadNewDate{

    [MBProgressHUD showLoading];
    [self.viewModel ticketDetailPid:self.pid success:^{
        
        self.ticketDetailModel =[self.viewModel detailModel];
        [MBProgressHUD hide];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

-(void)acceptMsg : (NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**
     * 处理联动
     */
    
    //获取滚动视图y值的偏移量
    CGFloat tabOffsetY =[self.tableView rectForSection:0].origin.y+100-64;
    
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
    [super viewWillAppear:YES];
    self.isCollection =[self.collectionRecordManager isCollectionWithType:VPChannelTypeTicket key:self.pid];
    self.collectionButton.selected =self.isCollection;
    
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
}

/**
 *  收藏
 *
 */
-(void)collectionAction:(UIButton *)sender{
    VPTicketListModel *ticketListModel =self.ticketDetailModel.ticket;
    __weak VPTicketDetailController *weakSelf =self;
    if (self.collectionButton.selected==NO) {
        [self.collectionRecordManager addCollectionRecordWithType:VPChannelTypeTicket key:[NSString stringWithFormat:@"%ld", (long)self.pid] model:ticketListModel block:^(NSError *error, BOOL isSucceed) {
            if (isSucceed==NO) {
                UIViewController * loginController =[VPLoginController instantiation];
                [weakSelf presentViewController:loginController animated:YES completion:nil];
            }else{
            
                weakSelf.collectionButton.selected=YES;
            }
        }];
    }else{
        
        [self.collectionRecordManager removeCollectionRecordWithType:VPChannelTypeTicket key:[NSString stringWithFormat:@"%ld", (long)self.pid] block:^(NSError *error, BOOL isSucceed) {
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
    wantCommentController.channelType=VPChannelTypeTicket;
    wantCommentController.objeID =[self.pid integerValue];
    wantCommentController.title =@"评论";
    [self.navigationController pushViewController:wantCommentController animated:YES];
}

/**
 *  分享
 */
-(void)shareButtonAction{
    
    VPTicketListModel *ticketListModel =self.ticketDetailModel.ticket;

    [VPShareManage getShareWebPageToPlatform:VPChannelTypeTicket title:ticketListModel.title descr:nil shareUrl:[NSString stringWithFormat:@"%zd",ticketListModel.pid] thumImage:ticketListModel.detailPicture];
}
#pragma mark -setter or getter

-(UIView *)setPageViewControllers
{
    if (!_RCSegView) {
        
        VPTicketReservationController *ticketReservationController =[VPTicketReservationController instantiation];
        ticketReservationController.ticketDetailModel =self.ticketDetailModel;
//        VPTicketListModel *ticketListModel =self.ticketDetailModel.ticket;
        
//        VPWeDetailbController * weDetailbController=[VPWeDetailbController instantiation];
//        weDetailbController.channelType =VPChannelTypeTicket;
//        weDetailbController.stringUrl =ticketListModel.info;
        
        VPCommentController * commentController=[VPCommentController instantiation];
        commentController.channelType = VPChannelTypeTicket;
        commentController.villageID =self.pid;

        NSArray *controllers=@[ticketReservationController,commentController];
        NSArray *titleArray =@[@"门票",@"评论"];
        
        MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64) controllers:controllers titleArray:titleArray ParentController:self lineWidth:Main_Screen_Width/5 lineHeight:3.];
        
        _RCSegView = rcs;
    }
    return _RCSegView;
}

-(void)setTicketDetailModel:(VPTicketDetailModel *)ticketDetailModel{

    _ticketDetailModel =ticketDetailModel;
    VPTicketListModel *ticketListModel =ticketDetailModel.ticket;
    [self.headView.imageView xx_setImageWithURLStr:ticketListModel.detailPicture placeholder:[UIImage imageNamed:@"vp_list_big_Image"]];
    self.titleLabel.text = ticketListModel.title;
}

-(UIView *)rightBarView{
    
    if (!_rightBarView) {
        _rightBarView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 61, 44)];
        [_rightBarView addSubview:self.commentButton];
//        [_rightBarView addSubview:self.collectionButton];
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
@end
