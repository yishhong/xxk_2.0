//
//  VPUserOccupationView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//  职业

#import <UIKit/UIKit.h>

typedef void(^SelectOccupationBlock)(NSString *occupation);

@interface VPUserOccupationView : UIView


+ (instancetype)instantiation;


- (void)showViewBlock:(SelectOccupationBlock)selectOccupationBlock;
@end
