//
//  VPHotelPayView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelPayView.h"
#import "UIColor+HUE.h"

@implementation VPHotelPayView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setIsReserveRoom:(NSString *)isReserveRoom{

    _isReserveRoom =isReserveRoom;
    if ([self.isReserveRoom isEqualToString:@"Y"]) {
        
        [self.payButton setTitle:@"立即预订" forState:UIControlStateNormal];
        [self.payButton setBackgroundColor:[UIColor VPRedColor]];
    }else{
    
        [self.payButton setTitle:@"不可预订" forState:UIControlStateNormal];
        [self.payButton setBackgroundColor:[UIColor VPDetailColor]];
    }
}

- (IBAction)submitOrderAction:(id)sender {
    if ([self.isReserveRoom isEqualToString:@"Y"]) {
        if ([self.delegate respondsToSelector:@selector(paymentView)]) {
            [self.delegate paymentView];
        }
    }
}

@end
