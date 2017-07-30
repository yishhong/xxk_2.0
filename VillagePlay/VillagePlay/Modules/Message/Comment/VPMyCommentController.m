//
//  VPMyCommentController.mController
//  VillagePlay
//
//  Created by Apricot on 2016/12/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMyCommentController.h"
#import "VPMyCommentViewModel.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "UITableViewCell+DataSource.h"
#import "UIViewController+Empty.h"


@interface VPMyCommentController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPMyCommentViewModel *viewModel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VPMyCommentController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPMyCommentViewModel alloc] init];
    self.title = @"评论我的";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource =self;
    self.tableView.emptyDataSetDelegate = self;
    
    
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadDataWithIsFirst:YES];
    }];
    [self.tableView xx_addFooterRefreshWithBlock:^{
        [self loadDataWithIsFirst:NO];
    }];
    //首次加载
    [MBProgressHUD showLoading];
    [self loadDataWithIsFirst:YES];
}

- (void)loadDataWithIsFirst:(BOOL)isFirst{
    __weak typeof(VPMyCommentController *)weakSelf = self;
    [self.viewModel loadMyCommentMessageWithIsFirst:isFirst success:^(BOOL isMore) {
        [self isShowViewType:1 message:@""];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView xx_isHasMoreData:isMore];
        [self.tableView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView reloadEmptyDataSet];

        [weakSelf.tableView xx_endRefreshing];
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

#pragma mark -UITableViewDelegate&&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellModelForRowAtIndexPath:indexPath];
    return cellModel.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
