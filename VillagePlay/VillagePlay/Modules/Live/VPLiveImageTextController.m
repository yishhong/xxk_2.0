//
//  VPLiveImageTextController.mController
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveImageTextController.h"
#import "VPLiveImageTextViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"

@interface VPLiveImageTextController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPLiveImageTextViewModel *viewModel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VPLiveImageTextController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Live" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPLiveImageTextViewModel alloc] init];
    [self loadNewDate];
}

- (void)loadNewDate{

    [MBProgressHUD showLoading];
    [self.viewModel liveDetailLiveId:self.liveId success:^{
        [MBProgressHUD hide];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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


@end
