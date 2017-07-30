//
//  TravelOrderWriteModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelOrderWriteModel.h"
#import "VPTravelDetailAPI.h"
#import "VPUserManager.h"
#import "VPTravilSubitInformationModel.h"
#import "VPUserManager.h"
#import "NSString+Others.h"
#import "NSError+Reason.h"
#import "VPCouponAPI.h"
#import "VPOrderCouponModel.h"
#import "QMCalendarFunction.h"
@interface TravelOrderWriteModel ()

@property(strong, nonatomic)NSMutableArray * dataSource;

@property(strong, nonatomic)NSMutableArray * peopleInformationArray;

@property(strong, nonatomic)VPTravelDetailAPI *travelDetailAPI;

@property(strong, nonatomic)VPActiveDetailModel *travelModel;

@property (strong, nonatomic)VPTravilSubitInformationModel *travilSubitInformationModel;

@property (strong, nonatomic)NSArray * couponArray;

@property (strong, nonatomic)VPCouponAPI *couponAPI;

@property (strong, nonatomic) QMCalendarFunction * calendarFunction;

/**
 总共购买人数
 */
@property (assign, nonatomic)NSInteger totalNumber;

/**
 当天余票
 */
@property (assign, nonatomic)NSInteger tickets;

@property (strong, nonatomic)NSArray * sectionArray;

@end

@implementation TravelOrderWriteModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.peopleInformationArray =[NSMutableArray array];
        self.travilSubitInformationModel =[[VPTravilSubitInformationModel alloc]init];
        self.travelDetailAPI = [[VPTravelDetailAPI alloc]  init];
        self.couponAPI =[[VPCouponAPI alloc]init];
        self.couponArray =[NSArray array];
        self.sectionArray =[NSArray array];
        self.calendarFunction =[[QMCalendarFunction alloc]init];
    }
    return self;
}

