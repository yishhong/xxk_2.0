//
//  VPRecommendBannerCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRecommendBannerCell.h"
#import "UITableViewCell+DataSource.h"
//#import "SZCirculationImageView.h"
#import "UIColor+HUE.H"
#import <Masonry.h>
#import "XXCellModel.h"
#import "VPBannerInfoModel.h"
#import "UIColor+HUE.h"
#import "UIImageView+VPWebImage.h"
#import "VPLocationManager.h"

#define W [UIScreen mainScreen].bounds.size.width

@interface VPRecommendBannerCell ()<SDCycleScrollViewDelegate>


@end

@implementation VPRecommendBannerCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.bannerView.backgroundColor = [UIColor whiteColor];
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.delegate = self;
    
    
//    self.bannerView.autoScroll = YES;
//    self.bannerView.showPageControl = YES;

    self.bannerView.placeholderImage = [UIImage imageNamed:@"vp_destination_recomentHotel_Iamge"];
    self.bannerView.currentPageDotColor = [UIColor navigationTintColor];

}

- (void)tapAddress:(UIButton *)button{
    //地址事件触发
    [self xx_cellClickAtView:button];
}

- (void)xx_configCellWithEntity:(id)entity{
    [self.bannerView adjustWhenControllerViewWillAppera];
    XXCellModel *cellModel = entity;
    NSArray *bannerArray = cellModel.dataSource;
    NSMutableArray *bannerImages = [NSMutableArray array];
    for (VPBannerInfoModel *bannerInfoModel in bannerArray) {
        [bannerImages addObject:bannerInfoModel.imageUrl];
    }
    self.bannerView.imageURLStringsGroup = bannerImages;
    self.bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    self.bannerView.currentPageDotColor = [UIColor blackTextColor];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self xx_cellClickAtView:cycleScrollView data:@(index)];
}

/**
 *  点击banner图
 *
 *  @param index <#index description#>
 */
-(void)didselectIndex:(NSInteger)index{

    NSLog(@"%ld",(long)index);
}

//- (void)xx_configCellWithEntity:(id)entity{
//
//}

@end
