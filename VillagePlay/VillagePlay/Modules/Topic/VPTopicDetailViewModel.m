//
//  VPTopicDetailViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicDetailViewModel.h"
#import "VPTopicDetailAPI.h"
#import "VPUserInfoModel.h"
#import "VPUserManager.h"
#import "VPTopicDetailModel.h"
#import "NSObject+YYModel.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height

@interface VPTopicDetailViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic)VPTopicDetailAPI *topicDetailAPI;
@end

@implementation VPTopicDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.topicDetailAPI =[[VPTopicDetailAPI alloc]init];
    }
    return self;
}

- (void)topicID:(NSString *)topicID success:(void (^)(VPTopicDetailModel*))success failure:(void (^)(NSError *))failure{
    NSDictionary *params=@{@"version":@"v15",
                           @"id":topicID,
                           @"userid":[VPUserManager sharedInstance].xx_userinfoID};
    [self.topicDetailAPI topicDetailParams:params success:^(NSDictionary *responseDict) {
        VPTopicDetailModel * topicDetailModel =[VPTopicDetailModel yy_modelWithJSON:responseDict[@"body"]];
        //布局
        //专题详情
        XXCellModel * detaileModel = [XXCellModel instantiationWithIdentifier:@"TopDetaileTableViewCell" height:80 dataSource:topicDetailModel action:nil];
        [self.dataSource addObject:detaileModel];
        
        //详情评论数
        XXCellModel *slideModel =[XXCellModel instantiationWithIdentifier:@"VPTravelDetailSlideTableViewCell" height:Main_Screen_Height-(50+64) dataSource:nil action:nil];
        [self.dataSource addObject:slideModel];
        success(topicDetailModel);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)topicDetailViewModel:(NSArray *)topicDetailViewModel{
    
}



-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    
    return self.dataSource[row];
}

@end
