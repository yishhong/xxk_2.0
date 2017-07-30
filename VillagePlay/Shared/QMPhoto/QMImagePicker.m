//
//  QMImagePicker.m
//  Photo
//
//  Created by Apricot on 2016/12/16.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMImagePicker.h"

@interface QMImagePicker ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, copy) ImagePickerBlock  imagePickerBlock;

@end

@implementation QMImagePicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)imagePickerWithController:(UIViewController *)vc block:(ImagePickerBlock)imagePickerBlock{
    if(imagePickerBlock){
        if(self.imagePickerBlock){
            self.imagePickerBlock = nil;
        }
        self.imagePickerBlock = imagePickerBlock;
    }
    
    UIImagePickerControllerSourceType  sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //判断是否有访问相机权限
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        switch (authorizationStatus) {
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:{
                if(self.imagePickerBlock){
                    self.imagePickerBlock(YES, authorizationStatus, nil);
                }
                return;
            }break;
            default:
                break;
        }
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.delegate = self;
        self.imagePickerController.allowsEditing = YES;
        self.imagePickerController.sourceType = sourceType;
        [vc presentViewController:self.imagePickerController animated:YES completion:nil];
    }else{
        if(self.imagePickerBlock){
            self.imagePickerBlock(NO,AVAuthorizationStatusNotDetermined,nil);
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]){
        NSString *key = nil;
        if (picker.allowsEditing){
            key = UIImagePickerControllerEditedImage;
        }
        else{
            key = UIImagePickerControllerOriginalImage;
        }
        
        UIImage *image = [info objectForKey:key];
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            if (image != nil){
                //这里可以处理图片
                if(self.imagePickerBlock){
                    self.imagePickerBlock(YES, AVAuthorizationStatusAuthorized, image);
                }
            }
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    self.imagePickerController.delegate = nil;
    self.imagePickerBlock = nil;
}

@end
