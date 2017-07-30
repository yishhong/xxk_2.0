//
//  TiketOrderWriteModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPTicketDetailModel.h"
#import "CommentDetaileEnum.h"

@interface TiketOrderWriteModel : NSObject

@property (strong, nonatomic) NSMutableDictionary *dayDict;


-(void)tiketOrderWriteModel:(VPTicketDetailModel *)tiketOrderWriteModel;

/**
 优惠券
 
 @param travelCouponPrice 旅游价格
 @param type 频道 VPChannelType
 @param success 成功回调
 @param failure 失败回调
 */
- (void)tiketCoupontype:(VPChannelType)type price:(float)price success:(void(^)(NSArray *travelCouponArray))success failure:(void(^)(NSError * error))failure;

/**
 门票信息提交

 @param success 成功回调
 @param failure 失败回调
 */
- (void)tiketOrderWriteSubitSuccess:(void(^)(NSString *orderNum))success failure:(void(^)(NSError * error))failure;

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
 修改总价
 
 @param totalRealPrice 总价
 @param lstGoods 商品订单
 @param totalNumber 购买总数
 */

/**
 修改总价

 @param totalRealPrice 总价
 @param lstGoods 商品订单
 @param totalNumber 购买数量
 @param actualPayment 优惠后的价格
 @param discount 优惠金额
 */
- (void)totalRealPrice:(double)totalRealPrice lstGoods:(NSArray *)lstGoods totalNumber:(NSInteger)totalNumber actualPayment:(double)actualPayment discount:(double)discount;
/**
 优惠券价格
 
 @param actualPayment 优惠
 @param conponCode 优惠劵码
 @param discount 优惠金额
 */
- (void)totalRealPrice:(double)totalRealPrice actualPayment:(double)actualPayment conponCode:(NSString *)conponCode discount:(double)discount;

/**
 添加门票

 @param activityGoodsModel <#activityGoodsModel description#>
 */
- (void)addTiketDate:(VPActivityGoodsModel *)activityGoodsModel indexPath:(NSIndexPath *)indexPath;

/**
 删除门票

 @param activityGoodsModel <#activityGoodsModel description#>
 */
- (void)deleteTietDate:(VPActivityGoodsModel *)activityGoodsModel indexPath:(NSIndexPath *)indexPath;

@end
