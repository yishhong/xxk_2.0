//
//  VPMessageController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMessageController.h"
#import "VPMessageViewModel.h"
#import "VPMyCommentController.h"
#import "VPSystemMessageController.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "UIViewController+Empty.h"

@interface VPMessageController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) VPMessageViewModel * viewModel;
@end

@implementation VPMessageController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    self.viewModel = [[VPMessageViewModel alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [MBProgressHUD showLoading];
    [self.viewModel loadMessageCountWithSuccess:^{
        [MBProgressHUD hide];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([self respondsToSelector:cellModel.action]){
        [self performSelector:cellModel.action];
    }
}

- (void)comment{
    [self.navigationController pushViewController:[VPMyCommentController instantiation] animated:YES];
}

- (void)systemNotification{
    [self.navigationController pushViewController:[VPSystemMessageController instantiation] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
