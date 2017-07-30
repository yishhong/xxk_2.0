//
//  QMAssetsPicker.h
//  HotelBusiness
//
//  Created by Apricot on 16/8/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CTAssetsPickerController/CTAssetsPickerController.h>

typedef void(^AssetsPickerBlock)(PHAuthorizationStatus status ,NSArray *images);

@interface QMAssetsPicker : NSObject

/**
 *  最大的数值 默认为9
 */
@property (nonatomic, assign) NSInteger maxNumber;

- (void)showAssetsPickerWithController:(UIViewController *)viewController amount:(NSInteger)amount isReserve:(BOOL)isReserve withBlock:(AssetsPickerBlock)block;
/**
 *  删除图片
 *
 *  @param index 图片的坐标
 */
- (void)removeImage:(NSInteger)index;
@end
