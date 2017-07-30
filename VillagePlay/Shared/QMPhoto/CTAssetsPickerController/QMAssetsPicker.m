//
//  QMAssetsPicker.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMAssetsPicker.h"
#import "CTAssetsPickerController+Custom.h"

@interface QMAssetsPicker ()<CTAssetsPickerControllerDelegate>
@property (nonatomic, copy) AssetsPickerBlock pickerBlock;
@property (nonatomic, strong) NSMutableArray *selectImages;
@end

@implementation QMAssetsPicker
- (instancetype)init{
    self = [super init];
    if (self) {
        self.maxNumber = 9;
        [CTAssetsPickerController customView];
        self.selectImages = [NSMutableArray array];
    }
    return self;
}
- (void)removeImage:(NSInteger)index{
    [self.selectImages removeObjectAtIndex:index];
}

- (void)showAssetsPickerWithController:(UIViewController *)viewController amount:(NSInteger)amount isReserve:(BOOL)isReserve withBlock:(AssetsPickerBlock)block{
    self.maxNumber = amount;
    if(block){
        self.pickerBlock = nil;
        self.pickerBlock = block;
    }
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        if (status != PHAuthorizationStatusAuthorized){
            self.pickerBlock(status,nil);
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            // 设置delegate
            
            picker.delegate = self;
            picker.showsSelectionIndex = YES;
            if(isReserve){
                picker.selectedAssets = [self.selectImages mutableCopy];
            }else{
                [self.selectImages removeAllObjects];
            }
            picker.alwaysEnableDoneButton = YES;
            //是否显示取消按钮
            picker.showsCancelButton = YES;
            picker.assetCollectionSubtypes = @[
                                               @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                               //最近添加
                                               @(PHAssetCollectionSubtypeSmartAlbumRecentlyAdded),
                                               @(PHAssetCollectionSubtypeSmartAlbumGeneric),
                                               @(PHAssetCollectionSubtypeAlbumRegular),
                                               ];
            // Optionally present picker as a form sheet on iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                picker.modalPresentationStyle = UIModalPresentationFormSheet;
            // present picker
            [viewController presentViewController:picker animated:YES completion:nil];
        });
    }];
    
}
//选中图片
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset{
    NSInteger max = self.maxNumber;
    if (picker.selectedAssets.count < max){
        
        return YES;
    }
    //初步部分提示用户
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意"
                                                                   message:[NSString stringWithFormat:@"最多选择%zd张图片", max]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
    [picker presentViewController:alert animated:YES completion:nil];
    return NO;
}

//- (void)assetsPickerController:(CTAssetsPickerController *)picker didDeselectAsset:(PHAsset *)asset{
//    [self.selectImages removeObject:asset];
//}

//选择完成
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    self.selectImages = [assets mutableCopy];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    [options setSynchronous:NO];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.networkAccessAllowed = YES;
    //创建队列
    dispatch_group_t group = dispatch_group_create();
    
    NSMutableArray * imageArray = [NSMutableArray array];
    //数组提前占位
    for (PHAsset * _  in assets) {
        [imageArray addObject:[NSNull null]];
    }
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / [UIScreen mainScreen].scale, asset.pixelHeight / [UIScreen mainScreen].scale);
        dispatch_group_enter(group);
        // 请求图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                imageArray[i] = result;
                dispatch_group_leave(group);
            }
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //通过block 返回这个数组
        self.pickerBlock(PHAuthorizationStatusAuthorized,imageArray);
    });
}
@end
