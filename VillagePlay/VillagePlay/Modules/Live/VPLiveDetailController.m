//
//  VPLiveDetailController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveDetailController.h"
#import "VPLiveDetailViewModel.h"
#import "TopicRecommendTableViewCell.h"
#import "VPTravelDetailSlideTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "TopicRelatedRecommentTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "VPWeDetailbController.h"
#import "VPCommentController.h"
#import "MYSegmentView.h"
#import "VPTouchTableView.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationBar+Custom.h"
#import "VPLiveCommentView.h"
#import "MBProgressHUD+Loading.h"
#import "UIImageView+VPWebImage.h"
#import "VPLiveImageTextController.h"
#import "NSError+Reason.h"
#import "VPUserManager.h"
#import "VPLoginController.h"

#define Main_Screen_Height      [UIScreen mainScreen].bounds.size.height
#define Main_Screen_Width       [UIScreen mainScreen].bounds.size.width

#define NAVBAR_CHANGE_POINT -(50+64*2)

@interface VPLiveDetailController ()<UITableViewDelegate,UITableViewDataSource,VPLiveCommentViewDelegate>

@property (nonatomic, strong) VPLiveDetailViewModel *viewModel;

@property (strong, nonatomic) IBOutlet VPTouchTableView *tableView;

@property (nonatomic, strong) MYSegmentView * RCSegView;

@property (nonatomic, strong)VPLiveCommentView* liveCommentView;


@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;


@end

@implementation VPLiveDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Live" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"直播详情";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    self.viewModel = [[VPLiveDetailViewModel alloc] init];
    self.viewModel.channelType =VPChannelTypeLive;
    [self.viewModel liveDetailViewModel:self.liveInfoModel];
    [self.tableView addSubview:[self headWebView:self.liveInfoModel type:self.liveInfoModel.type]];
    self.tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicRecommendTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TopicRecommendTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
    
    [self.tableView registerClass:[TopicRelatedRecommentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TopicRelatedRecommentTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTravelDetailSlideTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTravelDetailSlideTableViewCell class])];
    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    /**
     *  离开头部通知
     *
     *  @param acceptMsg:
     *
     *  @return
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectShowComment:) name:@"SelectVC" object:nil];
}

-(void)selectShowComment:(NSNotification *)notification{

    NSDictionary * userInfo =notification.userInfo;
    NSNumber * tag =userInfo[@"SelectVC"];
    if ([tag isEqual:@(1)]) {
     
        [self.view addSubview:self.liveCommentView];
        self.liveCommentView.hidden =NO;
    }else{
    
        self.liveCommentView.hidden =YES;
    }
}

-(void)acceptMsg:(NSNotification *)notification{
    
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
//    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat tabOffsetY =[self.tableView rectForSection:0].origin.y+338-128-253;
    
    
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

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

#pragma mark -VPLiveCommentViewDelegate
-(void)commentContent:(NSString *)commentCont{
    
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        UIViewController * loginController =[VPLoginController instantiation];
        [self presentViewController:loginController animated:YES completion:nil];
    }else{
        if ([commentCont isEqualToString:@""]) {
            
            [MBProgressHUD showTip:@"内容不能为空"];
        }else{
            
            [MBProgressHUD showLoading];
            [self.viewModel liveAddCommendContent:commentCont success:^{
                [MBProgressHUD showTip:@"评论成功"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"commentRefreshNotificationName" object:self];
                [MBProgressHUD hide];
            } failure:^(NSError *error) {
                [MBProgressHUD showTip:[error errorMessage]];
            }];
        }
    }

}

#pragma mark -setter or getter
-(UIView *)setPageViewControllers
{
    if (!_RCSegView) {
        
        if (self.liveInfoModel.type==1) {
            
            VPWeDetailbController * weDetailbController=[VPWeDetailbController instantiation];
            weDetailbController.stringUrl =self.liveInfoModel.info;
            weDetailbController.channelType =VPChannelTypeLive;
            
            VPCommentController * commentController=[VPCommentController instantiation];
            commentController.channelType = VPChannelTypeLive;
            commentController.villageID =[NSString stringWithFormat:@"%zd",self.liveInfoModel.pid];
            
            NSArray *controllers=@[weDetailbController,commentController];
            
            NSArray *titleArray =@[@"直播介绍",@"评论交流"];
            
            MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64) controllers:controllers titleArray:titleArray ParentController:self lineWidth:Main_Screen_Width/5 lineHeight:3.];
            _RCSegView = rcs;
        }
        if (self.liveInfoModel.type==0){
        
            VPLiveImageTextController *liveImageTextController =[VPLiveImageTextController instantiation];
            liveImageTextController.liveId =self.liveInfoModel.pid;
            VPCommentController * commentController=[VPCommentController instantiation];
            commentController.channelType = VPChannelTypeLive;
            commentController.villageID =[NSString stringWithFormat:@"%zd",self.liveInfoModel.pid];
            
            NSArray *controllers=@[liveImageTextController,commentController];
            
            NSArray *titleArray =@[@"直播详情",@"评论交流"];
            
            MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64) controllers:controllers titleArray:titleArray ParentController:self lineWidth:Main_Screen_Width/5 lineHeight:3.];
            _RCSegView = rcs;
        }
    }
    return _RCSegView;
}

-(UIView *)headWebView:(VPLiveInfoModel *)liveInfoModel type:(NSInteger)type{

    UIView * webBackgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, -250, self.view.bounds.size.width, 250)];
    if (type==1) {
        UIWebView * webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
        NSURL * url =[NSURL URLWithString:liveInfoModel.videoUrl];
        NSURLRequest * qurest =[NSURLRequest requestWithURL:url];
        [webView loadRequest:qurest];
        [webBackgroundView addSubview:webView];
    }
    if (type ==0) {
        UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
        imageView.contentMode =UIViewContentModeScaleAspectFill;
        [imageView xx_setImageWithURLStr:liveInfoModel.photoUrl placeholder:[UIImage imageNamed:@"vp_list_big_Image"]];
        [webBackgroundView addSubview:imageView];
    }
    return webBackgroundView;
}


-(VPLiveCommentView*)liveCommentView{
    
    if (!_liveCommentView) {
        
        _liveCommentView = [[VPLiveCommentView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-47, self.view.bounds.size.width, 47)];
        _liveCommentView.backgroundColor =[UIColor whiteColor];
        _liveCommentView.delegate =self;
    }
    return _liveCommentView;
}
@end
