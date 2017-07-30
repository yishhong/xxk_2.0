//
//  VPTravelMainViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/11.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTravelMainViewModel.h"
#import "VPTravelAPI.h"
#import "VPTravelTagsModel.h"
#import "YYModel.h"

@interface VPTravelMainViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPTravelAPI *travelAPI;

@end

@implementation VPTravelMainViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.travelAPI =[[VPTravelAPI alloc]init];
    }
    return self;
}

- (void)travelTagschannelId:(VPChannelType)channelId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{

    NSDictionary *params =@{@"channelId":@(channelId)};
    [self.travelAPI travelTagsParams:params success:^(NSDictionary *responseDict) {
        NSArray * travelTagsModelArray =[NSArray yy_modelArrayWithClass:[VPTravelTagsModel class] json:responseDict[@"body"]];
        success(travelTagsModelArray);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
     

@end
