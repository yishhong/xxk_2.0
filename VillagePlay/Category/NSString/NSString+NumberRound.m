//
//  NSString+NumberRound.m
//  VillagePlay
//
//  Created by Apricot on 2017/1/9.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "NSString+NumberRound.h"

@implementation NSString (NumberRound)
- (NSString *)numericalConversion{
    NSDecimalNumberHandler * roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSInteger num = [self doubleValue];
    NSInteger countNum = num/10000.0f;

    NSString * numStr = self;
    if(countNum>0){
        double remainder = countNum +(num - countNum*10000)*(1.0/10000.0);
        NSDecimalNumber * decimalNumber = [[NSDecimalNumber alloc] initWithDouble:remainder];
        NSDecimalNumber * roundedOunces = [decimalNumber decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
        numStr = [NSString stringWithFormat:@"%@万",roundedOunces];
    }
    return numStr;
}
@end
