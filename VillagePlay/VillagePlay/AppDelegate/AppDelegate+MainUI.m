//
//  AppDelegate+MainUI.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "AppDelegate+MainUI.h"
#import <objc/runtime.h>
#import "VPAdLaunchImageView.h"
#import "VPStartPageAPI.h"
#import "VPStorageManager.h"
#import "UIImage+TYLaunchImage.h"
#import "VPTabBarController.h"
#import "VPNavigationController.h"
#import "VPRecommendController.h"
#import "UIImageView+VPWebImage.h"
#import "VPTabBarController.h"
#import "VPGuidanceViewController.h"

#define KStartPage "K_TextStr"

@interface AppDelegate ()

@property (nonatomic, strong) VPStartPageAPI *startPage;


@end

@implementation AppDelegate (MainUI)
- (void)setStartPage:(VPStartPageAPI *)startPage{
    objc_setAssociatedObject(self, KStartPage, startPage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)startPage{
    return objc_getAssociatedObject(self, KStartPage);
}

- (void)showMainUI{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = [VPTabBarController instantiation];
    [self.window makeKeyAndVisible];

    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        self.guidanceViewController = [[VPGuidanceViewController alloc] init];
        self.guidanceViewController.view.backgroundColor = [UIColor redColor];
        [self.window addSubview:self.guidanceViewController.view];
        
    }else{
        [self handleAdImageView];
    }

}


- (void)handleAdImageView{
    

    
    VPBannerInfoModel *startPageModel = [VPStorageManager loadStartPageInfo];
    UIImage *adImage =  [UIImage xx_loadImage:startPageModel.imageUrl];
    
    self.startPage = [[VPStartPageAPI alloc] init];
    [self.startPage loadStartPageAPISuccess:^(NSDictionary *responseDict) {
        VPBannerInfoModel *startPageModel = [VPBannerInfoModel yy_modelWithJSON:responseDict[@"body"]];
        [UIImage xx_downImage:startPageModel.imageUrl];
        [VPStorageManager saveStartPageInfo:startPageModel];
    } failure:^(NSError *error) {
    }];
    
    
    if(startPageModel&&adImage){
        VPAdLaunchImageView *adLaunchImageView = [[VPAdLaunchImageView alloc] initWithImage:[UIImage ty_getLaunchImage]];
        
        adLaunchImageView.adImage = adImage;
        
        [adLaunchImageView showInWindowAnimationDuration:6];
        
        if ([startPageModel.typeId isEqualToString:@"6"]) {
            return;
        }
        adLaunchImageView.clickAdImageHandle = ^(){
            VPTabBarController *tabBarController = (VPTabBarController *)self.window.rootViewController;
            VPNavigationController *naviationController = tabBarController.viewControllers.firstObject;
            UIViewController *mainController = naviationController.viewControllers.firstObject;
            if ([mainController isMemberOfClass:[VPRecommendController class]]) {
                [(VPRecommendController *)mainController didTappedBannerModel:startPageModel];
            }
        };
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}

@end
