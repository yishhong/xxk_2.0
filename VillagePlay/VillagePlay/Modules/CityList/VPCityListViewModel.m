//
//  VPCityListViewModel.m
//  VillagePlay
//
//  Created by Apricot on 16/11/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCityListViewModel.h"
#import "VPCityAPI.h"
#import "pinyin.h"
#import "VPOpenCityInfoModel.h"
#import "JPinYinUtil.h"

@interface VPCityListViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;

/**
 索引的数据数组
 */
@property (strong, nonatomic) NSMutableArray *indexArray;

@property (strong, nonatomic) NSMutableDictionary *cityListDict;

/**
 顶部
 */
@property (strong, nonatomic) NSMutableArray *topArray;

@property (strong, nonatomic) NSMutableDictionary *locationDict;

@property (strong, nonatomic) XXCellModel *cellModel;

/**
 当前选中的城市
 */
@property (strong, nonatomic) VPOpenCityInfoModel *selectCityModel;

@end

@implementation VPCityListViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.topArray = [NSMutableArray array];
        self.dataSource = [NSMutableArray array];
        self.cityListDict = [NSMutableDictionary dictionary];
        self.indexArray = [NSMutableArray array];
        self.locationDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)layerUI{
    self.selectCityModel = [[VPLocationManager sharedManager]  locationCoordinate2DWithType:self.locationType];
    [self.dataSource removeAllObjects];
    [self.topArray removeAllObjects];
    XXCellModel *locationTitleCellModel = [XXCellModel instantiationWithIdentifier:@"VPCityListTitleCell" height:23 dataSource:@"当前位置" action:nil];
    [self.topArray addObject:locationTitleCellModel];
    //1 定位 2 未定位
    //未开始定位
    self.locationDict[@"status"] = @"-1";
    self.locationDict[@"type"] = @(self.locationType);
    
    XXCellModel *locationCellModel = [XXCellModel instantiationWithIdentifier:@"VPCityListLocationCell" height:44 dataSource:self.locationDict action:nil];
    self.cellModel = locationCellModel;

    [self.topArray addObject:locationCellModel];
    XXCellModel *cityTitleCellModel = [XXCellModel instantiationWithIdentifier:@"VPCityListTitleCell" height:23 dataSource:@"城市列表" action:nil];
    [self.topArray addObject:cityTitleCellModel];
    [self.dataSource addObject:self.topArray];
}

- (void)loadDataSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    [[VPLocationManager sharedManager] loadRealCityListWithType:self.locationType success:^(NSArray *cityArray) {
        
        [self layerUI];
        
        NSMutableArray * openCityArray = [NSMutableArray array];
        openCityArray = [cityArray mutableCopy];
        
        NSMutableSet *set = [NSMutableSet set];
        for (VPOpenCityInfoModel *openCityModel in openCityArray) {
            NSString *key = [HTFirstLetter firstLetter:openCityModel.cityName];
            openCityModel.py = [HTFirstLetter firstLetters:openCityModel.cityName];
            [set addObject:key];
            NSMutableArray *array = [self.cityListDict objectForKey:key];
            if(!array){
                array = [NSMutableArray array];
            }
            [array addObject:openCityModel];
            [self.cityListDict setObject:array forKey:key];
        }
        //排序
        NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
        self.indexArray = [[set sortedArrayUsingDescriptors:sortDesc] mutableCopy];
        sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"py" ascending:YES]];
        VPOpenCityInfoModel *nationwideCityModel = nil;
        for (NSString *key in self.indexArray) {
            NSMutableArray *cityModelArray =  self.cityListDict[key];
            cityModelArray = [[cityModelArray sortedArrayUsingDescriptors:sortDesc] mutableCopy];
            NSMutableArray *keyWithCityArray = [NSMutableArray array];
            for (VPOpenCityInfoModel *model in cityModelArray) {
                XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPCityListNameCell" height:44 dataSource:model action:nil];
                if([model.vid isEqualToString:@"0"]){
                    nationwideCityModel = model;
                }else{
                    [keyWithCityArray addObject:cellModel];
                }
                if(self.selectCityModel.vid == model.vid){
                    self.selectCityModel = model;
                    model.isSelsct = YES;
                }else{
                    model.isSelsct = NO;
                }
            }
            [self.dataSource addObject:keyWithCityArray];
        }
        if(nationwideCityModel){
            //全国的放在前面
            XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPCityListNameCell" height:44 dataSource:nationwideCityModel action:nil];
            [self.topArray addObject:cellModel];
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSArray *)sectionIndexTitles{
    return self.indexArray;
}
- (NSString *)sectionIndexTitleWithSection:(NSInteger)section{
    return self.indexArray[section];
}

- (NSInteger)numberOfSections{
    return [self.dataSource count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [[self.dataSource objectAtIndex:section] count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.section][indexPath.row];
}

@end
