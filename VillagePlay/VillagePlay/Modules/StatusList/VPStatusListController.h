//
//  VPStatusListController.hController
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"
#import "CommentDetaileEnum.h"
@interface VPStatusListController : VPBaseViewController

+ (instancetype)instantiation;

@property (nonatomic, assign) VPChannelType channelType;

/**
 *  订单状态
 */
@property (strong, nonatomic)NSString * orderState;

/**
 *  订单号
 */
@property (strong, nonatomic) NSString * orderNum;



/*
 旅游的信息
 退款的信息
 */

/*
 门票订单状态
 订单状态cell
 提交订单(时间)
 支付订单
 交易完成
 */
/*
 门票退款状态
 ->退款单号 退款金额 退款状态
 提交成功（时间加描述）
 退款审核
 操作退款
 退款成功
 */
/*
 旅游退款状态
 订单号ce;;
 订单的昵称以及使用时间cell
 提交成功（描述）
 退款审核
 操作退款
 退款成功
 */
/*
 民宿
 民宿订单状态
 订单状态cell
 提交订单(时间)
 支付订单
 交易完成
 *
 /
 /*
 民宿退款状态
 ->退款单号 退款金额 退款状态
 提交成功（时间加描述）
 退款审核
 操作退款
 退款成功
 */

@end
