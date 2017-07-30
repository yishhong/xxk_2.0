//
//  HotelDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HotelDetailModel.h"
#import "XXCellModel.h"
#import "VPHotelDetailAPI.h"
#import "VPHotelDetailModel.h"
#import "YYModel.h"
#import "VPHotelRoomListRoomModel.h"
#import "VPLocationManager.h"
#import <UIKit/UIKit.h>
#import "VPCommendAPI.h"
#import "VPCommentaryModel.h"
#import "YYModel.h"
#import "NSString+Size.h"

@interface HotelDetailModel ()

@property (strong, nonatomic) VPHotelDetailAPI *hotelDetailAPI;

@property (strong, nonatomic) NSMutableArray * dataSource;

@property (strong, nonatomic) VPHotelDetailModel * hotelDetailModel;

@property (strong, nonatomic) VPCommendAPI * commendAPI;

@property (strong, nonatomic) NSMutableDictionary *dateInfo;


@property (assign, nonatomic) NSInteger commendIndex;

@end

@implementation HotelDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dateInfo =[[NSMutableDictionary alloc]init];
        self.hotelDetailAPI =[[VPHotelDetailAPI alloc]init];
        self.commendAPI =[[VPCommendAPI alloc]init];
    }
    return self;
}

- (void)hotelDetailHid:(NSString *)hid infoDate:(NSMutableDictionary *)infoDate success:(void (^)())success failure:(void (^)(NSError *))failure{

    self.dateInfo =infoDate;
    NSDictionary * params=@{@"hid":hid};
    [self.hotelDetailAPI hotelDetailParams:params success:^(NSDictionary *responseDict) {
       self.hotelDetailModel =[VPHotelDetailModel yy_modelWithJSON:responseDict[@"body"]];
        //布局
        //酒店名及评论数
        XXCellModel * hotelNameCellModel =[XXCellModel instantiationWithIdentifier:@"VPHotelNameTableViewCell" height:81 dataSource:self.hotelDetailModel action:nil];
        [self.dataSource addObject:hotelNameCellModel];
        
        //空行
        XXCellModel * lineCellModel =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        
        //地址
        NSDictionary *addressInfo =@{@"location":self.hotelDetailModel.address,
                                     @"hide":@""};
        XXCellModel * addressCellModel =[XXCellModel instantiationWithIdentifier:@"VPAddressTableViewCell" height:42 dataSource:addressInfo action:nil];
        [self.dataSource addObject:addressCellModel];

        //地址图片
        NSString * location =[NSString stringWithFormat:@"%f,%f",self.hotelDetailModel.lat,self.hotelDetailModel.lon];
        XXCellModel * addressImageCellModel =[XXCellModel instantiationWithIdentifier:@"VPAddressImageTableViewCell" height:112 dataSource:location action:nil];
        [self.dataSource addObject:addressImageCellModel];
        
        //入住与离店时间
        XXCellModel * addressDateCellModel =[XXCellModel instantiationWithIdentifier:@"VPAddressDateTableViewCell" height:46 dataSource:self.dateInfo action:nil];
        [self.dataSource addObject:addressDateCellModel];
        
        //设备
        XXCellModel * facilitiesCellModel =[XXCellModel instantiationWithIdentifier:@"VPFacilitiesTableViewCell" height:70 dataSource:self.hotelDetailModel.facilityList action:nil];
        [self.dataSource addObject:facilitiesCellModel];
        
        //空行
        XXCellModel * lineCellModel1 =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel1];
        
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)hotelRoomListHotelID:(NSString *)hotelID beginTime:(NSString *)beginTime endTime:(NSString *)endTime type:(NSString *)type success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary * params =@{@"hotelID":hotelID,
                             @"beginTime":beginTime?:@"",
                             @"endTime":endTime?:@"",
                             @"type":type,
                             @"pageIndex":@"",
                             @"pageSize":@"",};
    [self.hotelDetailAPI hotelRoomListParams:params success:^(NSDictionary *responseDict) {
        //酒店预订
        NSArray * hotelRoomArray =[NSArray yy_modelArrayWithClass:[VPHotelRoomListRoomModel class] json:responseDict[@"body"]];
        for (int i=0; i<hotelRoomArray.count; i++) {
            
            VPHotelRoomListRoomModel * hotelRoomListRoom =hotelRoomArray[i];
            XXCellModel * hotelReservationsCellModel =[XXCellModel instantiationWithIdentifier:@"VPHotelReservationsTableViewCell" height:83 dataSource:hotelRoomListRoom action:nil];
            [self.dataSource addObject:hotelReservationsCellModel];
        }
        if (hotelRoomArray.count>0) {
            //空行
            XXCellModel * lineCellModel3 =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
            [self.dataSource addObject:lineCellModel3];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelCommentListVillageID:(NSString *)VillageID commendType:(VPChannelType)commendType success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary * params =@{@"VillageID":VillageID,
                             @"commendType":@(commendType),
                             @"pageNum":@"",
                             @"pageSize":@"5"};
    if(self.commendIndex==0){
        self.commendIndex = [self.dataSource count];
    }
    [self.commendAPI loadCommendListWithParams:params success:^(NSDictionary *responseDict) {
        if([self.dataSource count]>self.commendIndex){
            [self.dataSource removeObjectsInRange:NSMakeRange(self.commendIndex-1, [self.dataSource count]-self.commendIndex+1)];
        }
        
        NSArray * commentArray =[NSArray yy_modelArrayWithClass:[VPCommentaryModel class] json:responseDict[@"body"]];
        //我要评论
        XXCellModel * moreCommentCellModel3 =[XXCellModel instantiationWithIdentifier:@"VPMoreCommentTableViewCell" height:40 dataSource:nil action:nil];
        [self.dataSource addObject:moreCommentCellModel3];
        if (commentArray.count>0) {
            for (VPCommentaryModel *commentaryModel in commentArray) {
                //评论列表
                if (commentaryModel) {
                    XXCellModel * commentCellModel =[XXCellModel instantiationWithIdentifier:@"VPCommentTableViewCell" height:70 dataSource:commentaryModel action:nil];
                    [self.dataSource addObject:commentCellModel];
                }
                if (commentaryModel.content.length>0) {
                    CGFloat conentHeight =[commentaryModel.content heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:[UIScreen mainScreen].bounds.size.width-(62+16)];
                    XXCellModel * commentContentCellModel =[XXCellModel instantiationWithIdentifier:@"VPCommentContentTableViewCell" height:conentHeight+16 dataSource:@{@"isLineHide":@"",
                                                                                                                                                                         @"commentModel":commentaryModel?:@"" }action:nil];
                    [self.dataSource addObject:commentContentCellModel];
                }
                if (commentaryModel.imgs.count>0) {
                    
                    XXCellModel * commentContentImageCellModel =[XXCellModel instantiationWithIdentifier:@"VPCommentContentImageViewTableViewCell" height:85 dataSource:commentaryModel action:nil];
                    [self.dataSource addObject:commentContentImageCellModel];
                }
                XXCellModel * commentLineCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentLineTableViewCell" height:1 dataSource:nil action:nil];
                [self.dataSource addObject:commentLineCellModel];
            }
            XXCellModel * lookMoreCommentCellModel =[XXCellModel instantiationWithIdentifier:@"VillageLookMoreCommentTableViewCell" height:40 dataSource:nil action:nil];
            [self.dataSource addObject:lookMoreCommentCellModel];
        }else{
            XXCellModel * commentNoDataCellModel =[XXCellModel instantiationWithIdentifier:@"VPHotelCommentNoDataTableViewCell" height:164 dataSource:nil action:nil];
            [self.dataSource addObject:commentNoDataCellModel];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}



-(NSArray *)headImageArray{

    return self.hotelDetailModel.imgList;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{

    return self.dataSource[row];
}

- (VPHotelDetailModel *)hotelModel{

    return self.hotelDetailModel;
}

#pragma mare -setter or gettet
-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
