//
//  HotelSubmitOrderModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/27.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HotelSubmitOrderModel.h"
#import "VPHotelDetailAPI.h"
#import "VPHotelSubmitModel.h"
#import "VPUserManager.h"
#import "NSError+Reason.h"
#import "NSString+Others.h"
#import "VPCouponAPI.h"
#import "VPCouponModel.h"
#import "NSString+Size.h"
#import "VPOrderCouponModel.h"


#define W [UIScreen mainScreen].bounds.size.width

@interface HotelSubmitOrderModel ()

@property(strong, nonatomic) NSMutableArray * dataSource;

@property (strong, nonatomic) VPHotelDetailAPI *hotelDetailAPI;

@property (strong, nonatomic) VPHotelSubmitModel *hotelSubmitModel;

@property (strong, nonatomic) NSMutableDictionary *submitInfo;

@property (strong, nonatomic) VPCouponAPI *couponAPI;

@property (strong, nonatomic) NSArray * couponArray;


///**
// 房间数量
// */
//@property (assign, nonatomic) NSInteger roomAmount;
///**
// 总价
// */
//@property (assign, nonatomic) double totalPrices;
//
///**
// 单价
// */
//@property (assign, nonatomic) double unitPrice;

/**
 当前选中的优惠券模型
 */
@property (strong, nonatomic) VPOrderCouponModel *selectOrderCouponModel;

@end

@implementation HotelSubmitOrderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hotelDetailAPI =[[VPHotelDetailAPI alloc]init];
        self.hotelSubmitModel =[[VPHotelSubmitModel alloc]init];
        self.couponAPI =[[VPCouponAPI alloc]init];
        self.couponArray =[[NSArray alloc]init];
        self.selectOrderCouponModel = nil;
        self.hotelSubmitModel.unitPrice = 0.00f;
        self.hotelSubmitModel.payMoney = 0.00f;
        self.hotelSubmitModel.actualPayment = 0.00f;
    }
    return self;
}

