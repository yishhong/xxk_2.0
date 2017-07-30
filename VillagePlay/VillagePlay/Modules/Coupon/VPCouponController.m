//
//  VPCouponController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCouponController.h"
#import "VPCouponViewModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "MBProgressHUD+Loading.h"
#import "UIScrollView+Refresh.h"
#import "NSError+Reason.h"
#import "UIViewController+Empty.h"

@interface VPCouponController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VPCouponViewModel *viewModel;

@end

@implementation VPCouponController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Coupon" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPCouponViewModel alloc] init];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.viewModel.state = self.state;

//    [self.viewModel layerUI];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self isShowViewType:0 message:@""];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    [self.tableView xx_addHeaderRefreshWithBlock:^{
        [self loadData];
    }];
    [MBProgressHUD showLoading];
    [self loadData];
}
- (void)loadData{
    [self.viewModel loadCouponListSuccess:^{
        [self isShowViewType:1 message:@""];
        [self.tableView reloadEmptyDataSet];
        [self.tableView reloadData];
        [self.tableView xx_endRefreshing];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [MBProgressHUD showTip:error.errorMessage];
        [self.tableView xx_endRefreshing];
    }];
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
