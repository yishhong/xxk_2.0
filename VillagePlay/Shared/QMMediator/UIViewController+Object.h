//
//  UIViewController+Object.h
//  VillagePlay
//
//  Created by Apricot on 16/6/25.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Object)

+ (instancetype)instantiation;

@property (nonatomic, strong) NSDictionary* associatedObject;
@end
