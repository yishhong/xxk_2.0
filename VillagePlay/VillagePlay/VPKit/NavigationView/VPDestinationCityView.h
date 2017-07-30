//
//  VPDestinationCityView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)();

@interface VPDestinationCityView : UIView

@property (nonatomic, strong) UIButton *cityButton;

- (void)layerUIBlock:(TapBlock)tapBlock;


@end
