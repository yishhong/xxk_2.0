//
//  VPHotelInformationViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPHotelDetailModel.h"

@interface VPHotelInformationViewModel : NSObject

/**
 民宿信息

 @param hotelInforMationModel 数据源
 */
-(void)hotelInforMationModel:(VPHotelDetailModel *)hotelInforMationModel;


/**
 返回节

 @param section 节
 @return NSInteger
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;


/**
 每一节多少行

 @param row 行
 @param section 节
 @return XXCellModel
 */
-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

@end
