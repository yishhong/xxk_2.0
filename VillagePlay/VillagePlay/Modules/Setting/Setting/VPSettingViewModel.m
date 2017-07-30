//
//  VPSettingViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSettingViewModel.h"
#import "InfoPlist.h"
#import "VPUserManager.h"

@interface VPSettingViewModel ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation VPSettingViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)layerUI{
    XXCellModel *spaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingSpaceCell" height:20 dataSource:nil action:nil];
    [self.dataSource addObject:spaceCellModel];
    
    XXCellModel *versionCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingValueCell" height:50 dataSource:@{@"title":@"当前版本",@"value":[NSString stringWithFormat:@"V%@",[InfoPlist mainVersion]]} action:nil];
    [self.dataSource addObject:versionCellModel];
    XXCellModel *feedbackCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingEventCell" height:50 dataSource:@"给我们提意见" action:@selector(feedback:)];
    [self.dataSource addObject:feedbackCellModel];
    XXCellModel *shareCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingEventCell" height:50 dataSource:@"分享APP给好友" action:@selector(shareApp:)];
    [self.dataSource addObject:shareCellModel];
//    XXCellModel *contactCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingEventCell" height:50 dataSource:@"联系我们" action:@selector(contactUS)];
//    [self.dataSource addObject:contactCellModel];
    
    [self.dataSource addObject:spaceCellModel];
    

    
    XXCellModel *cacheCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingValueCell" height:50 dataSource:@{@"title":@"清除缓存",@"value":[self cacheSize]} action:@selector(clearCache:)];
    [self.dataSource addObject:cacheCellModel];
    

    if(![VPUserManager sharedInstance].xx_userinfoID.length<1){
        [self.dataSource addObject:spaceCellModel];
        
        XXCellModel *noticeCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingSwitchCell" height:50 dataSource:@{@"title":@"接收推送消息",@"value":[NSNumber numberWithBool:[VPUserManager sharedInstance].xx_userInfo.isNotice]} action:nil];
        [self.dataSource addObject:noticeCellModel];
        
        XXCellModel *tallSpaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingSpaceCell" height:20 dataSource:nil action:nil];
        //    XXCellModel *tallSpaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingSpaceCell" height:125 dataSource:nil action:nil];
        [self.dataSource addObject:tallSpaceCellModel];
        
        XXCellModel *exitCellModel = [XXCellModel instantiationWithIdentifier:@"VPSettingExitCell" height:50 dataSource:@"退出当前账号" action:@selector(signOut:)];
        [self.dataSource addObject:exitCellModel];
    }
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}

- (NSString *)cacheSize{
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    NSString *cacheSize = tmpSize >= 1024 ? [NSString stringWithFormat:@"%.2fM",tmpSize/1024/1024] : [NSString stringWithFormat:@"%.2fK",tmpSize];
    return cacheSize;
}

- (void)updateCellModelForRowIndexPath:(NSIndexPath *)indexPath value:(id)value{
    XXCellModel *cellModel = [self.dataSource objectAtIndex:indexPath.row];
    NSMutableDictionary *valueDict = [cellModel.dataSource mutableCopy];
    valueDict[@"value"] = value;
    cellModel.dataSource = valueDict;
}

@end
