//
//  VPUserCityView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectCityBlock)(NSString *province,NSString *city);


@interface VPUserCityView : UIView

+ (instancetype)instantiation;

- (void)showViewWithNowSelectCity:(NSString *)nowSelectSex Block:(SelectCityBlock)selectCityBlock;

@end
