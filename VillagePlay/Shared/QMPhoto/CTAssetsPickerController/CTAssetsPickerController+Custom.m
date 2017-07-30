//
//  CTAssetsPickerController+Custom.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "CTAssetsPickerController+Custom.h"

#import <CTAssetsPickerController/CTAssetCollectionViewCell.h>
#import <CTAssetsPickerController/CTAssetsGridView.h>
#import <CTAssetsPickerController/CTAssetsGridViewFooter.h>
#import <CTAssetsPickerController/CTAssetsGridViewCell.h>
#import <CTAssetsPickerController/CTAssetsGridSelectedView.h>
#import <CTAssetsPickerController/CTAssetCheckmark.h>
#import <CTAssetsPickerController/CTAssetSelectionLabel.h>
#import <CTAssetsPickerController/CTAssetsPageView.h>

@implementation CTAssetsPickerController (Custom)
+ (void)customView{
    UIColor * color1 = [UIColor colorWithRed:102.0/255.0 green:161.0/255.0 blue:130.0/255.0 alpha:1];
    
    
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[CTAssetsPickerController class], nil];
    
    // set nav bar style to black to force light content status bar style
    navBar.barStyle = UIBarStyleDefault;
    
    // bar tint color
    navBar.barTintColor = [UIColor whiteColor];
    
    // tint color 按钮的样式
    navBar.tintColor = [UIColor blackColor];
    
    // title 的样式
    navBar.titleTextAttributes =
    @{NSForegroundColorAttributeName: [UIColor blackColor],
      //      NSFontAttributeName : @""
      };
    
    // bar button item appearance
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearanceWhenContainedIn:[CTAssetsPickerController class], nil];
    [barButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}
                                 forState:UIControlStateNormal];
    
    //页面的背景颜色
    UITableView *assetCollectionView = [UITableView appearanceWhenContainedIn:[CTAssetsPickerController class], nil];
    assetCollectionView.backgroundColor = [UIColor colorWithRed:0.9608 green:0.9608 blue:0.9608 alpha:1.0];
    
    CTAssetCollectionViewCell *assetCollectionViewCell = [CTAssetCollectionViewCell appearance];
    assetCollectionViewCell.titleFont = [UIFont systemFontOfSize:16.0];
    assetCollectionViewCell.titleTextColor = [UIColor blackColor];
    assetCollectionViewCell.selectedTitleTextColor = [UIColor blackColor];
    assetCollectionViewCell.countFont = [UIFont systemFontOfSize:12.0];
    assetCollectionViewCell.countTextColor = [UIColor blackColor];
    assetCollectionViewCell.selectedCountTextColor = [UIColor blackColor];
    assetCollectionViewCell.accessoryColor = color1;
    assetCollectionViewCell.selectedAccessoryColor = [UIColor cyanColor];
    assetCollectionViewCell.backgroundColor = assetCollectionView.backgroundColor;
    assetCollectionViewCell.selectedBackgroundColor =  [UIColor colorWithRed:0.8824 green:0.8824 blue:0.8824 alpha:1.0];
    
    CTAssetsGridSelectedView *assetsGridSelectedView = [CTAssetsGridSelectedView appearance];
    assetsGridSelectedView.selectedBackgroundColor = [UIColor colorWithWhite:1 alpha:0];
    assetsGridSelectedView.tintColor = [UIColor colorWithWhite:1 alpha:0];
    assetsGridSelectedView.borderWidth = 3.0;
    
    //
    CTAssetCheckmark *checkmark = [CTAssetCheckmark appearance];
    checkmark.tintColor = color1;
    [checkmark setMargin:0.0 forVerticalEdge:NSLayoutAttributeRight horizontalEdge:NSLayoutAttributeTop];
    
    CTAssetSelectionLabel *assetSelectionLabel = [CTAssetSelectionLabel appearance];
    assetSelectionLabel.borderWidth = 1.0;
    assetSelectionLabel.borderColor = [UIColor whiteColor];
    [assetSelectionLabel setSize:CGSizeMake(24.0, 24.0)];
    [assetSelectionLabel setCornerRadius:12.0];
    [assetSelectionLabel setMargin:4.0 forVerticalEdge:NSLayoutAttributeRight horizontalEdge:NSLayoutAttributeTop];
    [assetSelectionLabel setTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0],
                                             NSForegroundColorAttributeName : [UIColor colorWithRed:0.0 green:0.4464 blue:1.0 alpha:1.0],
                                             NSBackgroundColorAttributeName : [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]}];
    
    //设置全屏显示的时候的背景颜色
    CTAssetsPageView *assetsPageView = [CTAssetsPageView appearance];
    assetsPageView.pageBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    assetsPageView.fullscreenBackgroundColor = assetsPageView.pageBackgroundColor;
    
    // progress view
    [UIProgressView appearanceWhenContainedIn:[CTAssetsPickerController class], nil].tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
}
@end
