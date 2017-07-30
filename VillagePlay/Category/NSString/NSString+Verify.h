//
//  NSString+Verify.h
//  mgjr
//
//  Created by Apricot on 15/9/25.
//  Copyright © 2015年 wghl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)
/**
 *  校验是否是手机号码
 *
 *  @return 返回 YES  NO 
 */
- (BOOL)verifyPhone;

/**
 *  判断字符串是否是为空或者空格
 *
 *  @return 返回YES NO
 */
- (BOOL)verifyEmpty;
@end
