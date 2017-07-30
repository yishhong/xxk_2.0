//
//  VPDateSelectTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#define dtScreenWidth [UIScreen mainScreen].bounds.size.width

#import "VPDateSelectTableViewCell.h"
#import "VPDateSelectCollectionViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPActivityDateModel.h"
#import "UIColor+HUE.h"
#import "UIView+Frame.h"
#import <Masonry.h>
#import "VPDateSelectView.h"
#import "VPTravilSubitInformationModel.h"

@interface VPDateSelectTableViewCell ()<VPDateSelectViewDelegate>

@property(strong, nonatomic)VPDateSelectView *dateSelectView;

@property(strong, nonatomic) NSDictionary * cellInfo;

@end

@implementation VPDateSelectTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dateSelectView = [[VPDateSelectView alloc]init];
        self.dateSelectView.delegate =self;
        [self.contentView addSubview:self.dateSelectView];
        [self.dateSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.contentView.mas_trailing);
            make.leading.mas_equalTo(self.contentView.mas_leading);
            make.top.mas_equalTo(self.contentView.mas_top).offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel = entity;
    self.cellInfo =cellModel.dataSource;
    [self.dateSelectView activeDetailModel:self.cellInfo[@"lstActivityDate"]];
    [self.dateSelectView layoutIfNeeded];
}

#pragma mark -VPDateSelectViewDelegate
- (void)selectViewDateString:(NSString *)dateString tickets:(NSInteger)tickets{

    VPTravilSubitInformationModel * travilSubitInformationModel =self.cellInfo[@"subit"];
    travilSubitInformationModel.joinDate =dateString;

}
@end
