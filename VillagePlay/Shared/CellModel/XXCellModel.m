//
//  XXCellModel.m
//  VillagePlay
//
//  Created by Apricot on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "XXCellModel.h"

@implementation XXCellModel

+(instancetype)instantiationWithIdentifier:(NSString *)identifier height:(CGFloat)height dataSource:(id)dataSource action:(SEL)action{
    XXCellModel *model = [[XXCellModel alloc] init];
    model.identifier = identifier;
    model.height = height;
    model.dataSource = dataSource;
    model.action = action;
    return model;
}

@end
