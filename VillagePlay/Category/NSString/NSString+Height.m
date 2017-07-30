//
//  NSString+Height.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "NSString+Height.h"

@implementation NSString (Height)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}
@end
