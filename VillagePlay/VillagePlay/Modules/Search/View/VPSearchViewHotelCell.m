//
//  VPSearchViewHotelCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchViewHotelCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPSearchModel.h"
#import "UIImageView+VPWebImage.h"
#import "NSMutableAttributedString+AttributedString.h"
#import <Masonry.h>
#import "AMRatingControl.h"
#import "XHStarRateView.h"


@interface VPSearchViewHotelCell ()
//@property (nonatomic, strong) AMRatingControl * ratingControl;
@property (nonatomic, strong) XHStarRateView * rateCtl;

@end

@implementation VPSearchViewHotelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lb_name.text = @"";
    self.lb_comment.text = @"";
    self.lb_price.text = @"";
    
//   self.ratingControl = [[AMRatingControl alloc]initWithLocation:CGPointMake(0, 0) emptyImage:[UIImage imageNamed:@"tab_white_star_nor"] solidImage:[UIImage imageNamed:@"tab_white_star_sel"] andMaxRating:5];
//    self.rateView.backgroundColor = [UIColor whiteColor];
//    self.ratingControl.frame = CGRectMake(0, 0, 5*20, 23);
//    [self.rateView addSubview:self.ratingControl];
    
//    self.rateCtl = [[XHStarRateView alloc] initWithFrame:CGRectMake(0,0, 5*18, 18) finish:^(CGFloat currentScore) {
//        NSLog(@"3----  %f",currentScore);
////        self.postCommenModel.star = currentScore;
//    }];
     self.rateCtl = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 5*15, 15) finish:^(CGFloat currentScore) {
         
     }];
    self.rateCtl.userInteractionEnabled = NO;
//    self.rateCtl = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 5*20, 20) numberOfStars:5 rateStyle:WholeStar isAnination:YES finish:^(CGFloat currentScore) {
//        
//    }];
    self.rateCtl.currentScore = 0;

//    self.rateCtl.rateStyle = WholeStar;
    [self.rateView addSubview:self.rateCtl];
    
    
//    [self.rateCtl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.lb_comment.mas_centerY).offset(0);
//        make.leading.mas_equalTo(self.lb_name.mas_leading).offset(0);
////        make.leading.mas_equalTo(self.rateView.mas_leading).offset(0);
////        make.trailing.mas_equalTo(self.rateView.mas_trailing).offset(0);
////        make.top.mas_equalTo(self.rateView.mas_top).offset(0);
////        make.bottom.mas_equalTo(self.rateView.mas_bottom).offset(0);
//    }];
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    VPSearchModel *searchModel = cellModel.dataSource;
    self.lb_name.text = searchModel.title;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    attributedString = [attributedString attributedString:[NSString stringWithFormat:@"￥%@起",searchModel.price]];
    self.lb_price.attributedText =attributedString;
    [self.hotelPicture xx_setImageWithURLStr:searchModel.img placeholder:[UIImage imageNamed:@""]];
    
    self.lb_comment.text = [NSString stringWithFormat:@"%zd条评论",searchModel.count];
    
    CGFloat count = 0;
    if(searchModel.allStar == 0){
        count = 0;
    }else{
        if(searchModel.count == 0){
            count = 0;
        }else{
            count = [@(searchModel.allStar) doubleValue]/[@(searchModel.count) doubleValue];
        }
    }
    self.rateCtl.currentScore = count;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
