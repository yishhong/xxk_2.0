//
//  VPUserSexView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectSexBlock)(NSString *sex);


@interface VPUserSexView : UIView

+ (instancetype)instantiation;

- (void)showViewWithNowSelectSex:(NSString *)nowSelectSex Block:(SelectSexBlock)selectSexBlock;

@end
