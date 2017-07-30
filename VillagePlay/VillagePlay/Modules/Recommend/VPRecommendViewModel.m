//
//  VPRecommendViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPRecommendViewModel.h"
#import "VPMainAPI.h"
#import "VPRecommendModel.h"
#import "QMCalendarFunction.h"
#import "VPVersionAPI.h"
#import "InfoPlist.h"

@interface VPRecommendViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) VPMainAPI *mainAPI;
@property (strong, nonatomic) VPVersionAPI *versionAPI;

@property (strong, nonatomic) VPRecommendModel * recommendModel;
@property (strong, nonatomic) QMCalendarFunction * calendarFunction;

@end

@implementation VPRecommendViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.calendarFunction =[[QMCalendarFunction alloc]init];
        self.mainAPI = [[VPMainAPI alloc] init];
        self.versionAPI = [[VPVersionAPI alloc] init];
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)loadVersionSuccess:(void(^)(BOOL))success failure:(void(^)(NSError * error))failure{
    
    if(_versionModel){
        success([self isUpdate]);
        return;
    }
    
    [self.versionAPI loadVersionAPISuccess:^(NSDictionary *responseDict) {
        _versionModel = [VPVersionModel yy_modelWithJSON:responseDict[@"body"]];
        success([self isUpdate]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//是否更新
- (BOOL)isUpdate{
    BOOL isUpdate = self.versionModel.state;
    if(isUpdate){
        isUpdate =  self.versionModel.editionNum > [[InfoPlist buildVersion] integerValue]?YES:NO;
    }
    return isUpdate;
}

- (void)loadDataSuccess:(void(^)())success failure:(void(^)(NSError * error))failure{

    [self.mainAPI loadMainListWithParams:nil success:^(NSDictionary *responseDict) {
        self.recommendModel = [VPRecommendModel yy_modelWithDictionary:responseDict[@"body"]];
        [self layerUI];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 创建Title标签数据

 @param title 主标题
 @param subTitle 副标题
 @return 返回数据字典
 */
- (NSMutableDictionary *)titleDictWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    NSMutableDictionary *travelDict = [NSMutableDictionary dictionary];
    travelDict[@"title"] = title;
    travelDict[@"subTitle"] = subTitle;
    return travelDict;
}

- (void)configBanner{
    XXCellModel *bannerModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendBannerCell" height:210 dataSource:self.recommendModel.banner action:nil];
    bannerModel.title = @"推荐";
    [self.dataSource addObject:bannerModel];
}

- (void)configOptions{
    
    NSMutableArray *optionsArray = [NSMutableArray array];
    [optionsArray addObject:@{@"title":@"旅游",@"icon":@"vp_btn_recommend_travel",@"action":@"menuTravel"}];
    [optionsArray addObject:@{@"title":@"民宿",@"icon":@"vp_btn_recommend_hotel",@"action":@"menuHotel"}];
    [optionsArray addObject:@{@"title":@"门票",@"icon":@"vp_btn_recommend_ticket",@"action":@"menuTicket"}];

    XXCellModel *menuModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendMenuCell" height:95 dataSource:optionsArray action:nil];
    [self.dataSource addObject:menuModel];
}

/**
 添加间隔的Cell
 */
- (void)addCellSpaceModel{
    XXCellModel *spaceModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:10 dataSource:nil action:nil];
    [self.dataSource addObject:spaceModel];
}

/**
 布局旅游
 */
- (void)configTravel{
//                @"hotActive"  旅游
    if(!self.recommendModel.hotActive||[self.recommendModel.hotActive count]==0){
        return;
    }
    [self addCellSpaceModel];
    NSMutableDictionary *titleDict = [self titleDictWithTitle:@"旅游活动" subTitle:@"精彩纷呈，乐活无限"];
    XXCellModel *recommendTitleModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendTitleCell" height:80 dataSource:titleDict action:@selector(travelList)];
    [self.dataSource addObject:recommendTitleModel];
    for (int i =0 ; i<[self.recommendModel.hotActive count]; i++) {
        XXCellModel *travelModel = [XXCellModel instantiationWithIdentifier:@"VPTravelTableViewCell" height:340 dataSource:[self.recommendModel.hotActive objectAtIndex:i] action:nil];
        [self.dataSource addObject:travelModel];
    }
}



/**
 布局专题
 */
- (void)configTopic{
//            @"hotProject" 专题
    if(!self.recommendModel.hotProject||[self.recommendModel.hotProject count]==0){
        return;
    }
    [self addCellSpaceModel];
    NSMutableDictionary *titleDict = [self titleDictWithTitle:@"精选专题" subTitle:@"有料有趣，懂你助你"];

    XXCellModel *topicsTitleModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendTitleCell" height:80 dataSource:titleDict action:@selector(menuTopic)];
    [self.dataSource addObject:topicsTitleModel];
    
    for (int i = 0 ; i < [self.recommendModel.hotProject count]; i++) {
        XXCellModel *topicModel = [XXCellModel instantiationWithIdentifier:@"TopicTableViewCell" height:197 dataSource:[self.recommendModel.hotProject objectAtIndex:i] action:nil];
        [self.dataSource addObject:topicModel];
    }
}

/**
 布局微刊
 */
- (void)configWeik{
    if(!self.recommendModel.weikan||[self.recommendModel.weikan count]==0){
        return;
    }
    [self addCellSpaceModel];
    NSMutableDictionary *titleDict = [self titleDictWithTitle:@"乡秀微刊" subTitle:@"美的感悟，识微见远"];
    XXCellModel *weikanTitleModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendTitleCell" height:80 dataSource:titleDict action:@selector(menuWeikan)];
    [self.dataSource addObject:weikanTitleModel];
    
    for (int i = 0 ; i < [self.recommendModel.weikan count]; i++) {
        XXCellModel *topicModel = [XXCellModel instantiationWithIdentifier:@"VPVickersTableViewCell" height:177 dataSource:[self.recommendModel.weikan objectAtIndex:i] action:nil];
        [self.dataSource addObject:topicModel];
    }
}

/**
 布局直播
 */
- (void)configLive{
//            @"liveList"   直播
    if(!self.recommendModel.liveList||[self.recommendModel.liveList count] == 0){
        return ;
    }
    [self addCellSpaceModel];
    NSMutableDictionary *titleDict = [self titleDictWithTitle:@"旅行直播" subTitle:@"精彩旅途，实时分享"];

    XXCellModel *liveTitleModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendTitleCell" height:80 dataSource:titleDict action:@selector(menuLive)];
    [self.dataSource addObject:liveTitleModel];
    NSInteger count = [self.recommendModel.liveList count];
    
    for (int i =0 ; i< count; i+=2) {
        NSMutableDictionary *liveModelDict = [NSMutableDictionary dictionary];
        liveModelDict[@"left"] = self.recommendModel.liveList[i];
        if(i+1<count){
            liveModelDict[@"right"] = self.recommendModel.liveList[i+1];
        }
        XXCellModel *liveModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendLiveCell" height:272 dataSource:liveModelDict action:nil];
        [self.dataSource addObject:liveModel];
    }
}

/**
 布局村庄
 */
- (void)configVillage{
//            @"hotVillage" 乡村
    if(!self.recommendModel.hotVillage||[self.recommendModel.hotVillage count]==0){
        return;
    }
    [self addCellSpaceModel];
    NSMutableDictionary *titleDict = [self titleDictWithTitle:@"最美乡村" subTitle:@"寻寻觅觅，只为遇见"];
    XXCellModel *villageTitleModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendTitleCell" height:80 dataSource:titleDict action:@selector(menuVillage)];
    [self.dataSource addObject:villageTitleModel];
    
    NSInteger count = [self.recommendModel.hotVillage count];
    for (int i =0 ; i< count; i+=2) {
        NSMutableDictionary *villageModelDict = [NSMutableDictionary dictionary];
        VPVillageModel *leftVillageModel = self.recommendModel.hotVillage[i];
        
        villageModelDict[@"left"] = leftVillageModel;
        if(i+1<count){
            VPVillageModel *rightVillageModel = self.recommendModel.hotVillage[i+1];
            villageModelDict[@"right"] = rightVillageModel;
        }
        XXCellModel *villageModel = [XXCellModel instantiationWithIdentifier:@"VPRecommendVillageCell" height:272 dataSource:villageModelDict action:nil];
        [self.dataSource addObject:villageModel];
    }
}

- (void)layerUI{
    [self.dataSource removeAllObjects];
    [self configBanner];
    [self configOptions];
    [self configTravel];
    [self configTopic];
    [self configWeik];
    [self configLive];
    [self configVillage];
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}

//TODO:这里需要修改 统一一个模式
- (NSDictionary *)dateTimeInfo{
    
    //使用日期
    NSString * todayString =[self.calendarFunction getCurrentTime];
    NSString * tomorrowDayString =[self.calendarFunction GetTomorrowDay:[NSDate date]];
    //转成MM-dd
    NSString * todayTime =[self.calendarFunction currentDatefromString:todayString];
    NSString *tomorrowTime =[self.calendarFunction currentDatefromString:tomorrowDayString];
    NSDictionary *dateInfo=@{@"todayDate":todayString,
                             @"tomorrowDate":tomorrowDayString,
                             @"todayTime":todayTime,
                             @"tomorrowTime":tomorrowTime};
    return dateInfo;
}

@end
