//
//  VPaddMoreTiketListViewModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"

@interface VPaddMoreTiketListViewModel : NSObject

-(void)tiketAddMoreTiketListModel:(NSArray *)addMoreTiketListModel;

-(NSInteger)numberOfRowsInSection:(NSInteger)section;

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;

@end
