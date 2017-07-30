//
//  TiketOrderWriteModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TiketOrderWriteModel.h"
#import "VPTicketAPI.h"
#import "VPTicketSubitInformationModel.h"
#import "VPUserManager.h"
#import "VPCouponAPI.h"
#import "VPOrderCouponModel.h"
#import "NSError+Reason.h"
#import "NSString+Others.h"
#import "QMCalendarFunction.h"

@interface TiketOrderWriteModel ()

@property(strong, nonatomic)NSMutableArray * dataSource;

@property (strong, nonatomic)VPTicketAPI *ticketAPI;

@property (strong ,nonatomic) NSMutableArray * peopleInformationArray;

@property (strong, nonatomic) VPTicketListModel * ticketListModel;

@property (strong, nonatomic) VPTicketSubitInformationModel *tricketSubitInformationModel;

@property (strong, nonatomic) VPCouponAPI *couponAPI;

@property (strong, nonatomic) QMCalendarFunction * calendarFunction;



@end

@implementation TiketOrderWriteModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ticketAPI =[[VPTicketAPI alloc]init];
        self.peopleInformationArray =[NSMutableArray array];
        self.tricketSubitInformationModel =[[VPTicketSubitInformationModel alloc]init];
        self.couponAPI =[[VPCouponAPI alloc]init];
        self.ticketAPI =[[VPTicketAPI alloc]init];
        self.calendarFunction =[[QMCalendarFunction alloc]init];
        self.dayDict = [NSMutableDictionary dictionary];

    }
    return self;
}

-(void)tiketOrderWriteModel:(VPTicketDetailModel *)tiketOrderWriteModel{

    self.ticketListModel =tiketOrderWriteModel.ticket;
    self.tricketSubitInformationModel.idCord =@"";
    self.tricketSubitInformationModel.activitiesId =[NSString stringWithFormat:@"%ld",(long)self.ticketListModel.pid];
    self.tricketSubitInformationModel.channelId =VPChannelTypeTicket;
    NSArray * sectionArray =@[@{@"title":@"选择日期与数量"},
                              @{@"title":@"取票人信息"},
                              @{@"title":@"选择优惠券"},
                              @{@"title":@"取票说明"}];
    if (self.ticketListModel.needName) {
        //姓名
        NSDictionary * nameDic =[self title:@"姓名" placeholder:@"必填" value:self.tricketSubitInformationModel key:@"realName"];
        [self.peopleInformationArray addObject:nameDic];
    }
    if (self.ticketListModel.needPhone) {
        //手机号码
        NSDictionary * phoneNumDic =[self title:@"手机号码" placeholder:@"必填" value:self.tricketSubitInformationModel key:@"phoneNumberpe"];
        [self.peopleInformationArray addObject:phoneNumDic];
        
    }
    if (self.ticketListModel.needID) {
        //身份证
        NSDictionary * needCordDic =[self title:@"身份证" placeholder:@"必填" value:self.tricketSubitInformationModel key:@"idCord"];
        
        [self.peopleInformationArray addObject:needCordDic];
    }
//    if (ticketListModel.needAddress) {
//        //地址
//        NSDictionary * addressDic =[self title:@"地址" placeholder:@"必填" value:self.tricketSubitInformationModel key:@"address"];
//        [self.peopleInformationArray addObject:addressDic];
//    }
//    if (ticketListModel.needOther) {
//        //自定义
//        NSDictionary * otherDic =[self title:@"自定义" placeholder:@"必填" value:self.tricketSubitInformationModel key:@"custom"];
//        [self.peopleInformationArray addObject:otherDic];
//    }
    //布局
    //选择日期与数量
    XXCellModel * sectionCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:sectionArray[0] action:nil];
    [self.dataSource addObject:sectionCellModel];
    
    //使用日期
    NSString * todayString =[self.calendarFunction getCurrentTime];
    NSString * tomorrowDayString =[self.calendarFunction GetTomorrowDay:[NSDate date]];
    //转成MM-dd
    NSString * todayTime =[self.calendarFunction currentDatefromString:todayString];
    NSString *tomorrowTime =[self.calendarFunction currentDatefromString:tomorrowDayString];
    [self.dayDict removeAllObjects];
    self.dayDict[@"lstActivityDate"] = @[@{@"today":@"今天",
                           @"date":todayString,
                           @"time":todayTime},
                         @{@"today":@"明天",
                           @"date":tomorrowDayString,
                           @"time":tomorrowTime},
                         @{@"today":@"更多日期",
                           @"date":@"",
                           @"time":@""}
                         ];
    self.dayDict[@"selectTime"] = todayTime;
    self.dayDict[@"selectDate"] = todayString;
