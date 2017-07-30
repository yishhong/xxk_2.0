//
//  VPLiveViewController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveViewController.h"
#import "VPLiveCollectionViewCell.h"
#import "VPLiveDetailController.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPLiveViewModel.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPLiveInfoModel.h"
#import "UIViewController+Empty.h"

#define Main_Screen_Height      [UIScreen mainScreen].bounds.size.height
#define Main_Screen_Width       [UIScreen mainScreen].bounds.size.width

@interface VPLiveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong ,nonatomic) VPLiveViewModel *viewModel;
@end

@implementation VPLiveViewController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Live" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"直播";
    self.viewModel =[[VPLiveViewModel alloc]init];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VPLiveCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([VPLiveCollectionViewCell class])];
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset =UIEdgeInsetsMake(12, 12, 0, 12);
    flowLayout.minimumLineSpacing=12;
    flowLayout.minimumInteritemSpacing=12;
    self.collectionView.collectionViewLayout =flowLayout;
    [self.collectionView xx_addHeaderRefreshWithBlock:^{
        [self loadDataWithIsFirst:YES];
    }];
//    [self.collectionView xx_beginRefreshing];
    [self.collectionView xx_addFooterRefreshWithBlock:^{
        [self loadDataWithIsFirst:NO];
    }];
    
    [MBProgressHUD showLoading];
    [self loadDataWithIsFirst:YES];
    
}

- (void)loadDataWithIsFirst:(BOOL)isFirst{
    [self.viewModel liveListIsFirstLoading:isFirst success:^(BOOL isMore) {
        [self isShowViewType:1 message:@""];
        [self.collectionView xx_isHasMoreData:isMore];
        [self.collectionView reloadData];
        [self.collectionView reloadEmptyDataSet];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [self isShowViewType:error.code message:error.errorMessage];
        [self.collectionView reloadEmptyDataSet];
        [self.collectionView xx_endRefreshing];
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.viewModel numberOfRowsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row];
    UICollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellModel.identifier forIndexPath:indexPath];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

#pragma  mark -UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row];
    VPLiveInfoModel *liveInfoModel =cellModel.dataSource;
    VPLiveDetailController *liveDetailController =[VPLiveDetailController instantiation];
    liveDetailController.liveInfoModel =liveInfoModel;
    [self.navigationController pushViewController:liveDetailController animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row];
    return CGSizeMake((Main_Screen_Width-36)/2, cellModel.height);
}

@end
