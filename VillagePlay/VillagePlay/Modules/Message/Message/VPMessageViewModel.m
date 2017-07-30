//
//  VPMessageViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMessageViewModel.h"
#import "VPCommendAPI.h"
#import "VPSysMessageAPI.h"

@interface VPMessageViewModel ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) VPCommendAPI *commendAPI;
@property (nonatomic, strong) VPSysMessageAPI *sysMessageAPI;
@property (nonatomic, assign) NSInteger commendCount;
@property (nonatomic, assign) NSInteger sysMessageCount;
@end

@implementation VPMessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.commendAPI = [[VPCommendAPI alloc] init];
        self.sysMessageAPI = [[VPSysMessageAPI alloc] init];
        self.commendCount = 0;
        self.sysMessageCount = 0;
    }
    return self;
}

- (void)layerUI{
    
    NSMutableDictionary * commentInfo = [NSMutableDictionary dictionary];
    commentInfo[@"title"] = @"评论我的";
    commentInfo[@"icon"] = @"vp_mine_comment";
    if(self.commendCount>0){
        commentInfo[@"value"] = [NSString stringWithFormat:@"%zd条未读消息",self.commendCount];
    }
    XXCellModel *commentCellModel = [XXCellModel instantiationWithIdentifier:@"VPMessageCell" height:75 dataSource:commentInfo action:@selector(comment)];
    [self.dataSource addObject:commentCellModel];
    
    NSMutableDictionary *systemNotificationInfo = [NSMutableDictionary dictionary];
    systemNotificationInfo[@"title"] = @"系统通知";
    systemNotificationInfo[@"icon"] = @"vp_mine_systemnotification";
    if(self.sysMessageCount>0){
        systemNotificationInfo[@"value"] = [NSString stringWithFormat:@"%zd条未读消息",self.sysMessageCount];
    }
    XXCellModel *systemNotificationCellModel = [XXCellModel instantiationWithIdentifier:@"VPMessageCell" height:75 dataSource:systemNotificationInfo action:@selector(systemNotification)];
    [self.dataSource addObject:systemNotificationCellModel];
}

- (void)loadMessageCountWithSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    //获取评论数
    [self.commendAPI loadCommentMessageCountWithParams:nil success:^(NSDictionary *responseDict) {
        self.commendCount = [responseDict[@"body"] integerValue];
        //获取系统通知
        [self.sysMessageAPI loadSysMessageCountWithParams:nil success:^(NSDictionary *responseDict) {
            self.sysMessageCount = [responseDict[@"body"] integerValue];
            [self layerUI];
            success();
        } failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}
@end
