//
//  NSObject+KVO.m
//  DTUtils
//
//  Created by zhaojh on 20/10/14.
//  Copyright (c) 2014年 zjh. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>

static void *NSObjectKVOControllerKey = &NSObjectKVOControllerKey;
static void *NSObjectKVOControllerNonRetainingKey = &NSObjectKVOControllerNonRetainingKey;

@implementation NSObject (KVO)

- (FBKVOController *)KVOController
{
    id controller = objc_getAssociatedObject(self, NSObjectKVOControllerKey);
    
    // lazily create the KVOController
    if (nil == controller) {
        controller = [FBKVOController controllerWithObserver:self];
        self.KVOController = controller;
    }
    
    return controller;
}

- (void)setKVOController:(FBKVOController *)KVOController
{
    objc_setAssociatedObject(self, NSObjectKVOControllerKey, KVOController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FBKVOController *)KVOControllerNonRetaining
{
    id controller = objc_getAssociatedObject(self, NSObjectKVOControllerNonRetainingKey);
    
    if (nil == controller) {
        controller = [[FBKVOController alloc] initWithObserver:self retainObserved:NO];
        self.KVOControllerNonRetaining = controller;
    }
    
    return controller;
}

- (void)setKVOControllerNonRetaining:(FBKVOController *)KVOControllerNonRetaining
{
    objc_setAssociatedObject(self, NSObjectKVOControllerNonRetainingKey, KVOControllerNonRetaining, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
