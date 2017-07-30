//
//  HotelSubmitOrderModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPHotelDetailAPI.h"
#import "VPHotelRoomListRoomModel.h"
#import "CommentDetaileEnum.h"
#import "VPOrderCouponModel.h"

@interface HotelSubmitOrderModel : NSObject

/**
 房间信息提交价格更新

 @param roomId 房间ID
 @param beginTime 开始时间
 @param endTime 结束时间
 */
- (void)hotelSubmitRoomId:(NSString *)roomId beginTime:(NSString *)beginTime endTime:(NSString *)endTime submitInfo:(NSDictionary *)submitInfo success:(void(^)(NSString *price))success failure:(void(^)(NSError * error))failure;

/**
 优惠券
 
 @param travelCouponPrice 旅游价格
 @param type 频道 VPChannelType
 @param success 成功回调
 @param failure 失败回调
 */
- (void)tiketCoupontype:(VPChannelType)type price:(float)price success:(void(^)(NSArray *travelCouponArray))success failure:(void(^)(NSError * error))failure;

/**
 民宿信息提交

 @param success 成功回调
 @param failure 失败回调
 */
- (void)hotelSubmitOrderSuccess:(void(^)(NSString *orderID))success failure:(void(^)(NSError * error))failure;

/**
 *  返回Cell行数
 *
 *  @param section <#section description#>
 *
 *  @return <#return value description#>
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  获取cell的详细信息
 *
 *  @param row     row坐标
 *  @param section section坐标
 *
 *  @return 返回指定的cell的详细信息
 */

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;


/**
 房间数量

 @return <#return value description#>
 */
- (NSArray *)hotelRoomNumber;

/**
 选中房间数

 @param selectRoomNumber 房间数
 */
- (void)updateSelectRoomNumber:(NSString *)selectRoomNumber payMoney:(float)payMoney;

/**
 优惠劵

 @param totalRealPrice 总价
 @param actualPayment 实付款
 @param conponCode 优惠券号
 @param discount 优惠金额
 */
- (void)totalRealPrice:(CGFloat)totalRealPrice actualPayment:(CGFloat)actualPayment conponCode:(NSString *)conponCode discount:(double)discount;


/**
 设置房间数量

 @param roomnum 房间数量
 */
- (void)selectRoomNum:(NSInteger)roomnum;

/**
 选择优惠券

 @param orderCouponModel 优惠券
 */
- (void)selectConpon:(VPOrderCouponModel *)orderCouponModel;

/**
 优惠的金额

 @return 返回优惠的金额
 */
- (double)preferentialAmount;

/**
 支付金额

 @return 返回支付的金额
 */
- (double)paymentAmount;


@end
