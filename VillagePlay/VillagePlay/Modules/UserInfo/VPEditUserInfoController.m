//
//  VPEditUserInfoController.m
//  VillagePlay
//
//  Created by Apricot on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPEditUserInfoController.h"
#import "VPEditUserInfoViewModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "UIBarButtonItem+Custom.h"
#import "MBProgressHUD+Loading.h"
#import "UIScrollView+Refresh.h"
#import "NSError+Reason.h"
#import "UIAlertController+Camera.h"
#import <AVFoundation/AVFoundation.h>

#import "VPUserOccupationView.h"
#import "VPUserBirthdateView.h"
#import "VPUserSexView.h"
#import "VPUserCityView.h"
#import "QMImagePicker.h"
#import "QMAssetsPicker.h"

@interface VPEditUserInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VPEditUserInfoViewModel *viewModel;

@property (nonatomic, strong) QMImagePicker *imagePicker;
@property (strong, nonatomic) QMAssetsPicker *assetsPicker;

@end

@implementation VPEditUserInfoController


+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserInfo" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改资料";
    self.viewModel = [[VPEditUserInfoViewModel alloc] init];
    [self.viewModel layerUI];
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRows];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    return cellModel.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:[self.viewModel cellModelForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([self respondsToSelector:cellModel.action]){
        [self performSelector:cellModel.action withObject:indexPath];
    }
}

- (void)save{
    [self.view endEditing:YES];
    //保存
    [MBProgressHUD showLoading];
    [self.viewModel updateUserInfoSuccess:^{
        [MBProgressHUD showTip:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

- (void)photo:(NSIndexPath *)indexPath{
   UIAlertController * alertController = [UIAlertController selectCameraOrPhotoBlock:^(NSInteger index) {
        if(index==0){
            //相机
            [self pickImageFromCamera];
        }else{
            //相册
            [self pickImageFromAlbum];
        }
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)pickImageFromCamera{
    
    if(!self.imagePicker){
        self.imagePicker = [[QMImagePicker alloc] init];
    }
    [self.imagePicker imagePickerWithController:self block:^(BOOL isSourceTypeAvailable, AVAuthorizationStatus authorizationStatus, UIImage *image) {
        if(isSourceTypeAvailable){
            if(authorizationStatus == AVAuthorizationStatusAuthorized){
                if(image){
                    //转换图片
                     [self.viewModel selectPhotoImage:image];
                    [self.tableView reloadData];
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
    [self.assetsPicker showAssetsPickerWithController:self amount:1 isReserve:NO withBlock:^(PHAuthorizationStatus status, NSArray *images) {
        if(status != PHAuthorizationStatusAuthorized){
            //提示用户
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"相机授权" message:@"没有权限访问您的相机，请在“设置－隐私－相册”中允许使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alterView show];
            return ;
        }else{
            UIImage * image = [images lastObject];
            [self.viewModel selectPhotoImage:image];
            [self.tableView reloadData];
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
- (void)sex:(NSIndexPath *)indexPath{
//    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    //性别
    [[VPUserSexView instantiation] showViewWithNowSelectSex:self.viewModel.userModel.sex Block:^(NSString *sex) {
        self.viewModel.userModel.sex = sex;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)birthday:(NSIndexPath *)indexPath{
    //出生年月日
    [[VPUserBirthdateView instantiation] showViewWithNowSelectDate:self.viewModel.userModel.birthday Block:^(NSString *birthdate) {
        self.viewModel.userModel.birthday = birthdate;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)area:(NSIndexPath *)indexPath{
    //所在地
    [[VPUserCityView instantiation] showViewWithNowSelectCity:self.viewModel.userModel.area Block:^(NSString *province, NSString *city) {
        self.viewModel.userModel.provinceID = province;
        self.viewModel.userModel.cityID = city;
        self.viewModel.userModel.area = [NSString stringWithFormat:@"%@%@",province,city];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
}

- (void)occupation:(NSIndexPath *)indexPath{
    
    //职业
    VPUserOccupationView *occupationView = [VPUserOccupationView instantiation];
    [occupationView showViewBlock:^(NSString *occupation) {
        self.viewModel.userModel.occupation = occupation;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
