//
//  VPPlayCourseDayCell.m
//  scrollView
//
//  Created by Apricot on 16/11/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayCourseDayCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@interface VPPlayCourseDayCell ()
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation VPPlayCourseDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    NSDictionary *cellInfo = cellModel.dataSource;
    self.lb_title.text = cellInfo[@"title"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
//        35
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.circleImage = [[UIImageView alloc] init];
        
        self.circleImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.circleImage];
        self.circleImage.bounds = CGRectMake(0, 0, 9, 9);
        self.circleImage.layer.cornerRadius = 4.5;
        self.circleImage.layer.masksToBounds = YES;
        self.circleImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.circleImage.layer.borderWidth = 0.5;
        self.circleImage.center = CGPointMake(13+9/2.0, self.contentView.center.y);
        self.backgroundColor = [UIColor clearColor];
        self.lb_title = [[UILabel alloc] init];
        self.lb_title.bounds = CGRectMake(0, 0, 100, 30);
        self.lb_title.text = @"";
        self.lb_title.textColor = [UIColor whiteColor];
//        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        self.lb_title.font = [UIFont systemFontOfSize:14];
        self.lb_title.center = CGPointMake(28+CGRectGetWidth(self.lb_title.frame)/2.0, self.contentView.center.y);
        [self.contentView addSubview:self.lb_title];
        
        self.lineView = [[UIView alloc] init];
        [self.contentView addSubview:self.lineView];
        self.lineView.backgroundColor = [UIColor whiteColor];
        self.lineView.frame = CGRectMake(CGRectGetMidX(self.circleImage.frame)-0.5,CGRectGetMaxY(self.circleImage.frame)+4, 1,CGRectGetHeight(self.contentView.frame)- CGRectGetMaxY(self.circleImage.frame)-4);
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
