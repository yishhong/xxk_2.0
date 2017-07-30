//
//  VPGiftController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPGiftController.h"
#import "VPGiftViewModel.h"
#import "UIColor+HUE.h"

@interface VPGiftController ()

@property (nonatomic, strong) VPGiftViewModel *viewModel;

@end

@implementation VPGiftController

+ (instancetype)instantiation{
    VPGiftController *vc = [[VPGiftController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPGiftViewModel alloc] init];
    self.title = @"邀请有礼";
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    
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