-(void)travelModel:(VPActiveDetailModel *)travelModel{
    [self.peopleInformationArray removeAllObjects];
    self.travelModel =travelModel;
    self.sectionArray =@[@{@"title":@"选择日期"},
                              @{@"title":@"购买票数"},
                              @{@"title":@"取票人信息"},
                              @{@"title":@"选择优惠券"}];
    if (travelModel.needName) {
        //姓名
        NSDictionary * nameDic =[self title:@"姓名" placeholder:@"必填" value:self.travilSubitInformationModel key:@"realName"];
        [self.peopleInformationArray addObject:nameDic];
    }
    if (travelModel.needPhone) {
        //手机号码
        NSDictionary * phoneNumDic =[self title:@"手机号码" placeholder:@"必填" value:self.travilSubitInformationModel key:@"phoneNumber"];
        [self.peopleInformationArray addObject:phoneNumDic];

    }
    if (travelModel.needID) {
        //身份证
        NSDictionary * needCordDic =[self title:@"身份证" placeholder:@"必填" value:self.travilSubitInformationModel key:@"idCord"];

        [self.peopleInformationArray addObject:needCordDic];
    }
    if (travelModel.needAddress) {
        //地址
        NSDictionary * addressDic =[self title:@"地址" placeholder:@"必填" value:self.travilSubitInformationModel key:@"address"];
        [self.peopleInformationArray addObject:addressDic];
    }
    if (travelModel.needOther) {
        //自定义
        NSDictionary * otherDic =[self title:travelModel.otherName placeholder:@"必填" value:self.travilSubitInformationModel key:@"custom"];
        [self.peopleInformationArray addObject:otherDic];
    }
    //布局
    //选择日期节
    XXCellModel * traveOrderCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:self.sectionArray[0] action:nil];
    [self.dataSource addObject:traveOrderCellModel];
    
    if (travelModel.billType==1) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *beginDate = [formatter dateFromString:travelModel.billBeginDate];
        NSDate *endDate = [formatter dateFromString:travelModel.billEndDate];

        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *billBeginDate= [formatter stringFromDate:beginDate];
        NSString *billEndDate = [formatter stringFromDate:endDate];
        XXCellModel * dateSelectCellModel =[XXCellModel instantiationWithIdentifier:@"VPExpiryDateTravelTableViewCell" height:70 dataSource:[NSString stringWithFormat:@"  有效期:%@至%@  ",billBeginDate,billEndDate] action:nil];
        [self.dataSource addObject:dateSelectCellModel];
    }else{
        //日期选择
        CGFloat countCell =(float)travelModel.lstActivityDate.count/3;
        CGFloat collectionHeight;
        int count =ceilf(countCell);
        if (count==0) {
            collectionHeight=0;
        }
        NSDictionary * selectDeteInfo =@{@"lstActivityDate":travelModel.lstActivityDate,
                                         @"subit":self.travilSubitInformationModel};
        collectionHeight = floorf((count-1)*10+(count*40)+20);
        XXCellModel * dateSelectCellModel =[XXCellModel instantiationWithIdentifier:@"VPDateSelectTableViewCell" height:collectionHeight dataSource:selectDeteInfo action:nil];
        [self.dataSource addObject:dateSelectCellModel];
    }
    
    //票节
    XXCellModel * ticketCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:self.sectionArray[1] action:nil];
    [self.dataSource addObject:ticketCellModel];
    
    CGFloat goodsHeight =0;
    for (int i=0; i<travelModel.lstActivityGoods.count; i++) {
        VPActivityGoodsModel * activityGoodsModel =travelModel.lstActivityGoods[i];
        //选票
        if (activityGoodsModel.purchaseNum==0) {
            
            goodsHeight =70;
        }else{
        
            goodsHeight=90;
        }
        XXCellModel * numberCellModel =[XXCellModel instantiationWithIdentifier:@"VPNumberTableViewCell" height:goodsHeight dataSource:activityGoodsModel action:nil];
        [self.dataSource addObject:numberCellModel];
    }
    //个人信息节
    XXCellModel * peopleInformationCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:self.sectionArray[2] action:nil];
    [self.dataSource addObject:peopleInformationCellModel];
    
    //填写个人信息
    if (self.peopleInformationArray) {
        
        for (int i=0; i<self.peopleInformationArray.count; i++) {
            
            NSDictionary *informationInfo =self.peopleInformationArray[i];
            XXCellModel * writInfoCellModel =[XXCellModel instantiationWithIdentifier:@"VPWritInformationTableViewCell" height:45 dataSource:informationInfo action:nil];
            if (i==1) {
                writInfoCellModel.keyboardType =UIKeyboardTypePhonePad;
            }else if (i==2){
                writInfoCellModel.keyboardType =UIKeyboardTypeNamePhonePad;

            }else{
                writInfoCellModel.keyboardType =UIKeyboardTypeDefault;
            }
            [self.dataSource addObject:writInfoCellModel];
        }
    }
    //优惠券节
    XXCellModel * couponSectionCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveOrderCell" height:45 dataSource:self.sectionArray[3] action:nil];
    [self.dataSource addObject:couponSectionCellModel];
    //优惠券
    XXCellModel *couponCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveCouponTableViewCell" height:50 dataSource:@"未使用" action:@selector(couponPrice:)];
    [self.dataSource addObject:couponCellModel];
}

