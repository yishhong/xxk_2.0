//
//  VPCouponCell.m
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCouponCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPCouponModel.h"
#import "CommentDetaileEnum.h"
#import "NSMutableAttributedString+AttributedString.h"
#import "UIColor+HEX.h"
@implementation VPCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPCouponModel *couponModel = cellModel.dataSource;
    self.lb_title.text = couponModel.title;
    
    self.desc.text = couponModel.desc;
    
    self.lb_date.text = [NSString stringWithFormat:@"有效期：%@ — %@",couponModel.startTime,couponModel.closingTime];
//    couponModel.discountMoney = 10.92;
    
    if(couponModel.discountMoney !=0){
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",@(couponModel.discountMoney)]];
        long number = -10;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        [attributedString addAttribute:NSKernAttributeName value:(__bridge id)num range:NSMakeRange(0,1)];
        //    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0,1)];
        CFRelease(num);
        //    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
        //    attributedString=[attributedString attributedString:];
        self.lb_money.attributedText =attributedString;
    }else{
        self.lb_money.text = @"";
    }

    
    
    /*
     通用：#49c6d8
     旅游：#ffa15b
     门票：#66a9fc
     民宿：#f95869
     */
    switch (couponModel.xx_couponState) {
        case CouponUseStateOverdue://已过期
        case CouponUseStateUse:{//已使用
            self.bgView.backgroundColor = [UIColor colorWithRed:196.0/255.0 green:196.0/255.0 blue:196.0/255.0 alpha:1.0];
        }break;
        case CouponUseStateUnuse:{//未使用
            switch (couponModel.scopeId) {
                case VPChannelTypeTravel:{
                    self.bgView.backgroundColor = [UIColor colorWithHexString:@"ffa15b"];
                }break;
                case VPChannelTypeHotel:{
                    self.bgView.backgroundColor = [UIColor colorWithHexString:@"f95869"];
                }break;
                case VPChannelTypeTicket:{
                    self.bgView.backgroundColor = [UIColor colorWithHexString:@"66a9fc"];
                }break;
                case 0:{
                    self.bgView.backgroundColor = [UIColor colorWithHexString:@"49c6d8"];
                }break;
                default:{
                }break;
            }
        }break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
