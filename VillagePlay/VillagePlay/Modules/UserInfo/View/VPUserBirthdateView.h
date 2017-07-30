//
//  VPUserBirthdateView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBirthdateBlock)(NSString *birthdate);

@interface VPUserBirthdateView : UIView

+ (instancetype)instantiation;


- (void)showViewWithNowSelectDate:(NSString *)nowSelectDate Block:(SelectBirthdateBlock)selectBirthdateBlock;

@end
