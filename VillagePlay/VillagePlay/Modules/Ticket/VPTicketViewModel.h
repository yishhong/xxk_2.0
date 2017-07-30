//
//  VPTicketViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPLocationManager.h"

@interface VPTicketViewModel : NSObject

@property (assign, nonatomic) LocationCoordinateType locationType;

/**
 顶部Tag
 
 @param success <#success description#>
 @param failure <#failure description#>
 */
-(void)TikicketWhereStrSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;
/**
 获取菜单选项

 @param isLeft 是否左边 左边为YES 右边为NO
 @return  返回对应的Data数据
 */
- (NSArray *)dropMenuWithLeft:(BOOL)isLeft;

/**
 民宿列表

 @param cityId 城市ID
 @param isFirstLoading 刷新或者加载
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketIsFirstLoading:(BOOL)isFirstLoading success:(void(^)(BOOL isMore))success failure:(void(^)(NSError * error))failure;


/**
 返回节

 @param section 节
 @return <#return value description#>
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;


/**
 每一节多少行

 @param row 行
 @param section <#section description#>
 @return <#return value description#>
 */
-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

//orderby 0默认排序，1按价格排序，2.按推荐排序,3按热门排序
- (void)orderby:(NSInteger)orderby;

//whereStr tagName
- (void)whereStr:(NSString *)whereStr;

@end
