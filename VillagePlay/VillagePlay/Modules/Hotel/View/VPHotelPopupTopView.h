//
//  VPHotelPopupTopView.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/23.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseBlock)();

@interface VPHotelPopupTopView : UIView

@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) UIButton *closeButton;

- (void)tapClose:(CloseBlock)closeBlock;

@end
