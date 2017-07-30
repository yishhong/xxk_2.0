//
//  VPHotelPayView.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPHotelRoomListRoomModel.h"

@protocol VPHotelPayViewDelegate <NSObject>

-(void)paymentView;

@end

@interface VPHotelPayView : UIView

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UIButton *payButton;
@property (strong, nonatomic) id<VPHotelPayViewDelegate>delegate;

@property (strong, nonatomic) NSString *isReserveRoom;

@end
