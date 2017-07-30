//
//  VPWeChatModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseModel.h"

@interface VPWeChatModel : VPBaseModel

//appid
@property(nonatomic,strong)NSString * appid;

//商户id
@property(nonatomic,strong)NSString *partnerid;

//
@property(nonatomic,strong)NSString *noncestr;

//
@property(nonatomic,strong)NSString *prepayid;

//
@property(nonatomic,strong)NSString *result_code;

//
@property(nonatomic,strong)NSString *return_code;

//
@property(nonatomic,strong)NSString *return_msg;

//
@property(nonatomic,strong)NSString *sign;

//
@property(nonatomic,strong)NSString *trade_type;

@property(nonatomic,assign)NSString * timestamp;

@property(nonatomic,strong)NSString *package;

@end
