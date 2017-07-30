//
//  HBPhotoCollectionPreviewController.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/22.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMPhotoCollectionPreviewController.h"
#import "QMPhotoCollectionPreviewCell.h"
#import "UIColor+HUE.h"

@interface QMPhotoCollectionPreviewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation QMPhotoCollectionPreviewController

static NSString * const reuseIdentifier = @"QMPhotoCollectionPreviewCell";

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PhotoPreview" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.edgesForExtendedLayout =UIRectEdgeNone;
    self.title = @"预览";
    
    //设置布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 0.0f;
    flow.minimumLineSpacing = 0.0f;
    flow.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    
    [self.collectionView setCollectionViewLayout:flow];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.navigationItem.rightBarButtonItem = self.rightButton;
    //设置偏移
    [self.collectionView setContentSize:CGSizeMake(self.totalCount()*flow.itemSize.width, 0)];
    [self.collectionView setContentOffset:CGPointMake(flow.itemSize.width*self.selectedIndex, 0) animated:NO];
}

-(UIBarButtonItem *)rightButton{
    UIButton * customButton =[UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame =CGRectMake(0, 0, 40, 30);
    customButton.titleLabel.font =[UIFont systemFontOfSize:15];
    [customButton setTitleColor:[UIColor navigationTintColor] forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    [customButton setTitle:@"删除" forState:UIControlStateNormal];
    UIBarButtonItem *filterBarButton =[[UIBarButtonItem alloc]initWithCustomView:customButton];
    return filterBarButton;
}
- (void)deleteImage{
    NSAssert(self.removeImageAtIndex, @"必须设置删除图片的方法");
    if(self.totalCount() == 0){
        return;
    }
    NSLog(@"测试");
    UICollectionViewCell *cell = [self.collectionView.visibleCells firstObject];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    self.removeImageAtIndex(indexPath.row);
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    //如果图片已经被全部删除，则直接返回
    if (self.totalCount() == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSAssert(self.totalCount, @"必须设置图片总数的方法");
    return self.totalCount();
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QMPhotoCollectionPreviewCell *cell = (QMPhotoCollectionPreviewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSAssert(self.imageForIndex, @"必须获取图片的方法");
    id imageObject = self.imageForIndex(indexPath.row);
    if([imageObject isKindOfClass:[UIImage class]]){
        cell.imageView.image = imageObject;
    }
    return cell;
}

@end
