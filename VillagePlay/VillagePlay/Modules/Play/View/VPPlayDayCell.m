//
//  VPPlayDayCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayDayCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPPlayDetailModel.h"


@implementation VPPlayDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lb_title.text = @"";
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *cellInfo = cellModel.dataSource;
    VPPlayDetailModel* playDetailModel = cellInfo[@"value"];
    
    /*
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
     long number = -3;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [attributedString addAttribute:NSKernAttributeName value:(__bridge id)num range:NSMakeRange(0,1)];
     [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0,1)];
     [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor VPRedColor]} range:NSMakeRange(0,attributedString.length)];
     //    不需要处理最后的文字大小 只需要处理文字间的间距
     [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(attributedString.length-1,1)];
     CFRelease(num);
     return attributedString;
     */
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"DAY/%zd",playDetailModel.currentDay]];
    [attributedStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]} range:NSMakeRange(0,attributedStr.length-1)];
    [attributedStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(attributedStr.length-1,1)];

    self.lb_title.attributedText = attributedStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
