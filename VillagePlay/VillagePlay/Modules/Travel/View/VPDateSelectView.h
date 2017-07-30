//
//  VPDateSelectView.h
//  VillagePlay
//
//  Created by  易述宏 on 16/2/15.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPActiveDetailModel.h"


@protocol VPDateSelectViewDelegate <NSObject>

- (void)selectViewDateString:(NSString *)dateString tickets:(NSInteger)tickets;

@end

@interface VPDateSelectView : UIView

@property(assign,nonatomic)NSInteger currentIndex;

@property(strong,nonatomic)id<VPDateSelectViewDelegate> delegate;

- (void)activeDetailModel:(NSArray *)activeDetailModel;

@end
