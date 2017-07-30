//
//  NSObject+KVO.h
//  DTUtils
//
//  Created by zhaojh on 20/10/14.
//  Copyright (c) 2014年 zjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBKVOController.h"

@interface NSObject (KVO)

@property (nonatomic, strong) FBKVOController *KVOController;
@property (nonatomic, strong) FBKVOController *KVOControllerNonRetaining;

@end
