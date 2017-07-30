//
//  VPHotelInformationViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelInformationViewModel.h"
#import "NSString+Size.h"

@interface VPHotelInformationViewModel()

@property(strong, nonatomic)NSMutableArray * dataSource;

@end

@implementation VPHotelInformationViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

-(void)hotelInforMationModel:(VPHotelDetailModel *)hotelInforMationModel{
        
        [self.dataSource removeAllObjects];
        //布局
        //房间列表
        XXCellModel * hotelRoomListCellModel = [XXCellModel instantiationWithIdentifier:@"VPHotelRoomListTableViewCell" height:45 dataSource:@"民宿详情" action:nil];
        [self.dataSource addObject:hotelRoomListCellModel];
    
        NSInteger infrastructureHeight =hotelInforMationModel.facilityList.count/5;
        infrastructureHeight += hotelInforMationModel.facilityList.count%5>0?1:0;
        XXCellModel * roomFacilitiesCellModel = [XXCellModel instantiationWithIdentifier:@"VPHotelFacilitiesNameTableViewCell" height:60*infrastructureHeight+60 dataSource:hotelInforMationModel.facilityList action:nil];
        [self.dataSource addObject:roomFacilitiesCellModel];
    
    CGFloat introductionHeight =[hotelInforMationModel.content heightWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:[UIScreen mainScreen].bounds.size.width-28];
    XXCellModel * introductioncitiesCellModel = [XXCellModel instantiationWithIdentifier:@"VPHotelIntroductioncitiesTableViewCell" height:introductionHeight+60 dataSource:hotelInforMationModel.content action:nil];
    [self.dataSource addObject:introductioncitiesCellModel];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    
    return self.dataSource[row];
}

@end
