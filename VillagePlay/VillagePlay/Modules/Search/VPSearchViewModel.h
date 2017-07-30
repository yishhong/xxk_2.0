//
//  VPSearchViewModel.h
//  VillagePlay
//
//  Created by Apricot on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

typedef enum : NSUInteger {
    SearchTypeAll = 0,
    SearchTypeHotel,
    SearchTypeVillage,
    SearchTypeTicket,
    SearchTypeTravel,
} SearchType;


@interface VPSearchViewModel : NSObject

@property (nonatomic, copy) NSString *searchText;

@property (assign, nonatomic) SearchType searchType;

@property (copy, nonatomic) NSString * cityID;

/**
 返回Section数

 @return 返回section数
 */
- (NSInteger)numberOfSections;
/**
 返回指定cell数目

 @param section section
 @return 返回Cell条目
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  获取指定行的cell
 *
 *  @param indexPath cell的坐标
 *
 *  @return 返回指定行的cellModel
 */
- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath;



/**
 获取搜索

 @param isFirst 是否第一次加载
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadSearchWithIsFirs:(BOOL)isFirst success:(void(^)(BOOL isMore,NSString *message))success failure:(void(^)(NSError * error))failure;

/**
 获取今天和明天的时间
 
 @return 返回字典
 */
- (NSDictionary*)dateTimeInfo;

@end
