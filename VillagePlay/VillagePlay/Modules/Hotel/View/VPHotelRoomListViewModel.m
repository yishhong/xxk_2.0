//
//  VPHotelRoomListViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelRoomListViewModel.h"
#import "VPHotelDetailAPI.h"
#import "YYModel.h"
#import "NSString+Size.h"

#define W [UIScreen mainScreen].bounds.size.width

@interface VPHotelRoomListViewModel ()

@property (strong, nonatomic)NSMutableArray *dataSource;

@property (strong, nonatomic)VPHotelDetailAPI *hotelDetailAPI;

@property (strong, nonatomic)VPHotelRoomListRoomModel *roomListRoomModel;

@end

@implementation VPHotelRoomListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.hotelDetailAPI =[[VPHotelDetailAPI alloc]init];
    }
    return self;
}

-(void)hotelRoomListModel:(VPHotelRoomListRoomModel *)hotelRoomListRoomModel{
    
    [self.dataSource removeAllObjects];
    //布局
    self.roomListRoomModel =hotelRoomListRoomModel;
    //房间列表
//    XXCellModel * hotelRoomListCellModel = [XXCellModel instantiationWithIdentifier:@"VPHotelRoomListTableViewCell" height:44 dataSource:hotelRoomListRoomModel.name action:nil];
//    [self.dataSource addObject:hotelRoomListCellModel];

    XXCellModel * bedTypeCellModel = [XXCellModel instantiationWithIdentifier:@"VPBedTypeTableViewCell" height:250 dataSource:hotelRoomListRoomModel action:nil];
        [self.dataSource addObject:bedTypeCellModel];
    
    NSInteger infrastructureHeight =hotelRoomListRoomModel.infrastructure.count/4;
    infrastructureHeight += hotelRoomListRoomModel.infrastructure.count%4>0?1:0;
    XXCellModel * roomFacilitiesNameCellModel = [XXCellModel instantiationWithIdentifier:@"VPRoomFacilitiesTableViewCell" height:70*infrastructureHeight+34 dataSource:hotelRoomListRoomModel.infrastructure action:nil];
    [self.dataSource addObject:roomFacilitiesNameCellModel];

    //空行
    XXCellModel * lineCellModel =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
    [self.dataSource addObject:lineCellModel];
    
    XXCellModel * roomDescriptionCellModel = [XXCellModel instantiationWithIdentifier:@"VPRoomDescriptionTableViewCell" height:131 dataSource:hotelRoomListRoomModel action:nil];
    [self.dataSource addObject:roomDescriptionCellModel];
    
    //空行
    XXCellModel * lineCellModel1 =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
    [self.dataSource addObject:lineCellModel1];

}

-(void)hotelRuleType:(NSString *)type success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params =@{@"type":type};
    [self.hotelDetailAPI hotelRuleParams:params success:^(NSDictionary *responseDict) {
        NSString * ruleString =responseDict[@"body"];
        CGFloat ruleHeight =[ruleString heightWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:W-24];
        ruleHeight =ruleHeight+28;
        XXCellModel * hotelRemoveCellModel = [XXCellModel instantiationWithIdentifier:@"VPHotelRemoveTableViewCell" height:ruleHeight dataSource:ruleString action:nil];
        [self.dataSource addObject:hotelRemoveCellModel];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    return self.dataSource[row];
}

@end
