//
//  VPRecommendController.hController
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "VPBannerInfoModel.h"
@interface VPRecommendController : VPBaseViewController

+ (instancetype)instantiation;

- (void)didTappedBannerModel:(VPBannerInfoModel *)item;

@end