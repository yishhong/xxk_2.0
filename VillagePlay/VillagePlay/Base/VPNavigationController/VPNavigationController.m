//
//  VPNavigationController.m
//  VillagePlay
//
//  Created by Apricot on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPNavigationController.h"
#import "UIColor+HUE.h"
@interface VPNavigationController ()

@end

@implementation VPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    
    [self.navigationBar setTintColor:[UIColor navigationTintColor]];
    [self.navigationBar setBarTintColor:[UIColor navigationBarTintColor]];
    
//    [[UINavigationBar appearance] setTintColor:[UIColor navigationTintColor]];
//    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarTintColor]];
    

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //设置返回按钮额文字为@“”
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIViewController *oldVC = [self.viewControllers lastObject];
    oldVC.navigationItem.backBarButtonItem = backItem;
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
