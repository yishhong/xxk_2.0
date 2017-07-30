//
//  VPPlayCourseStrategyCell.m
//  scrollView
//
//  Created by Apricot on 16/11/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayCourseStrategyCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@interface VPPlayCourseStrategyCell ()
@property (nonatomic, strong) UIImageView * circleImage;
@property (nonatomic, strong) UIView * bottomLineView;
@property (nonatomic, strong) UIView * topLineView;
@end

@implementation VPPlayCourseStrategyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.circleImage = [[UIImageView alloc] init];
        self.circleImage.layer.cornerRadius = 2.5;
        self.circleImage.layer.borderWidth = 0.5;
        self.circleImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.circleImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.circleImage];
        self.circleImage.bounds = CGRectMake(0, 0, 5, 5);
        self.circleImage.center = CGPointMake(13+9/2.0, self.contentView.center.y);
        self.backgroundColor = [UIColor clearColor];
        self.lb_title = [[UILabel alloc] init];
        self.lb_title.bounds = CGRectMake(0, 0, 150, 30);
        self.lb_title.text = @"";
        self.lb_title.textColor = [UIColor whiteColor];
        //        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        self.lb_title.font = [UIFont systemFontOfSize:14];
        self.lb_title.center = CGPointMake(28+CGRectGetWidth(self.lb_title.frame)/2.0, self.contentView.center.y);
        [self.contentView addSubview:self.lb_title];
        
        self.topLineView = [[UIView alloc] init];
        [self.contentView addSubview:self.topLineView];
        self.topLineView.backgroundColor = [UIColor whiteColor];
        self.topLineView.frame = CGRectMake(CGRectGetMidX(self.circleImage.frame)-0.5,0, 1,CGRectGetMinY(self.circleImage.frame)-4);

        self.bottomLineView = [[UIView alloc] init];
        [self.contentView addSubview:self.bottomLineView];
        self.bottomLineView.backgroundColor = self.topLineView.backgroundColor;
        
        self.bottomLineView.frame = CGRectMake(CGRectGetMidX(self.circleImage.frame)-0.5,CGRectGetMaxY(self.circleImage.frame)+4, 1,CGRectGetHeight(self.contentView.frame)- CGRectGetMaxY(self.circleImage.frame)-4);
    }
    return self;
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    if(cellModel.location ==CellLocationEnd){
        self.bottomLineView.hidden = YES;
    }else{
        self.bottomLineView.hidden = NO;
    }
    NSDictionary *cellInfo = cellModel.dataSource;
    self.lb_title.text = cellInfo[@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
