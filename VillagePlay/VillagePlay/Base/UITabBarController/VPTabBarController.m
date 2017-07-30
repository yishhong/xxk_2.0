//
//  VPTabBarController.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/6.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTabBarController.h"
#import "UIColor+HUE.h"
@interface VPTabBarController ()

@end

@implementation VPTabBarController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar setTintColor:[UIColor tabTintColor]];
    [self.tabBar setBarTintColor:[UIColor tabBarTintColor]];
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
