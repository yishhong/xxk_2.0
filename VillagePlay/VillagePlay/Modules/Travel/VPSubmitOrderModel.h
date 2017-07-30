//
//  VPSubmitOrderModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPWeChatModel.h"
#import "CommentDetaileEnum.h"

@interface VPSubmitOrderModel : NSObject

/**
 旅游微信支付

 @param out_trade_no 订单号
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelWeChatPay:(NSString *)out_trade_no channelType:(VPChannelType)channelType success:(void(^)(VPWeChatModel *weChatModel))success failure:(void(^)(NSError * error))failure;

/**
 支付宝支付

 @param outTradeNo 订单号
 @param success 成功回调
 @param failure 失败回调
 */
- (void)travelAlipayOutTradeNo:(NSString *)outTradeNo channelType:(VPChannelType)channelType success:(void(^)(NSString *orderString))success failure:(void(^)(NSError * error))failure;

-(void)payWayModel:(NSArray *)payWayModel;

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


@end
