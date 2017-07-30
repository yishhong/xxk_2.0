//
//  VPBedTypeTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBedTypeTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPHotelHeadView.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPHotelRoomListRoomModel.h"

#define dtScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define dtScreenHeight           ([UIScreen mainScreen].bounds.size.height)

@interface VPBedTypeTableViewCell()<VPHotelHeadViewDelegate>
@property(strong, nonatomic) VPHotelHeadView * hotelHeadView;
@end

@implementation VPBedTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.hotelHeadView];
}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPHotelRoomListRoomModel *hotelRoomListRoomModel =cellModel.dataSource;
    [self.hotelHeadView focusImageItemsArray:hotelRoomListRoomModel.imgUrlArray isRight:NO];
}

-(VPHotelHeadView *)hotelHeadView{
    
    if (!_hotelHeadView) {
     
        _hotelHeadView =[[VPHotelHeadView alloc]initWithFrame:CGRectMake(0, 0, dtScreenWidth, 250)];
        _hotelHeadView.delegate =self;
    }
    return _hotelHeadView;
}

- (void)VPHotelHeadViewSelectImage:(NSInteger)selectImage imageList:(NSArray *)imageList{
    
    self.tag=selectImage;
    [self xx_cellClickAtView:self];
}

@end
