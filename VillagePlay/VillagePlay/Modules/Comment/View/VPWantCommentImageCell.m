//
//  VPWantCommentImageCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPWantCommentImageCell.h"
#import "VPCollectionCommentImageCell.h"
#import "UICollectionViewCell+DataSource.h"
#import "UIAlertController+Camera.h"
#import "QMImagePicker.h"
#import "QMAssetsPicker.h"
#import "QMPhotoCollectionPreviewController.h"
#import "VPTabBarController.h"
#import "VPNavigationController.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPPostCommenModel.h"

#define MAXImageCount 9

@interface VPWantCommentImageCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) QMImagePicker *imagePicker;
@property (strong, nonatomic) QMAssetsPicker *assetsPicker;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) QMPhotoCollectionPreviewController * photoCollectionPerview;
@end

@implementation VPWantCommentImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageArray = [NSMutableArray array];
    // Initialization code
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(69, 69);
    layout.minimumLineSpacing = 14;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection= UICollectionViewScrollDirectionHorizontal;
    self.collectionVIew.collectionViewLayout = layout;
    self.collectionVIew.backgroundColor = [UIColor whiteColor];
    self.collectionVIew.delegate = self;
    self.collectionVIew.dataSource = self;
    self.lb_title.text = @"已选0张,最多可选9张";
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    self.imageArray = cellModel.dataSource;
    if([self.imageArray count]==0){
        [self.imageArray addObject:@{@"type":@0,@"image":[UIImage imageNamed:@"btn_photo_add"]}];
    }
    [self.collectionVIew reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageArray count]>MAXImageCount?MAXImageCount:[self.imageArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VPCollectionCommentImageCell" forIndexPath:indexPath];
    [cell xx_configCellWithEntity:self.imageArray[indexPath.row]];
    return cell;
}


//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 14, 0, 14);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *imageInfo = [self.imageArray objectAtIndex:indexPath.row];
    if(![imageInfo[@"type"] isEqual:@(0)]){
        [self showIndex:indexPath.row];
        return;
    }
    
    UIAlertController * alertController = [UIAlertController selectCameraOrPhotoBlock:^(NSInteger index) {
        if(index==0){
            //相机
            [self pickImageFromCamera];
        }else{
            //相册
            [self pickImageFromAlbum];
        }
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}



- (void)pickImageFromCamera{
    
    if(!self.imagePicker){
        self.imagePicker = [[QMImagePicker alloc] init];
    }
    [self.imagePicker imagePickerWithController:[UIApplication sharedApplication].keyWindow.rootViewController block:^(BOOL isSourceTypeAvailable, AVAuthorizationStatus authorizationStatus, UIImage *image) {
        if(isSourceTypeAvailable){
            if(authorizationStatus == AVAuthorizationStatusAuthorized){
                if(image){
                    //转换图片
                    [self.imageArray insertObject:@{@"type":@1,@"image":image} atIndex:0];
                    [self.collectionVIew reloadData];
                    
                    self.lb_title.text = [NSString  stringWithFormat:@"已选%zd张,最多可选9张",[self.imageArray count]>MAXImageCount?MAXImageCount:[self.imageArray count]-1];

//                    [self.viewModel selectPhotoImage:image];
//                    [self.tableView reloadData];
                }
            }else{
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"相机授权" message:@"没有权限访问您的相机，请在“设置－隐私－相机”中允许使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alterView show];
            }
        }else{
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您的设置暂不支持相机功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
    }];
    
}

-(void)pickImageFromAlbum{
    //利用第三方的相册选择
    if(!self.assetsPicker){
        self.assetsPicker = [[QMAssetsPicker alloc] init];
    }
    //    self.assetsPicker.maxNumber = [self.viewModel selectImageCount];
    [self.assetsPicker showAssetsPickerWithController:[UIApplication sharedApplication].keyWindow.rootViewController amount:9-[self.imageArray count]+1 isReserve:NO withBlock:^(PHAuthorizationStatus status, NSArray *images) {
        if(status != PHAuthorizationStatusAuthorized){
            //提示用户
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"相册授权" message:@"没有权限访问您的相册，请在“设置－隐私－相册”中允许使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alterView show];
            return ;
        }else{
            NSInteger i = 0;
            for (UIImage *image in images) {
                [self.imageArray insertObject:@{@"type":@1,@"image":image} atIndex:i];
                i++;
            }
            [self.collectionVIew reloadData];
            self.lb_title.text = [NSString  stringWithFormat:@"已选%zd张,最多可选9张",[self.imageArray count]>MAXImageCount?MAXImageCount:[self.imageArray count]-1];

//            [self.viewModel selectPhotoImage:image];
//            [self.tableView reloadData];
        }
    }];
    //    [self.assetsPicker showAssetsPickerWithController:self withBlock:^(PHAuthorizationStatus status, NSArray *images) {
    //
    //        //这里获取取到的图片数据
    ////        [self.viewModel addImages:images];
    //        //这里后续修改成刷新指定行的数据
    ////        [self.tableView reloadData];
    //    }];
}



- (void)showIndex:(NSInteger)index{
//    预览
    if(self.photoCollectionPerview){
        self.photoCollectionPerview = nil;
    }
    QMPhotoCollectionPreviewController *photoCollectionPerview = [QMPhotoCollectionPreviewController instantiation];
    self.photoCollectionPerview = photoCollectionPerview;
    __weak typeof(VPWantCommentImageCell) * weakSelf = self;

    self.photoCollectionPerview.selectedIndex = index;
    self.photoCollectionPerview.totalCount= ^NSInteger{
        if([weakSelf.imageArray count]==1){
            return 0;
        }
        return [weakSelf.imageArray count]>MAXImageCount?MAXImageCount:[weakSelf.imageArray count]-1;
    };
    self.photoCollectionPerview.imageForIndex = ^ id (NSInteger index){
        if(index>[weakSelf.imageArray count]){
            return nil;
        }
        return [weakSelf.imageArray objectAtIndex:index][@"image"];
    };
    
    self.photoCollectionPerview.removeImageAtIndex = ^(NSInteger index){
        
        if([weakSelf.imageArray count]==1){
            return ;
        }
        [weakSelf.imageArray removeObjectAtIndex:index];
        
        [weakSelf.collectionVIew reloadData];
    };
    VPTabBarController *tabBarVC = (VPTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    VPNavigationController * navigationVC = [tabBarVC.viewControllers objectAtIndex:0];
    [navigationVC pushViewController:self.photoCollectionPerview animated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
