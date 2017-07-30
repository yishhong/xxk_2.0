//
//  VPWantCommentStarCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPWantCommentStarCell.h"
#import "XHStarRateView.h"
#import "VPPostCommenModel.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "UIColor+HEX.h"
#import <Masonry.h>

@interface VPWantCommentStarCell ()

@property (nonatomic, strong) XHStarRateView * rateCtl;
@property (nonatomic, strong) VPPostCommenModel *postCommenModel;

@end

@implementation VPWantCommentStarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.rateCtl = [[XHStarRateView alloc] initWithFrame:CGRectMake(0,0, 160, 20) finish:^(CGFloat currentScore) {
        NSLog(@"3----  %f",currentScore);
        self.postCommenModel.star = currentScore;
    }];
    
    self.rateCtl.rateStyle = WholeStar;
    [self.starView addSubview:self.rateCtl];
    
    [self.rateCtl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.starView.mas_leading).offset(0);
        make.trailing.mas_equalTo(self.starView.mas_trailing).offset(0);
        make.top.mas_equalTo(self.starView.mas_top).offset(0);
        make.bottom.mas_equalTo(self.starView.mas_bottom).offset(0);
    }];

    
}

//-(AMRatingControl *)rateCtl{
//    
//    if (!_rateCtl) {
//        _rateCtl =[[AMRatingControl alloc] initWithLocation:CGPointMake(0,0) emptyImage:[UIImage imageNamed:@"tab_delete_blue"] solidImage:[UIImage imageNamed:@"tab_delete_blue"] andMaxRating:5];
//        _rateCtl.bounds = CGRectMake(0, 0, 10*20, 20);
//        _rateCtl.backgroundColor = [UIColor colorWithHexString:@"BABABA"];
//        
//        
////        _rateCtl.userInteractionEnabled = NO;
//    }
//    return _rateCtl;
//}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    self.postCommenModel = cellModel.dataSource;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
