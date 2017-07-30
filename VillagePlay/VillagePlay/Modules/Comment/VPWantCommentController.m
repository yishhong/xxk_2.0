//
//  VPWantCommentController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPWantCommentController.h"
#import "VPWantCommentViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "QMPhotoCollectionPreviewController.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPCommentLineTableViewCell.h"

@interface VPWantCommentController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPWantCommentViewModel *viewModel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VPWantCommentController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Comment" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPWantCommentViewModel alloc] init];
    self.viewModel.channelType = self.channelType;
    self.viewModel.objeID = self.objeID;
    self.navigationItem.rightBarButtonItem = [self rightButton];
    [self.viewModel layerUI];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

-(UIBarButtonItem *)rightButton{
    UIButton * customButton =[UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame =CGRectMake(0, 0, 40, 30);
    customButton.titleLabel.font =[UIFont systemFontOfSize:15];
    [customButton setTitleColor:[UIColor navigationTintColor] forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [customButton setTitle:@"发布" forState:UIControlStateNormal];
    UIBarButtonItem *filterBarButton =[[UIBarButtonItem alloc]initWithCustomView:customButton];
    return filterBarButton;
}

- (void)submit{
    [self.view endEditing:YES];
//    [self setEditing:NO animated:YES];
    [MBProgressHUD showLoading];
    [self.viewModel submitCommentSuccess:^{
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"commentRefreshNotificationName" object:self];
        [MBProgressHUD showTip:@"评论成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

#pragma mark -UITableViewDelegate&&DataSource
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
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view data:(id)data{
    
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
