//
//  VPParentClassScrollViewController.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "VPBaseViewController.h"

@interface VPParentClassScrollController : VPBaseViewController

@property(strong, nonatomic)UIScrollView *scrollView;
@property (nonatomic, assign) BOOL canScroll;

@end
