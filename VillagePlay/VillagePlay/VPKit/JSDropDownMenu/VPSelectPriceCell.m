//
//  TsetTableViewCell.m
//  JSDropDownMenuDemo
//
//  Created by Apricot on 2016/12/5.
//  Copyright © 2016年 jsfu. All rights reserved.
//

#import "VPSelectPriceCell.h"
#import <BMASliders/BMALabeledRangeSlider.h>
#import <BMASliders/BMALabeledSlider.h>
#import <BMASliders/BMASliderLiveRenderingStyle.h>
#import "BMASliderDefaultStyle.h"
#import "UIColor+HUE.h"

@interface VPSelectPriceCell ()

@property (strong, nonatomic) BMARangeSlider *myRangeSlider;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation VPSelectPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 185)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        self.dataArray = [NSMutableArray array];
        for (int i=0; i<=300;i+=100){
            [self.dataArray addObject:[NSString stringWithFormat:@"￥%d",i]];
        }
        [self.dataArray addObject:@"不限"];
        
        UILabel *lb_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 13)];
        lb_title.text = @"价格区间";
        lb_title.font = [UIFont systemFontOfSize:13];
        lb_title.textColor = [UIColor colorWithRed:159.0/255.0 green:159.0/255.0 blue:159.0/255.0 alpha:1.0];
        [self.contentView addSubview:lb_title];
        
        NSInteger num = [self.dataArray count];
        CGFloat width = CGRectGetWidth(bgView.frame)/num;
        int i =0;
        UILabel *lb_money = nil;
        for (NSString *str in self.dataArray) {
            lb_money = [[UILabel alloc] initWithFrame:CGRectMake(i*width, CGRectGetMaxY(lb_title.frame)+24, width, 13)];
            lb_money.text = str;
            lb_money.textColor = [UIColor navigationTintColor];
            lb_money.font = [UIFont systemFontOfSize:13];
            lb_money.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:lb_money];
            i++;
        }
        self.myRangeSlider = [[BMARangeSlider alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgView.frame)-0, 30)];
        self.myRangeSlider.maximumValue = num-1;
        self.myRangeSlider.minimumValue = 0;
        self.myRangeSlider.minimumDistance = 1;
        self.myRangeSlider.currentUpperValue = num-1;
        self.myRangeSlider.currentLowerValue = 0;
        self.myRangeSlider.style = [[BMASliderDefaultStyle alloc] init];
        self.myRangeSlider.step = 1;
        self.myRangeSlider.frame =CGRectMake(width/2.0-15, CGRectGetMaxY(lb_money.frame)+23, CGRectGetWidth(bgView.frame)-width+30, 27);
        [self.myRangeSlider addTarget:self action:@selector(rangeSliderDidChangeValue1:) forControlEvents:UIControlEventValueChanged];
        [bgView addSubview:self.myRangeSlider];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor navigationTintColor]];
        [bgView addSubview:button];
        button.layer.cornerRadius = 4;
        button.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-110.0)/2.0,CGRectGetMaxY(self.myRangeSlider.frame)+30, 110, 37);
        [button addTarget:self action:@selector(selectPrice) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)selectPrice{
    if([self.delegate respondsToSelector:@selector(startPrice:endPrice:)]){
        double startPrice = [self priceWithIndex:self.myRangeSlider.currentLowerValue];
        double endPrice = [self priceWithIndex:self.myRangeSlider.currentUpperValue];
        
        [self.delegate startPrice:startPrice endPrice:endPrice];
    }
}
- (double)priceWithIndex:(NSInteger)index{
    NSString *priceStr = [self.dataArray objectAtIndex:index];
    if([priceStr hasPrefix:@"￥"]){
        priceStr = [priceStr substringWithRange:NSMakeRange(1, priceStr.length-1)];
        return [priceStr doubleValue];
    }else{
        return 0.0f;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)rangeSliderDidChangeValue1:(BMARangeSlider *)sender{
    NSLog(@"测试:%@-%@",@(sender.currentLowerValue),@(sender.currentUpperValue));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
