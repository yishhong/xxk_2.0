//
//  VPDriveControllerViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPDriveControllerViewModel : NSObject

/**
 出行线路Model

 @param driveLineString 自驾游线路
 @param ohterLineString 其他线路
 */
- (void)villageDriveLineString:(NSString *)driveLineString villageOhterLineString:(NSString *)ohterLineString;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

@end
