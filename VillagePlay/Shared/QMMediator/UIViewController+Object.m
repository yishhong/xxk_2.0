//
//  UIViewController+Object.m
//  VillagePlay
//
//  Created by Apricot on 16/6/25.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "UIViewController+Object.h"
#import <objc/runtime.h>

#define KAssociatedObject "associatedObject"

@implementation UIViewController (Object)


+ (instancetype)instantiation{
    return [[UIViewController alloc] init];
}


- (void)setAssociatedObject:(id)associatedObject{
//    objc_setAssociatedObject(self, KAssociatedObject, associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, KAssociatedObject, associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)associatedObject{
    return objc_getAssociatedObject(self, KAssociatedObject);
}
@end