//    dayDict[@"subit"] = self.tricketSubitInformationModel;

    self.tricketSubitInformationModel.joinDate = todayString;
//    NSDictionary * selectDeteInfo =@{@"lstActivityDate":selectDateArray,
//                                     @"subit":self.tricketSubitInformationModel};;
    XXCellModel * tiketDateCellModel = [XXCellModel instantiationWithIdentifier:@"VPTiketDateUsedTableViewCell" height:73 dataSource:self.dayDict action:nil];
    [self.dataSource addObject:tiketDateCellModel];

    for (VPActivityGoodsModel * activityGoodsModel in tiketOrderWriteModel.ticketGoods) {
        if(activityGoodsModel.type == 1){
            
            XXCellModel * tiketNumberCellModel =[XXCellModel instantiationWithIdentifier:@"VPTiketNumberTableViewCell" height:105 dataSource:activityGoodsModel action:nil];
            [self.dataSource addObject:tiketNumberCellModel];
        }
    }
    
    //添加其他门票
    XXCellModel * addTiketCellModel =[XXCellModel instantiationWithIdentifier:@"VPAddTiketTableViewCell" height:45 dataSource:nil action:nil];
    [self.dataSource addObject:addTiketCellModel];
    
    //取票人信息
    XXCellModel * sectionInfomationCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:sectionArray[1] action:nil];
    [self.dataSource addObject:sectionInfomationCellModel];
    
    //取票填写姓名、手机号码
    for (int i=0; i<self.peopleInformationArray.count;i++) {
        NSDictionary * infoCell =self.peopleInformationArray[i];
        XXCellModel * phoneNumberCellModel =[XXCellModel instantiationWithIdentifier:@"VPPhoneNumberTableViewCell" height:44 dataSource:infoCell action:nil];
        if (i==0) {
            phoneNumberCellModel.keyboardType =UIKeyboardTypeDefault;
        }else{
            phoneNumberCellModel.keyboardType =UIKeyboardTypePhonePad;
        }
        [self.dataSource addObject:phoneNumberCellModel];
    }
    //选择优惠券
    XXCellModel * sectionCouponCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:sectionArray[2] action:nil];
    [self.dataSource addObject:sectionCouponCellModel];
    
    //优惠券选择
    XXCellModel * couponCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveCouponTableViewCell" height:45 dataSource:@"未使用" action:@selector(couponPrice:)];
    [self.dataSource addObject:couponCellModel];

    //取票说明
    XXCellModel * sectionExplainCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:sectionArray[3] action:nil];
    [self.dataSource addObject:sectionExplainCellModel];
    
    XXCellModel * buyTiketExplainCellModel =[XXCellModel instantiationWithIdentifier:@"VPBuyTiketExplainTableViewCell" height:80 dataSource:nil action:nil];
    [self.dataSource addObject:buyTiketExplainCellModel];
}


