//
//  VPStatusListViewModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPStatusListViewModel.h"
#import "VPHotelOrderAPI.h"
#import "VPHotelRefundDetailModel.h"
#import "YYModel.h"
#import "VPTiketRefundDetailModel.h"
#import "VPTravelRefundDetailModel.h"

@interface VPStatusListViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPHotelOrderAPI *hotelOrderAPI;

@end

@implementation VPStatusListViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.hotelOrderAPI =[[VPHotelOrderAPI alloc]init];
    }
    return self;
}

-(void)hotelOrderState:(NSString *)orderid success:(void (^)())success failure:(void (^)(NSError *))failure{
    NSDictionary *params=@{@"orderid":orderid};
    [self.hotelOrderAPI hotelOrderStateParams:params success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)hotelRefundDetailOrder:(NSString *)orderid success:(void (^)())success failure:(void (^)(NSError *))failure{
    NSDictionary *params=@{@"orderid":orderid};
    [self.hotelOrderAPI hotelRefundDetailParams:params success:^(NSDictionary *responseDict) {
        VPHotelRefundDetailModel *hotelRefundDetailModel =[VPHotelRefundDetailModel yy_modelWithJSON:responseDict[@"body"]];

        //计算时间
        NSString * operateDate =[self applyDate:hotelRefundDetailModel.createTime];;
        //空行
        XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPRefundBlankLinesTableViewCell" height:0 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        
        NSDictionary *refundStatusInfo =@{@"price":[NSString stringWithFormat:@"%.2f",hotelRefundDetailModel.returnMoney],
                                          @"state":[self hotelRefundStatus:hotelRefundDetailModel.status],
                                          @"orderID":@(hotelRefundDetailModel.orderId)};
        XXCellModel * infoStatusCellModel =[XXCellModel instantiationWithIdentifier:@"VPRefundStatusCell" height:0 dataSource:refundStatusInfo action:nil];
        [self.dataSource addObject:infoStatusCellModel];
        
        XXCellModel * detailStatusCellModel =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":hotelRefundDetailModel.finishTime.length>0?hotelRefundDetailModel.finishTime:@"",
                         @"title":@"退款成功",
                         @"description":@"您的退款已提交第三方/银行处理，预计3-10个工作日退回您的账户，请注意查收"                                                                   }action:nil];
        [self.dataSource addObject:detailStatusCellModel];
        
        XXCellModel * detailStatusCellModel2 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":operateDate,
                         @"title":@"操作退款",
                         @"description":@"您的退款申请已确认，正在为您操作退款"} action:nil];
        [self.dataSource addObject:detailStatusCellModel2];
        
        XXCellModel * detailStatusCellModel3 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":hotelRefundDetailModel.configTime?:@"",
                         @"title":@"退款审核",
                         @"description":@"您的退款申请正在确认，请耐心等待"} action:nil];
        [self.dataSource addObject:detailStatusCellModel3];
        
        XXCellModel * detailStatusCellModel4 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":hotelRefundDetailModel.createTime?:@"",
                         @"title":@"提交退款",
                         @"description":@"您的退款申请提交成功，我们将尽快为您处理"} action:nil];
        [self.dataSource addObject:detailStatusCellModel4];
        
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)travelRefundDetailRefundID:(NSString *)refundID success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params=@{@"refundID":refundID,
                           @"version":@"v15"};
    [self.hotelOrderAPI travelRefundDetailParams:params success:^(NSDictionary *responseDict) {
        VPTravelRefundDetailModel * travelRefundDetailModel =[VPTravelRefundDetailModel yy_modelWithJSON:responseDict[@"body"]];
        XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPRefundBlankLinesTableViewCell" height:0 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        
        XXCellModel * orderIdAndStatusCellModel = [XXCellModel instantiationWithIdentifier:@"VPOrderIdAndStatusCell" height:0 dataSource:travelRefundDetailModel action:nil];
        [self.dataSource addObject:orderIdAndStatusCellModel];
        [self.dataSource addObject:lineCellModel];
        
        XXCellModel * InfoStatusCellModelCell = [XXCellModel instantiationWithIdentifier:@"VPInfoStatusCell" height:0 dataSource:travelRefundDetailModel action:nil];
        [self.dataSource addObject:InfoStatusCellModelCell];
        
        //计算时间
        NSString * applyDate =[self applyDate:travelRefundDetailModel.applyDate];
        NSString * operateDate =[self applyDate:applyDate];
        
        NSMutableDictionary *travelInfo =[NSMutableDictionary dictionary];
        //退款状态(0：未处理  1：下乡客同意退款 2：退款成功  3：拒绝)【用于退款单】
        [travelInfo setValue:@"退款成功" forKey:@"title"];
        [travelInfo setValue:@"description" forKey:@"您的退款已提交第三方/银行处理，预计3-10个工作日退回您的账户，请注意查收"];
        if (travelRefundDetailModel.refundState==2) {
            [travelInfo setValue:travelRefundDetailModel.joinDate.length>0?travelRefundDetailModel.joinDate:@"" forKey:@"time"];
        }else{
            [travelInfo setValue:@"" forKey:@"time"];
        }
        XXCellModel * detailStatusCellModel =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:travelInfo action:nil];
        [self.dataSource addObject:detailStatusCellModel];
        
        XXCellModel * detailStatusCellModel2 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":operateDate,
                                                                                                                                   @"title":@"操作退款",
                                                                                                                                   @"description":@"您的退款申请已确认，正在为您操作退款"} action:nil];
        [self.dataSource addObject:detailStatusCellModel2];
        
        XXCellModel * detailStatusCellModel3 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":applyDate,
                                                                                                                                   @"title":@"退款审核",
                                                                                                                                   @"description":@"您的退款申请正在确认，请耐心等待"} action:nil];
        [self.dataSource addObject:detailStatusCellModel3];
        
        XXCellModel * detailStatusCellModel4 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":travelRefundDetailModel.applyDate?:@"",
                                                                                                                                   @"title":@"提交退款",
                                                                                                                                   @"description":@"您的退款申请提交成功，我们将尽快为您处理"} action:nil];
        [self.dataSource addObject:detailStatusCellModel4];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)ticketRefundDetailOrderNum:(NSString *)orderNum success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params=@{@"orderNum":orderNum};
    [self.hotelOrderAPI ticketRefundDetailParams:params success:^(NSDictionary *responseDict) {
        VPTiketRefundDetailModel * tiketRefundDetailModel =[VPTiketRefundDetailModel yy_modelWithJSON:responseDict[@"body"]];
        
        //计算时间
        NSString * applyDate =[self applyDate:tiketRefundDetailModel.applyDate];
        NSString * operateDate =[self applyDate:applyDate];
        //空行
        XXCellModel * lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPRefundBlankLinesTableViewCell" height:0 dataSource:nil action:nil];
        [self.dataSource addObject:lineCellModel];
        
        NSDictionary *refundStatusInfo =@{@"price":[NSString stringWithFormat:@"%.2f",tiketRefundDetailModel.refundMoney],
                                          @"state":[self hotelRefundStatus:tiketRefundDetailModel.refundState],
                                          @"orderID":tiketRefundDetailModel.orderNum};
        XXCellModel * infoStatusCellModel =[XXCellModel instantiationWithIdentifier:@"VPRefundStatusCell" height:0 dataSource:refundStatusInfo action:nil];
        [self.dataSource addObject:infoStatusCellModel];
        
        XXCellModel * detailStatusCellModel =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":tiketRefundDetailModel.refundEndDate.length>0?tiketRefundDetailModel.refundEndDate:@"",
                                                                                                                                  @"title":@"退款成功",
                                                                                                                                  @"description":@"您的退款已提交第三方/银行处理，预计3-10个工作日退回您的账户，请注意查收"                                                                   }action:nil];
        [self.dataSource addObject:detailStatusCellModel];
        
        XXCellModel * detailStatusCellModel2 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":operateDate,
                                                                                                                                   @"title":@"操作退款",
                                                                                                                                   @"description":@"您的退款申请已确认，正在为您操作退款"} action:nil];
        [self.dataSource addObject:detailStatusCellModel2];
        
        XXCellModel * detailStatusCellModel3 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":applyDate,
                                                                                                                                   @"title":@"退款审核",
                                                                                                                                   @"description":@"您的退款申请正在确认，请耐心等待"} action:nil];
        [self.dataSource addObject:detailStatusCellModel3];
        
        XXCellModel * detailStatusCellModel4 =[XXCellModel instantiationWithIdentifier:@"VPDetailStatusCell" height:0 dataSource:@{@"time":tiketRefundDetailModel.applyDate?:@"",
                                                                                                                                   @"title":@"提交退款",
                                                                                                                                   @"description":@"您的退款申请提交成功，我们将尽快为您处理"} action:nil];
        [self.dataSource addObject:detailStatusCellModel4];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];

}

- (NSString *)applyDate:(NSString *)applyDate{

    //计算操作完成时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:applyDate];
    date = [date dateByAddingTimeInterval:75];
    NSString *operateTime = [dateFormatter stringFromDate:date];
    return operateTime;
}

-(NSString *)hotelRefundStatus:(NSInteger)status{

    NSString * refundString=@"";
    switch (status) {
        case 0:
            refundString =@"退款中";
            break;
        case 1:
            refundString =@"退款中";
            break;
        case 2:
            refundString =@"退款成功";
            break;
        default:
            break;
    }
    return refundString;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(XXCellModel *)cellForRowAtIndexPath:(NSInteger)index{

    return self.dataSource[index];
}

@end
