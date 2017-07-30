//
//  QMImageViewCell.m
//  scrollView
//
//  Created by Apricot on 16/11/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMImageViewCell.h"
#import "UICollectionViewCell+DataSource.h"
#import "VPHotelListModel.h"
#import <Masonry.h>
#import "UIImageView+VPWebImage.h"
#import "NSMutableAttributedString+AttributedString.h"

@interface QMImageViewCell ()

/**
 *
 */
@property (nonatomic, strong) UIImageView *photoImage;

/**
 *  主标题
 */
@property (nonatomic, strong) UILabel *lb_title;

/**
 *  副标题
 */
@property (nonatomic, strong) UILabel *lb_subTitle;

@end

@implementation QMImageViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self layoutUI];
}

- (void)layoutUI{

    self.photoImage = [[UIImageView alloc] init];
    self.photoImage.contentMode = UIViewContentModeScaleAspectFill;
    self.photoImage.layer.masksToBounds = YES;
    [self addSubview:self.photoImage];
    
    self.lb_title = [[UILabel alloc] init];
    self.lb_title.textAlignment = NSTextAlignmentCenter;
    self.lb_title.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.lb_title];
    
    self.lb_subTitle = [[UILabel alloc] init];
    self.lb_subTitle.textAlignment = NSTextAlignmentCenter;
    self.lb_subTitle.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.lb_subTitle];
    
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-90);
    }];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(15);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-15);
        make.top.mas_equalTo(self.photoImage.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.lb_subTitle.mas_top).offset(0);
    }];
    
    [self.lb_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.lb_title.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.lb_title.mas_trailing).offset(0);
        make.top.mas_equalTo(self.lb_title.mas_bottom).offset(0);
        make.height.mas_equalTo(self.lb_title.mas_height).multipliedBy(1.2);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-30);
    }];
}

- (void)xx_configCellWithEntity:(id)entity{
//    self.lb_title.text = entity;
    
    VPHotelListModel *hotelListModel = entity;
    [self.photoImage xx_setImageWithURLStr:hotelListModel.imgUrl placeholder:[UIImage imageNamed:@""]];
    self.lb_title.text = hotelListModel.name;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    attributedString = [attributedString attributedString:[NSString stringWithFormat:@"￥%0.2f起",hotelListModel.price]];
    self.lb_subTitle.attributedText = attributedString;
}

@end
