//
//  VPHotelUpSlideView.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPHotelRoomListRoomModel.h"

@protocol VPHotelRoomListUpSlideViewDelegate <NSObject>

-(void)roomListRoomModel:(VPHotelRoomListRoomModel *) roomListRoomModel;

- (void)VPHotelHeadViewSelectImage:(NSInteger)selectImageIndex roomListRoomModel:(VPHotelRoomListRoomModel *) roomListRoomModel;

@end

@interface VPHotelRoomListUpSlideView : UIView

- (void)showAnimation:(BOOL)animation;
- (void)hideAnimation:(BOOL)animation;

@property(strong, nonatomic)VPHotelRoomListRoomModel *hotelRoomListRoomModel;

@property(strong, nonatomic) id<VPHotelRoomListUpSlideViewDelegate>delegate;

@end
