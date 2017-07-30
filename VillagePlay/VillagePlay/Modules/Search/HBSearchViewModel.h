//
//  HBSearchViewModel.h
//  HotelBusiness
//
//  Created by Apricot on 16/8/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBSearchCellInfoModel.h"


@interface HBSearchViewModel : NSObject

@property (nonatomic, copy) NSString *searchText;

#pragma mark - API

/**
 *  搜索接口
 *
 *  @param isFirst 是否第一次加载
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
- (void)searchOrderWithFirst:(BOOL)isFirst success:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 *  确认订单
 *
 *  @param orderID 订单号
 *  @param status  状态
 *  @param success 成功回调
 *  @param failure 失败的回调
 */
-(void)confirmPostOrderID:(NSString *)orderID status:(NSString *)status Success:(void(^)())success failure:(void(^)(NSError *error))failure;
/**
 *  办理入住
 *
 *  @param orderID 订单号
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
-(void)liveOrderID:(NSString *)orderID success:(void(^)())success failure:(void(^)(NSError *error))failure;
#pragma mark - Method

/**
 *  是否显示历史搜索记录
 *
 *  @param isShwo 1 显示 0 不显示 -1网络错误
 */
- (void)showSearchRecord:(NSInteger)isShow;

/**
 *  获取空数据显示的文本
 *
 *  @return 返回数据为空时显示的文本的
 */
- (NSString *)fetchNotDataString;

/**
 *  获取数据的条数
 *
 *  @param section 指定section
 *
 *  @return 返回数目条数
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  获取每个cell详细信息
 *
 *  @param index 坐标
 *
 *  @return 返回cell的详情
 */
- (HBSearchCellInfoModel *)cellInfoInRow:(NSInteger )index;

/**
 *  清楚历史搜索记录
 */
- (void)clearSearchRecord;

@end