- (void)totalRealPrice:(double)totalRealPrice lstGoods:(NSArray *)lstGoods totalNumber:(NSInteger)totalNumber actualPayment:(double)actualPayment discount:(double)discount{
    
    self.tricketSubitInformationModel.lstGoods =lstGoods;
    self.tricketSubitInformationModel.totalRealPrice = totalRealPrice;
    self.tricketSubitInformationModel.userId =[[VPUserManager sharedInstance]xx_userinfoID];
    self.tricketSubitInformationModel.actualPayment = actualPayment;
    self.tricketSubitInformationModel.discount = discount;

}

- (void)totalRealPrice:(double)totalRealPrice actualPayment:(double)actualPayment conponCode:(NSString *)conponCode discount:(double)discount{
    
    self.tricketSubitInformationModel.totalRealPrice = totalRealPrice;
    self.tricketSubitInformationModel.actualPayment = actualPayment;
    self.tricketSubitInformationModel.couponCode = conponCode;
    self.tricketSubitInformationModel.discount = discount;

}

- (NSDictionary *)title:(NSString *)title placeholder:(NSString *)placeholder value:(VPTicketSubitInformationModel *)value key:(NSString *)key {
    
    NSDictionary * dic =@{@"title":title,
                          @"placeholder":placeholder,
                          @"value":value,
                          @"key":key
                          };
    return dic;
}

-(void)tiketCoupontype:(VPChannelType)type price:(float)price success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    [self.couponAPI orderCouponsWithUserID:[[VPUserManager sharedInstance]xx_userinfoID] type:type price:price success:^(NSDictionary *responseDict) {
        NSArray * couponArray =[NSArray yy_modelArrayWithClass:[VPOrderCouponModel class] json:responseDict[@"body"]];
        success(couponArray);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)tiketOrderWriteSubitSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    
    self.tricketSubitInformationModel.joinDate = self.dayDict[@"selectDate"];
    NSError * error;
    if (self.tricketSubitInformationModel.joinDate.length<=0) {
        error = [NSError errorMessage:@"请选择日期"];
        failure(error);
    }else if (!self.tricketSubitInformationModel.lstGoods.count) {
        error = [NSError errorMessage:@"请输入套票数量"];
        failure(error);
    }else if ([self.tricketSubitInformationModel.realName isNumber]||([self.self.tricketSubitInformationModel.realName isEnglishWords]&&self.ticketListModel.needName>0)) {
        error = [NSError errorMessage:@"请输入正确定姓名"];
        failure(error);
    }else if (![self.tricketSubitInformationModel.phoneNumberpe isPhoneNumber]&&self.ticketListModel.needPhone>0) {
        error = [NSError errorMessage:@"请输入正确的电话号码"];
        failure(error);
    }else if(self.tricketSubitInformationModel.idCord.length<=0&&self.ticketListModel.needID>0){
        error = [NSError errorMessage:@"请输入身份证"];
        failure(error);
    }else{
        self.tricketSubitInformationModel.JoinDateStr =self.tricketSubitInformationModel.joinDate;
        NSDictionary *params =[self.tricketSubitInformationModel yy_modelToJSONObject];
        [self.ticketAPI ticketOrderWriteParams:params success:^(NSDictionary *responseDict) {
            success(responseDict[@"body"]);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}


- (void)addTiketDate:(VPActivityGoodsModel *)activityGoodsModel indexPath:(NSIndexPath *)indexPath{
    
        XXCellModel * addDeleteCellModel =[XXCellModel instantiationWithIdentifier:@"VPAddDeleteTableViewCell" height:85 dataSource:activityGoodsModel action:nil];
        //空行
        XXCellModel * lineCellModel =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        NSIndexSet *indexSet =[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row, 2)];
        [self.dataSource insertObjects:@[addDeleteCellModel,lineCellModel] atIndexes:indexSet];

}

- (void)deleteTietDate:(VPActivityGoodsModel *)activityGoodsModel indexPath:(NSIndexPath *)indexPath{

    NSIndexSet *indexSet =[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row, 2)];
    [self.dataSource removeObjectsAtIndexes:indexSet];
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
