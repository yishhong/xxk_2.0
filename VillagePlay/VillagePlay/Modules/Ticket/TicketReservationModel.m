//
//  TicketReservationModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TicketReservationModel.h"
#import "NSString+Size.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height


@interface TicketReservationModel ()

@property(strong, nonatomic)NSMutableArray * dataSource;

@end

@implementation TicketReservationModel

-(void)ticketReservationModel:(VPTicketDetailModel *)ticketReservationModel{
    //布局
    //门票预订
    for (int i=0; i<ticketReservationModel.ticketGoods.count; i++) {
    
        VPActivityGoodsModel *activityGoodsModel =ticketReservationModel.ticketGoods[i];
        XXCellModel *ticketReservationCellModel =[XXCellModel instantiationWithIdentifier:@"VPTicketReservationTableViewCell" height:91 dataSource:activityGoodsModel action:nil];
        [self.dataSource addObject:ticketReservationCellModel];
    }
    //订票须知文字
    XXCellModel *sectionCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:@{@"title":@"订票须知"} action:nil];
    [self.dataSource addObject:sectionCellModel];
    
    VPTicketListModel *ticketListModel =ticketReservationModel.ticket;
    //门票详情开放时间
    NSDictionary *webInfo =@{@"urlString":ticketListModel.contentsText,
                             @"ishidContentsText":@""};
    XXCellModel *tiketDescribeCellModel =[XXCellModel instantiationWithIdentifier:@"VPWebTableViewCell" height:300 dataSource:webInfo action:nil];
    [self.dataSource addObject:tiketDescribeCellModel];
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

@end
