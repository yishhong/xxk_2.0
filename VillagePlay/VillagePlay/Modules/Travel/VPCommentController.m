//
//  VPCommentController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentController.h"
#import "VPCommentTableViewCell.h"
#import "VPCommentHeadImageViewTableViewCell.h"
#import "VPCommentContentTableViewCell.h"
#import "VPCommentContentImageViewTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXNibConvention.h"
#import "VPCommentListController.h"
#import "VillageLookMoreCommentTableViewCell.h"
#import "VPCommentListModel.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPWantCommentController.h"
#import "VPCommentLineTableViewCell.h"
#import "UIScrollView+Refresh.h"

#import "UIViewController+Empty.h"


@interface VPCommentController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)VPCommentListModel * viewModel;

@end

@implementation VPCommentController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Travel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource =self;
    self.tableView.emptyDataSetDelegate =self;
    [self.tableView reloadEmptyDataSet];
    self.viewModel =[[VPCommentListModel alloc]init];
    if (self.channelType==VPChannelTypeLive) {
        
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentHeadImageViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentHeadImageViewTableViewCell class])];
    }else{
    
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentTableViewCell class])];
        
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentContentImageViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentContentImageViewTableViewCell class])];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentLineTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentLineTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentContentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentContentTableViewCell class])];
    
    //查看更多评论
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageLookMoreCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageLookMoreCommentTableViewCell class])];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshComment) name:@"commentRefreshNotificationName" object:nil];
    if (self.channelType==VPChannelTypeLive){
    [self.tableView xx_addFooterRefreshWithBlock:^{
        [self loadDateWithIsFirst:NO];
    }];
    }
    [self loadDateWithIsFirst:YES];
}
- (void)loadDateWithIsFirst:(BOOL)isFirst{
    [self.viewModel commentListVillageID:self.villageID commendType:self.channelType IsFirstLoading:isFirst success:^(BOOL isMore) {
        [self.tableView reloadData];
        [self.tableView xx_isHasMoreData:isMore];
        [self isShowViewType:1 message:@""];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView reloadEmptyDataSet];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

- (void)refreshComment{
    [self loadDateWithIsFirst:YES];
//    [self loadNewDate];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//- (void)loadNewDate{
//    
//    [self.viewModel commentListVillageID:self.villageID commendType:self.channelType IsFirstLoading:YES success:^(BOOL isMore) {
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    if ([cellModel.identifier isEqualToString:@"VillageLookMoreCommentTableViewCell"]) {
        VPCommentListController * commentListController =[VPCommentListController instantiation];
        commentListController.villageID =self.villageID;
        commentListController.channelType = self.channelType;
        commentListController.title =@"评论列表";
        [self.navigationController pushViewController:commentListController animated:YES];
    }
}


#pragma mark -CommentFootViewDelegate
-(void)commentList{

    VPWantCommentController *wantCommentController =[VPWantCommentController instantiation];
    wantCommentController.channelType = self.channelType;
    wantCommentController.objeID = [self.villageID integerValue];
    wantCommentController.title =@"我要评论";
    [self.navigationController pushViewController:wantCommentController animated:YES];
}

@end
