//
//  VPTicketViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketViewModel.h"
#import "VPTicketAPI.h"
#import "YYModel.h"
#import "VPTicketListModel.h"
#import "VPTravelAPI.h"
#import "VPTagModel.h"
#import "CommentDetaileEnum.h"

@interface VPTicketViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPTicketAPI *ticketAPI;

@property (assign, nonatomic) NSInteger pageIndex;

@property (strong, nonatomic) NSMutableArray *leftArray;

@property (strong, nonatomic) VPTravelAPI *travelAPI;

@property (strong, nonatomic) NSString * whereStr;

@property (assign, nonatomic) NSInteger orderby;


@end

@implementation VPTicketViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.ticketAPI =[[VPTicketAPI alloc]init];
        self.pageIndex =0;
        self.leftArray = [NSMutableArray array];
        self.travelAPI =[[VPTravelAPI alloc]init];
    }
    return self;
}

-(void)TikicketWhereStrSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    [self.travelAPI travelTagsParams:@{@"channelId":@(VPChannelTypeTicket)} success:^(NSDictionary *responseDict) {
        NSArray * ticketArray =[NSArray yy_modelArrayWithClass:[VPTagModel class] json:responseDict[@"body"]];
        self.leftArray= [ticketArray mutableCopy];

//        if(!ticketArray){
//        }else{
//            VPTagModel *tagModel = [[VPTagModel alloc] init];
//            tagModel.tagName = @"默认主题";
//            self.leftArray = [@[tagModel] mutableCopy];
//        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSArray *)dropMenuWithLeft:(BOOL)isLeft{
    NSArray *menuArray = nil;
    if(isLeft){
        if(!self.leftArray||[self.leftArray count]==0){
            VPTagModel *tagModel = [[VPTagModel alloc] init];
            tagModel.tagName = @"默认主题";
            self.leftArray = [@[tagModel] mutableCopy];
        }
        menuArray = self.leftArray;
    }else{
        menuArray = @[@"默认排序",@"价格优先",@"热门优先"];
    }
    return menuArray;
}

- (void)ticketIsFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    
    if (isFirstLoading) {
        self.pageIndex= 1;
    }
    VPOpenCityInfoModel *cityModel = [[VPLocationManager sharedManager] locationCoordinate2DWithType:self.locationType];
    NSDictionary *params=@{
                           @"cityId":cityModel.vid.length>0?cityModel.vid:@(0),
                           @"orderby":@(self.orderby),
                           @"whereStr":self.whereStr.length>0?self.whereStr:@"",
                           @"pageNum":@(self.pageIndex),
                           @"pageSize":@(20),
                           };
    [self.ticketAPI ticketListParams:params success:^(NSDictionary *responseDict) {
//注意这个判断是与是否首次加载的 设置的页码一样
        if(self.pageIndex ==1){
            [self.dataSource removeAllObjects];
        }
        NSArray * ticketArray =[NSArray yy_modelArrayWithClass:[VPTicketListModel class] json:responseDict[@"body"]];
        for (int i=0; i<ticketArray.count; i++) {
            VPTicketListModel *ticketListModel =ticketArray[i];
            XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VPTicketTableViewCell" height:307 dataSource:ticketListModel action:nil];
            [self.dataSource addObject:cellModel];
        }
        self.pageIndex++;
        success([ticketArray count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//UI界面 0默认排序，1按价格排序,2按热门排序
//API 0默认排序，1按价格排序，2.按推荐排序,3按热门排序(推荐排序的在UI上移除)

- (void)orderby:(NSInteger)orderby{
    if(orderby ==2){
        self.orderby = 3;
    }
    self.orderby = orderby;
}

//whereStr tagName
- (void)whereStr:(NSString *)whereStr{
    if([whereStr isEqualToString:@"默认主题"]){
        self.whereStr = @"";
    }else{
        self.whereStr = whereStr;
    }
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    
    return self.dataSource[row];
}
@end
