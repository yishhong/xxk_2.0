//
//  VPHotelInformationView.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPHotelDetailModel.h"

@interface VPHotelInformationView : UIView

- (void)showAnimation:(BOOL)animation;
- (void)hideAnimation:(BOOL)animation;

@property(strong, nonatomic)VPHotelDetailModel *hotelDetailModel;

@end
