//
//  VPSettingController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSettingController.h"
#import "VPSettingViewModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPFeedbackController.h"
#import "VPUserManager.h"
#import "VPShareManage.h"
#import "NSString+Others.h"
#import "UIColor+HUE.h"
#import <UMSocialCore/UMSocialCore.h>
#import "AppKeFuLib.h"
#import <JPUSHService.h>


@interface VPSettingController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VPSettingViewModel *viewModel;

@end

@implementation VPSettingController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Setting" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.viewModel = [[VPSettingViewModel alloc] init];
    [self.viewModel layerUI];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
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
        [self performSelector:cellModel.action withObject:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view data:(id)data{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([cellModel.identifier isEqualToString:@"VPSettingSwitchCell"]){
        BOOL isNotice = [VPUserManager sharedInstance].xx_userInfo.isNotice;
        isNotice = !isNotice;
        [VPUserManager sharedInstance].xx_userInfo.isNotice = isNotice;
        [[VPUserManager sharedInstance] xx_saveUserInfo:[VPUserManager sharedInstance].xx_userInfo];
    }
}


- (void)feedback:(NSIndexPath *)indexPath{
    //反馈
    [self.navigationController pushViewController:[VPFeedbackController instantiation] animated:YES];
}

- (void)shareApp:(NSIndexPath *)indexPath{
    //分享APP
    [VPShareManage getShareWebPageToPlatform:VPChannelTypeAPP title:@"" descr:@"" shareUrl:@"" thumImage:@""];
}

- (void)contactUS:(NSIndexPath *)indexPath{
    NSLog(@"联系我们");
//    [@"18675760522" takeTelephone];
}

- (void)clearCache:(NSIndexPath *)indexPath{
#warning 目前只做了图片的缓存清理
    //清理图片的缓存
    [[SDImageCache sharedImageCache] clearDisk];
    [self.viewModel updateCellModelForRowIndexPath:indexPath value:[self.viewModel cacheSize]];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [[AppKeFuLib sharedInstance] clearAllFileCache];
}

- (void)signOut:(NSInteger)indexPath{
    //退出账号
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:^(id result, NSError *error) {
        if(!error){
        }
    }];
    [[VPUserManager sharedInstance] xx_deleteUserInfo];
    [self.navigationController popViewControllerAnimated:YES];
    
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
