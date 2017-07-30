//
//  VPAuthCodeController.h
//  VillagePlay
//
//  Created by Apricot on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBaseViewController.h"


//来自 注册或、修改密码
typedef enum{
    VPAuthCodeType_Register=1,      //注册
    VPAuthCodeType_ModifyPassWord=2, //修改密码
}VPAuthCodeType;

@interface VPAuthCodeController : VPBaseViewController

@property(strong, nonatomic)NSString *telephone;

@property(assign, nonatomic)VPAuthCodeType codeType;

+ (instancetype)instantiation;

@end
