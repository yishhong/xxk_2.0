//
//  VPAloneSearchView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)();

@interface VPAloneSearchView : UIView

@property (nonatomic, strong) UIButton *searchButton;


- (void)layerUIBlock:(TapBlock)tapBlock;

@end
