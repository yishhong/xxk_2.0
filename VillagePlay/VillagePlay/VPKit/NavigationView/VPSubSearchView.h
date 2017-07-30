//
//  VPSubSearchView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//  子页面的搜索

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(NSInteger tag);

@interface VPSubSearchView : UIView

@property (nonatomic, strong) UIButton *searchButton;

- (void)layerUIBlock:(TapBlock)tapBlock;

@end
