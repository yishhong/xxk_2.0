//
//  VPSystemNotificationModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/7.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSystemMessageViewModel.h"
#import "VPSysMessageAPI.h"
#import "VPSysMessageModel.h"

@interface VPSystemMessageViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPSysMessageAPI *sysMessageAPI;

@end

@implementation VPSystemMessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.sysMessageAPI = [[VPSysMessageAPI alloc] init];
    }
    return self;
}

//- (void)layerUI:(NSArray *)systemInformsViewModel{
//    //系统消息详情图文
//    XXCellModel * textAndImageCellModel = [XXCellModel instantiationWithIdentifier:@"VillageTitleTableViewCell" height:40 dataSource:nil action:nil];
//    [self.dataSource addObject:textAndImageCellModel];
//    
//    XXCellModel * mageCellModel = [XXCellModel instantiationWithIdentifier:@"VillageImageTableViewCell" height:189 dataSource:nil action:nil];
//    [self.dataSource addObject:mageCellModel];
//    
//    XXCellModel * subTitleCellModel = [XXCellModel instantiationWithIdentifier:@"VillageSubTitleTableViewCell" height:60 dataSource:nil action:nil];
//    [self.dataSource addObject:subTitleCellModel];
//    
//    XXCellModel * systemNotificationCellModel = [XXCellModel instantiationWithIdentifier:@"SystemNotificationTimeTableViewCell" height:40 dataSource:nil action:nil];
//    [self.dataSource addObject:systemNotificationCellModel];
//
//}

- (void)loadSystemNotificationWithSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    [self.sysMessageAPI loadSysMessageWithParams:nil success:^(NSDictionary *responseDict) {
        [self.dataSource removeAllObjects];
        NSArray *dataArray = [NSArray yy_modelArrayWithClass:[VPSysMessageModel class] json:responseDict[@"body"]];
        for (VPSysMessageModel *sysMessageModel in dataArray) {
            XXCellModel *titleCellModel = [XXCellModel instantiationWithIdentifier:@"VPSysMessageTitleCell" height:44 dataSource:sysMessageModel action:nil];
            [self.dataSource addObject:titleCellModel];
            if(sysMessageModel.content.length>0){
                XXCellModel *contentCellModel = [XXCellModel instantiationWithIdentifier:@"VPSysMessageContentCell" height:44 dataSource:sysMessageModel action:nil];
                [self.dataSource addObject:contentCellModel];
            }
            if(sysMessageModel.imgUrl.length>0){
                XXCellModel *imageCellModel = [XXCellModel instantiationWithIdentifier:@"VPSysMessageImageCell" height:95 dataSource:sysMessageModel action:nil];
                [self.dataSource addObject:imageCellModel];
            }
            XXCellModel *dateCellModel = [XXCellModel instantiationWithIdentifier:@"VPSysMessageDateCell" height:44 dataSource:sysMessageModel action:nil];
            [self.dataSource addObject:dateCellModel];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSInteger)numberOfRows{
    
    return self.dataSource.count;
}


- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return self.dataSource[indexPath.row];
}


@end
