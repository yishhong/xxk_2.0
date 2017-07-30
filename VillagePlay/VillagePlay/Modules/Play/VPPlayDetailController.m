//
//  VPPlayDetailController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayDetailController.h"
#import "VPPlayDetailViewModel.h"
#import "UIColor+HUE.h"
#import "UINavigationBar+Custom.h"
#import "UINavigationBar+Awesome.h"
#import "VPBlankLinesTableViewCell.h"
#import "QMHeadView.h"
#import <Masonry.h>
#import "VPShareManage.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "NSError+Reason.h"
#import "MBProgressHUD+Loading.h"
#import "UIScrollView+Refresh.h"
#import "VPPlayCourseView.h"
#import "UIImageView+VPWebImage.h"

#define NAVBAR_CHANGE_POINT -(50+64*2)

@interface VPPlayDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) QMHeadView *headView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) VPPlayDetailViewModel *viewModel;

@property (nonatomic, strong)UIBarButtonItem * shareButtonItem;

@property (strong, nonatomic) VPPlayCourseView *playCourseView;

@property (strong, nonatomic) UILabel * dateLabel;

@end

@implementation VPPlayDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Play" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"玩法详情";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    //玩法暂无玩法
//    self.navigationItem.rightBarButtonItem =self.shareButtonItem;
    self.viewModel = [[VPPlayDetailViewModel alloc] init];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.tableView.tableFooterView =[UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];

    [self.view addSubview:self.playCourseView];

    
    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    self.headView = [[QMHeadView alloc] init];
    self.headView.frame = CGRectMake(0, -kHEIGHT, CGRectGetWidth(self.view.frame), kHEIGHT);
    self.headView.imageView.image = [UIImage imageNamed:@"vp_mine_background"];
    [self.tableView addSubview:self.headView];
    
    self.dateLabel =[[UILabel alloc]init];
    self.dateLabel.font =[UIFont systemFontOfSize:14];
//    self.dateLabel.text =@"2天|适合5，6，7月";
    self.dateLabel.textColor =[UIColor whiteColor];
    [self.headView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(self.headView.mas_bottom).offset(-25);
        make.height.mas_equalTo(14);
    }];
//    [self.tableView xx_addHeaderRefreshWithBlock:^{
//        [self loadNewDate];
//    }];
    [MBProgressHUD showLoading];
    [self loadNewDate];
//    [self.tableView xx_beginRefreshing];
}

- (void)loadNewDate{
    __weak typeof(VPPlayDetailController) *weakSelf = self;
    [self.viewModel playDetailPlayID:self.playID success:^{
//        __strong typeof(VPPlayDetailController) *strongSelf = weakSelf;
        [weakSelf.headView.imageView xx_setImageWithURLStr:[weakSelf.viewModel topImageURL] placeholder:[UIImage imageNamed:@"vp_mine_background"]];
        [weakSelf.tableView reloadData];
        
        [weakSelf.playCourseView configDataSource:[weakSelf.viewModel leftArray] block:^(NSIndexPath *indexPath, NSInteger section,NSInteger row) {
            
            if(row>1){
                row = (row-1)*2+1;
            }
            NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:row inSection:section+1];
            [weakSelf.tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
        weakSelf. playCourseView.hidden = ![weakSelf.viewModel isShowButton];
        [weakSelf.tableView xx_endRefreshing];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [weakSelf.tableView xx_endRefreshing];
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //修改导航栏颜色
    UIColor * color = [UIColor navigationBarTintColor];
    CGFloat offsetY = scrollView.contentOffset.y;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"section:%zd",[self.viewModel numberOfSections]);
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"section:%zd,row:%zd",section,[self.viewModel numberOfRowsInSection:section]);
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

#pragma mark - Action respond
/**
 *  分享
 */
-(void)shareAction{
    //    显示分享面板
    [VPShareManage getShareWebPageToPlatform:VPChannelTypePlay title:@"下乡客"  descr:@"快点来" shareUrl:@"http://www.xiaxiangke.com" thumImage:@"icon_mark"];
}

//菜单
-(void)leftMenuButtonAction{

    
}

#pragma mark -setter or getter
-(UIBarButtonItem*)shareButtonItem{
    
    if (!_shareButtonItem) {
        _shareButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_share_white"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    }
    return _shareButtonItem;
}


- (VPPlayCourseView *)playCourseView{
    if(!_playCourseView){
        _playCourseView =  [[VPPlayCourseView alloc] init];
        _playCourseView.hidden = YES;
        [_playCourseView layoutUIWithViewFrame:CGRectMake(10, CGRectGetHeight(self.view.frame)*0.8, 46, 46)];
    }
    return _playCourseView;
}


//-(UIButton *)leftMenuButton{
//
//    if (!_leftMenuButton) {
//        _leftMenuButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        _leftMenuButton.frame =CGRectMake(12, ([UIScreen mainScreen].bounds.size.height-225)/2, 46, 46);
//        [_leftMenuButton setImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
//        [_leftMenuButton addTarget:self action:@selector(leftMenuButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _leftMenuButton;
//}

@end
