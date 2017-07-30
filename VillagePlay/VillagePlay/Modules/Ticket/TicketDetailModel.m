//
//  TicketDetailModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TicketDetailModel.h"
#import "VPTicktDetailAPI.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height

@interface TicketDetailModel ()

@property(strong, nonatomic)NSMutableArray * dataSource;

@property (strong, nonatomic)VPTicktDetailAPI *ticktDetailAPI;

@property (strong, nonatomic)VPTicketDetailModel *ticketDetailModel;

@end

@implementation TicketDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ticktDetailAPI =[[VPTicktDetailAPI alloc]init];
    }
    return self;
}

- (void)ticketDetailPid:(NSString *)pid success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params=@{@"id":pid};
    [self.ticktDetailAPI ticketDetailParams:params success:^(NSDictionary *responseDict) {
        self.ticketDetailModel =[VPTicketDetailModel yy_modelWithJSON:responseDict[@"body"]];
        //布局
        //门票详情地址
        NSDictionary * ticketAddressInfo =@{@"image":@"tab_ticket_location",
                                            @"name":self.ticketDetailModel.ticket};
        NSDictionary * ticketOpenDateInfo =@{@"image":@"tab_ticket_time",
                                            @"name":self.ticketDetailModel.ticket};
        XXCellModel * ticketAddressCellModel =[XXCellModel instantiationWithIdentifier:@"VPTicketAddressTableViewCell" height:45 dataSource:ticketAddressInfo action:nil];
        [self.dataSource addObject:ticketAddressCellModel];
        
        //门票详情开放时间
        XXCellModel * ticketOpenDateCellModel =[XXCellModel instantiationWithIdentifier:@"VPTicketOpenDateTableViewCell" height:45 dataSource:ticketOpenDateInfo action:nil];
        [self.dataSource addObject:ticketOpenDateCellModel];
        
        //空行
        XXCellModel * lineCellModel =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        
        XXCellModel * travelDetailSlideCellModel =[XXCellModel instantiationWithIdentifier:@"VPTravelDetailSlideTableViewCell" height:Main_Screen_Height-(64) dataSource:nil action:nil];
        [self.dataSource addObject:travelDetailSlideCellModel];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)ticketModel:(NSArray *)ticketModel{



}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{

    return self.dataSource[row];
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (VPTicketDetailModel *)detailModel{

    return self.ticketDetailModel;
}

@end
