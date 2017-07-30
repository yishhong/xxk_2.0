//
//  VPTopicDetailController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicDetailController.h"
#import "VPTopicDetailViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPTravelDetailSlideTableViewCell.h"
#import "VPCommentController.h"
#import "MYSegmentView.h"
#import "VPTopicDetailImageTextController.h"
#import "UINavigationBar+Custom.h"
#import "UINavigationBar+Awesome.h"
#import "UIColor+HUE.h"
#import "VPTouchTableView.h"
#import "VPShareManage.h"
#import "UITableViewCell+DataSource.h"
#import "QMHeadView.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPTopicDetailModel.h"
#import "UIImageView+VPWebImage.h"

#define Main_Screen_Height      [UIScreen mainScreen].bounds.size.height
#define Main_Screen_Width       [UIScreen mainScreen].bounds.size.width

#define NAVBAR_CHANGE_POINT -(50+64*2)

@interface VPTopicDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPTopicDetailViewModel *viewModel;

@property (strong, nonatomic) IBOutlet VPTouchTableView *tableView;

@property (strong, nonatomic) QMHeadView *headView;

@property (strong, nonatomic) IBOutlet UIButton *collectButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (strong, nonatomic) MYSegmentView *RCSegView;
@property (nonatomic, strong) UIImageView *headImageView;//头部图片
@property (nonatomic, strong) VPTopicDetailModel *topicDetailModel;

@property (strong, nonatomic) UIBarButtonItem *shareButtonItem;

@end

@implementation VPTopicDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Topic" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    self.viewModel = [[VPTopicDetailViewModel alloc] init];
    [self.viewModel topicDetailViewModel:nil];
//    self.navigationItem.rightBarButtonItem =self.shareButtonItem;
    self.tableView.showsVerticalScrollIndicator = NO;

    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    self.headView = [[QMHeadView alloc] init];
    self.headView.frame = CGRectMake(0, -kHEIGHT, CGRectGetWidth(self.view.frame), kHEIGHT);
    [self.tableView addSubview:self.headView];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTravelDetailSlideTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTravelDetailSlideTableViewCell class])];
    /**
     *  离开头部通知
     *
     *  @param acceptMsg:
     *
     *  @return
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
        [self loadDate];

}

- (void)loadDate{

    [self.viewModel topicID:self.topicID success:^(VPTopicDetailModel *topicDetailModel) {
        self.topicDetailModel = topicDetailModel;
        [self.headView.imageView xx_setImageWithURLStr:self.topicDetailModel.photoUrl placeholder:[UIImage imageNamed:@"vp_topicDetail_Image"]];
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
    CGFloat tabOffsetY =[self.tableView rectForSection:0].origin.y+80-(64+50+14);
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
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    if ([cellModel.identifier isEqualToString:@"VPTravelDetailSlideTableViewCell"]) {
        
        [cell.contentView addSubview:self.setPageViewControllers];
    }
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

/**
 *  分享
 */
-(void)shareAction{

    //    显示分享面板
    [VPShareManage getShareWebPageToPlatform:VPChannelTypeTopic title:@"下乡客"  descr:@"快点来" shareUrl:@"http://www.xiaxiangke.com" thumImage:@"icon_mark"];
}

/**
 *  收藏
 *
 *  @param sender <#sender description#>
 */
- (IBAction)collectAction:(id)sender {
    
}

/**
 *  评论
 *
 *  @param sender <#sender description#>
 */
- (IBAction)commentAction:(id)sender {
    
}

#pragma mark -setter or getter

-(UIView *)setPageViewControllers
{
    if (!_RCSegView) {
        VPTopicDetailImageTextController * topicDetailImageTextController=[VPTopicDetailImageTextController instantiation];
        topicDetailImageTextController.topicDetailModel =self.topicDetailModel;
        VPCommentController * commentController=[VPCommentController instantiation];
        commentController.villageID =self.topicDetailModel.projectID;
        NSArray *controllers=@[topicDetailImageTextController,commentController];
        
        NSArray *titleArray =@[@"专题详情",@"评论数(10)"];
        
        MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-(49)) controllers:controllers titleArray:titleArray ParentController:self lineWidth:self.view.frame.size.width/5 lineHeight:3.];
        _RCSegView = rcs;
    }
    return _RCSegView;
}

-(UIBarButtonItem*)shareButtonItem{
    
    if (!_shareButtonItem) {
        _shareButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_share_white"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    }
    return _shareButtonItem;
}

@end
