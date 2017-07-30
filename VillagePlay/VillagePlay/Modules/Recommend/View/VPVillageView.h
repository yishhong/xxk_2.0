//
//  VPVillageView.h
//  VillagePlay
//
//  Created by Apricot on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPVillageView : UIView

/**
 村庄图片
 */
@property (nonatomic, strong) UIImageView *villagePhoto;

/**
 村庄名称
 */
@property (nonatomic, strong) UILabel *lb_title;

/**
 距离
 */
@property (nonatomic, strong) UILabel *lb_distance;
@end
