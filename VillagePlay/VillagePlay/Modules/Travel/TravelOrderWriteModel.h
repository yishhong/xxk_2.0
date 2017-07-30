//
//  TravelOrderWriteModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPActiveDetailModel.h"
#import "CommentDetaileEnum.h"
#import "VPOrderCouponModel.h"

@interface TravelOrderWriteModel : NSObject

-(void)travelModel:(VPActiveDetailModel *)travelModel;

/**
 活动报名信息提交

 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)travelWriteOrderSuccess:(void(^)(NSString * orderNum))success failure:(void(^)(NSError * error))failure;


/**
 优惠券

 @param travelCouponPrice 旅游价格
 @param type 频道 VPChannelType
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelCoupontype:(VPChannelType)type price:(float)price success:(void(^)(NSArray *travelCouponArray))success failure:(void(^)(NSError * error))failure;

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

- (XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

/**
 修改总价

 @param totalRealPrice 总价
 @param lstGoods 商品订单
 @param totalNumber 购买数量
 @param actualPayment 优惠后的价格
 */
- (void)totalRealPrice:(double)totalRealPrice lstGoods:(NSArray *)lstGoods totalNumber:(NSInteger)totalNumber actualPayment:(double)actualPayment;

/**
 优惠券价格

 @param actualPayment 优惠
 @param conponCode <#conponCode description#>
 */
- (void)totalRealPrice:(double)totalRealPrice actualPayment:(double)actualPayment conponCode:(NSString *)conponCode;


/**
 选择票
 
 @param roomnum 房间数量
 */
- (void)selectTicketNum:(NSInteger)roomnum;

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
