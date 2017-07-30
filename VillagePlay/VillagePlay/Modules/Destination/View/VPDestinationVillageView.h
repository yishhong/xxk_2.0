//
//  VPDestinationVillageView.h
//  VillagePlay
//
//  Created by Apricot on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPVillageModel.h"
@interface VPDestinationVillageView : UIView

/**
 *  村庄图片
 */
@property (nonatomic, strong) UIImageView *picture;

/**
 *  标题
 */
@property (nonatomic, strong) UILabel *lb_title;

/**
 *  距离
 */
@property (nonatomic, strong) UILabel *lb_distance;

- (void)configData:(VPVillageModel *)villageModel;

@end
