//
//  VPTicketDropView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VPTicketDropViewDelegate <NSObject>

//orderby 0默认排序，1按价格排序，2.按推荐排序,3按热门排序
- (void)orderby:(NSInteger)orderby;

//whereStr tagName
- (void)whereStr:(NSString *)whereStr;

@end

@interface VPTicketDropView : UIView

@property(strong, nonatomic)id<VPTicketDropViewDelegate>delegate;

- (void)configLeftData:(NSArray *)leftArray rightData:(NSArray *)rightArray;

@end