- (void)hotelSubmitRoomId:(NSString *)roomId beginTime:(NSString *)beginTime endTime:(NSString *)endTime submitInfo:(NSDictionary *)submitInfo success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    self.submitInfo =[NSMutableDictionary dictionary];
    NSDictionary *params =@{@"roomId":roomId,
                            @"beginTime":beginTime,
                            @"endTime":endTime};
    [self.hotelDetailAPI hotelPriceParams:params success:^(NSDictionary *responseDict) {
        [self.dataSource removeAllObjects];
        self.submitInfo = [submitInfo mutableCopy];
        VPHotelRoomListRoomModel *hotelRoomListRoomModel = self.submitInfo[@"roomListRoomModel"];
        self.hotelSubmitModel.roomId = hotelRoomListRoomModel.rid;
        self.hotelSubmitModel.hid = [self.submitInfo[@"hid"] integerValue];
        self.hotelSubmitModel.beginDate = self.submitInfo[@"checkTime"];
        self.hotelSubmitModel.endDate = self.submitInfo[@"outTime"];
        self.hotelSubmitModel.orderId = self.submitInfo[@"orderNum"];
        self.hotelSubmitModel.orderDate= self.submitInfo[@"updteDate"];
        self.hotelSubmitModel.userId = [[VPUserManager sharedInstance]xx_userinfoID];
        self.hotelSubmitModel.quantity = @"1";
        self.hotelSubmitModel.roomInfo = @"";
        self.hotelSubmitModel.orderDesc = @"";
        self.hotelSubmitModel.payMoney = [responseDict[@"body"] floatValue];
        self.hotelSubmitModel.actualPayment = [responseDict[@"body"] floatValue];
        self.hotelSubmitModel.unitPrice = [responseDict[@"body"] floatValue];
        self.selectOrderCouponModel = nil;

        
        NSArray * informationArr =@[@{@"title":@"入住人数",
                                      @"placeholder":@"请选择入住人数",
                                      @"value":self.hotelSubmitModel,
                                      @"key":@"checkPersonNum"},
                                    
                                    @{@"title":@"入住人",
                                      @"placeholder":@"填写入住人姓名",
                                      @"value":self.hotelSubmitModel,
                                      @"key":@"linkRealName"},
                                    
                                    @{@"title":@"手机",
                                      @"placeholder":@"有效手机号",
                                      @"value":self.hotelSubmitModel,
                                      @"key":@"linkPhone"}];

            //布局
            //民宿酒店名称
            XXCellModel * hotelInformtionCellModel =[XXCellModel instantiationWithIdentifier:@"VPHotelInformtionTableViewCell" height:106 dataSource:self.submitInfo action:nil];
            [self.dataSource addObject:hotelInformtionCellModel];
            
            //房间数
            NSDictionary *roomNumInfo =@{@"title":@"房间",
                                         @"value":self.hotelSubmitModel,
                                         @"key":@"quantity"};
            XXCellModel * hotelRoomNumCellModel =[XXCellModel instantiationWithIdentifier:@"VPHotelRoomNumTableViewCell" height:45 dataSource:roomNumInfo action:nil];
            [self.dataSource addObject:hotelRoomNumCellModel];
            
            //入住人
            for (int i=0; i<informationArr.count;i++) {
                NSDictionary * cellInfo =informationArr[i];
                XXCellModel * phoneNumberCellModel =[XXCellModel instantiationWithIdentifier:@"VPPhoneNumberTableViewCell" height:44 dataSource:cellInfo action:nil];
                if (i==1) {
                    phoneNumberCellModel.keyboardType =UIKeyboardTypeDefault;
                }else{
                    phoneNumberCellModel.keyboardType =UIKeyboardTypePhonePad;
                }
                [self.dataSource addObject:phoneNumberCellModel];
            }
            //空行
            XXCellModel * lineCellModel =[XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
            [self.dataSource addObject:lineCellModel];
        
            //优惠券
            XXCellModel * traveCouponCellModel =[XXCellModel instantiationWithIdentifier:@"VPTraveCouponTableViewCell" height:50 dataSource:self.hotelSubmitModel action:@selector(couponPrice:)];
            [self.dataSource addObject:traveCouponCellModel];
        success(responseDict[@"body"]);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)HotelRule:(NSString *)ruleId{

    //限时取消
    NSDictionary *params =@{@"type":ruleId};
    [self.hotelDetailAPI hotelRuleParams:params success:^(NSDictionary *responseDict) {
        NSString * ruleString =responseDict[@"body"];
        CGFloat ruleHeight =[ruleString heightWithFont:[UIFont systemFontOfSize:13] constrainedToWidth:W-24];
        ruleHeight =ruleHeight+28;
        XXCellModel * hotelRemoveCellModel = [XXCellModel instantiationWithIdentifier:@"VPHotelRemoveTableViewCell" height:ruleHeight dataSource:ruleString action:nil];
        [self.dataSource addObject:hotelRemoveCellModel];
    } failure:^(NSError *error) {
        
    }];
}

-(void)tiketCoupontype:(VPChannelType)type price:(float)price success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    [self.couponAPI orderCouponsWithUserID:[[VPUserManager sharedInstance]xx_userinfoID] type:type price:self.hotelSubmitModel.payMoney success:^(NSDictionary *responseDict) {
        NSArray * couponArray =[NSArray yy_modelArrayWithClass:[VPOrderCouponModel class] json:responseDict[@"body"]];
        success(couponArray);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)hotelSubmitOrderSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{

    if (self.hotelSubmitModel.quantity.length<=0||![self.hotelSubmitModel.quantity isNumber]) {
        NSError *error =[NSError errorMessage:@"请选择入住人数"];
        failure(error);
        return;
    }if (self.hotelSubmitModel.linkRealName.length<=0||[self.hotelSubmitModel.linkRealName isNumber]) {
        NSError *error =[NSError errorMessage:@"请输入正确的姓名"];
        failure(error);
        return;
    }
    if (self.hotelSubmitModel.linkPhone.length<=0||![self.hotelSubmitModel.linkPhone isPhoneNumber]) {
        NSError *error =[NSError errorMessage:@"请输入正确的手机号码"];
        failure(error);
        return;
    }
    NSDictionary *params =[self.hotelSubmitModel yy_modelToJSONObject];
    [self.hotelDetailAPI hotelUpOrderParams:params success:^(NSDictionary *responseDict) {
        success(responseDict[@"body"]);
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

- (NSArray *)hotelRoomNumber{

    NSMutableArray * roomNumArray =[NSMutableArray array];
    for (int i=1; i<=[self.submitInfo[@"roomNum"] integerValue]; i++) {
        NSString * roomNumString =[NSString stringWithFormat:@"%d",i];
        [roomNumArray addObject:roomNumString];
    }
    return roomNumArray;
}
//
//- (void)updateSelectRoomNumber:(NSString *)selectRoomNumber payMoney:(float)payMoney{
//    
//    self.hotelSubmitModel.quantity =selectRoomNumber;
//    self.hotelSubmitModel.payMoney =payMoney;
//    self.hotelSubmitModel.actualPayment =payMoney;
//
//}
//
//- (void)totalRealPrice:(CGFloat)totalRealPrice actualPayment:(CGFloat)actualPayment conponCode:(NSString *)conponCode discount:(double)discount{
//    
//    self.hotelSubmitModel.payMoney = totalRealPrice;
//    self.hotelSubmitModel.actualPayment = actualPayment;
//}



- (void)selectRoomNum:(NSInteger)roomNum{
    self.hotelSubmitModel.quantity = [@(roomNum) stringValue];
    [self preferentialAmount];
}

- (void)selectConpon:(VPOrderCouponModel *)orderCouponModel{
    self.selectOrderCouponModel = orderCouponModel;
    //选择房间后需要计算价格
    self.hotelSubmitModel.couponCode = orderCouponModel.couponCode;

    [self preferentialAmount];
}

- (double)preferentialAmount{
    double money = 0.0f;
    money = [self.hotelSubmitModel.quantity doubleValue] * self.hotelSubmitModel.unitPrice;
    self.hotelSubmitModel.payMoney = money;
    //判断优惠券是否可用
    if(self.selectOrderCouponModel.amount !=0&& money<self.selectOrderCouponModel.amount){
        self.selectOrderCouponModel = nil;
        self.hotelSubmitModel.couponCode = @"";
    }
    if(self.selectOrderCouponModel){
        switch (self.selectOrderCouponModel.discountType) {
            case 0:
            case 1:{
                //满减
                money = self.selectOrderCouponModel.discountMoney;
            }break;
            case 2:{
                //折扣
                money = money - money*(self.selectOrderCouponModel.discountValue/100.0);
            }break;
            default:
                break;
        }
    }else{
        money = 0.00f;
    }
    self.hotelSubmitModel.preferentialAmount = money;
    if(self.hotelSubmitModel.payMoney - money <0){
        self.hotelSubmitModel.actualPayment = 0.01;
    }else{
        self.hotelSubmitModel.actualPayment = self.hotelSubmitModel.payMoney - money;
    }
    return money;
}

- (double)paymentAmount{
    //支付金额
    return self.hotelSubmitModel.actualPayment;
}



#pragma mark -setter or getter
-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc]init];
    }
    return _dataSource;
}


@end