-(void)travelCoupontype:(VPChannelType)type price:(float)price success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{

    [self.couponAPI orderCouponsWithUserID:[[VPUserManager sharedInstance]xx_userinfoID] type:type price:price success:^(NSDictionary *responseDict) {
        self.couponArray =[NSArray yy_modelArrayWithClass:[VPOrderCouponModel class] json:responseDict[@"body"]];
        success(self.couponArray);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSDictionary *)title:(NSString *)title placeholder:(NSString *)placeholder value:(VPTravilSubitInformationModel *)value key:(NSString *)key {

    NSDictionary * dic =@{@"title":title,
                               @"placeholder":placeholder,
                               @"value":value,
                               @"key":key
                               };
    return dic;
}

- (void)totalRealPrice:(double)totalRealPrice lstGoods:(NSArray *)lstGoods totalNumber:(NSInteger)totalNumber actualPayment:(double)actualPayment{

    self.totalNumber = totalNumber;
    self.travilSubitInformationModel.lstGoods = lstGoods;
    self.travilSubitInformationModel.totalRealPrice = totalRealPrice;
    self.travilSubitInformationModel.version =@"v15";
    self.travilSubitInformationModel.activitiesID = self.travelModel.vid;
    self.travilSubitInformationModel.actType =@"1";
    self.travilSubitInformationModel.userID =[[VPUserManager sharedInstance]xx_userinfoID];
    if (self.travelModel.billType == 1) {
        self.travilSubitInformationModel.joinDate=@"";
    }
    self.travilSubitInformationModel.actualPayment = totalRealPrice;
}

- (void)totalRealPrice:(double)totalRealPrice actualPayment:(double)actualPayment conponCode:(NSString *)conponCode{

    self.travilSubitInformationModel.totalRealPrice = totalRealPrice;
    self.travilSubitInformationModel.actualPayment = actualPayment;
    self.travilSubitInformationModel.conponCode = conponCode;
}


- (void)travelWriteOrderSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    
    NSError *error;
    self.tickets=0;
    for (VPActivityDateModel *activityDateModel in self.travelModel.lstActivityDate) {
        if ([self.travilSubitInformationModel.joinDate isEqualToString:activityDateModel.actDate]) {
            self.tickets =activityDateModel.tickets;
        }
    }
    
    if (self.travelModel.lstActivityDate &&self.travelModel.billType==0) {
        if(self.totalNumber>self.tickets){
            error = [NSError errorMessage:@"您购买的套票数超过当天余票"];
            failure(error);
            return;
        }
    }
    if (self.travelModel.billType==1 && self.travelModel.limitPersonNum != 0) {
        if(self.totalNumber>self.tickets){
            error = [NSError errorMessage:@"您购买的套票数超过当天余票"];
            failure(error);
            return;
        }
    }if (self.travilSubitInformationModel.joinDate.length<=0&&self.travelModel.billType==0) {
            error = [NSError errorMessage:@"请选择日期"];
            failure(error);
    }else if (self.travelModel.lstActivityGoods.count&&!self.travilSubitInformationModel.lstGoods.count) {
        error = [NSError errorMessage:@"请输入套票数量"];
        failure(error);
    }else if ([self.travilSubitInformationModel.realName isNumber]||([self.self.travilSubitInformationModel.realName isEnglishWords]&&self.travelModel.needName>0)) {
        error = [NSError errorMessage:@"请输入正确的姓名"];
        failure(error);
    }    else if (![self.travilSubitInformationModel.phoneNumber isPhoneNumber]&&self.travelModel.needPhone>0) {
        error = [NSError errorMessage:@"请输入正确定电话号码"];
        failure(error);
    }else if(self.travilSubitInformationModel.idCord.length<=0&&self.travelModel.needID>0){
        error = [NSError errorMessage:@"请输入身份证"];
        failure(error);
    }else if ([self.travilSubitInformationModel.address isEnglishWords]||([self.travilSubitInformationModel.address isNumber]&&self.travelModel.needAddress>0)) {
        error = [NSError errorMessage:@"请输入正确的地址"];
        failure(error);
    }else if(self.travelModel.needOther>0 &&self.travilSubitInformationModel.custom.length<=0){
        error = [NSError errorMessage:@"请输入自定义内容"];
        failure(error);
    }else{
 
        if (self.travelModel.billType==1) {
            self.travilSubitInformationModel.joinDate =@"";
        }
        NSDictionary * parameters = [self.travilSubitInformationModel yy_modelToJSONObject];
        [self.travelDetailAPI travelOrderWritelParams:parameters success:^(NSDictionary *responseDict) {
            success(responseDict[@"body"]);
        } failure:^(NSError *error) {
        failure(error);
        }];
    }
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    return self.dataSource[row];
}

#pragma mark -setter or getter
-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
