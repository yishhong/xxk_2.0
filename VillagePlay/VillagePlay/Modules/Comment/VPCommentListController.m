//
//  VPCommentListController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentListController.h"
#import "VPCommentTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPWantCommentController.h"
#import "VPCommentTableViewCell.h"
#import "VPCommentContentTableViewCell.h"
#import "VPCommentContentImageViewTableViewCell.h"
#import "VPCommentViewModel.h"
#import "VillageLookMoreCommentTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "UIScrollView+Refresh.h"
#import "UIColor+HUE.h"
#import "VPCommentLineTableViewCell.h"
#import "VPUserManager.h"
#import "VPLoginController.h"

@interface VPCommentListController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)VPCommentViewModel * viewModel;

@end

@implementation VPCommentListController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Comment" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView=[UIView new];
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.viewModel =[[VPCommentViewModel alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentContentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentContentTableViewCell class])];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentLineTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentLineTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentContentImageViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentContentImageViewTableViewCell class])];
    
    //查看更多评论
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageLookMoreCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageLookMoreCommentTableViewCell class])];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshComment) name:@"commentRefreshNotificationName" object:nil];

    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadDateWithIsFirst:YES];
    }];
    [self.tableView xx_addFooterRefreshWithBlock:^{
        [self loadDateWithIsFirst:NO];
    }];
    [MBProgressHUD showLoading];
    [self loadDateWithIsFirst:YES];
}
- (void)loadDateWithIsFirst:(BOOL)isFirst{
    [self.viewModel commentListVillageID:self.villageID commendType:self.channelType IsFirstLoading:isFirst success:^(BOOL isMore) {
        [self.tableView reloadData];
        [self.tableView xx_isHasMoreData:isMore];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

- (void)refreshComment{

    [self.tableView xx_beginRefreshing];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//- (void)loadNewDate{
//
//
//}
//
//- (void)loadMoreDate{
//
//    [self.viewModel commentListVillageID:self.villageID commendType:VPChannelTypeTravel IsFirstLoading:NO success:^(BOOL isMore) {
//        [self.tableView reloadData];
//        [self.tableView xx_isHasMoreData:isMore];
//    } failure:^(NSError *error) {
//        [self.tableView xx_endRefreshing];
//        [MBProgressHUD showTip:[error errorMessage]];
//    }];
//}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    return cellModel.height;
}

- (IBAction)commentAction:(id)sender {
    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        UIViewController * loginController =[VPLoginController instantiation];
        [self presentViewController:loginController animated:YES completion:nil];
        return;
    }
    VPWantCommentController *wantCommentController =[VPWantCommentController instantiation];
    wantCommentController.title = @"我要评论";
    wantCommentController.channelType = self.channelType;
    wantCommentController.objeID = [self.villageID integerValue];
    [self.navigationController pushViewController:wantCommentController animated:YES];
}

@end
