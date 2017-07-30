//
//  VPCityListController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCityListController.h"
#import "VPCityListViewModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPCityListHeadView.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"

@interface VPCityListController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) VPCityListViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation VPCityListController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CityList" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    self.viewModel = [[VPCityListViewModel alloc] init];
    self.viewModel.locationType = self.locationType;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[VPCityListHeadView class] forHeaderFooterViewReuseIdentifier:@"VPCityListHeadView"];
    [MBProgressHUD showLoading];
    [self.viewModel loadDataSuccess:^{
        self.tableView.sectionIndexColor = [UIColor colorWithRed:0.3216 green:0.749 blue:0.8157 alpha:1.0];
        self.tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
        self.tableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithRed:0.7294 green:0.8588 blue:0.8863 alpha:1.0];
        self.tableView.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];

        self.tableView.sectionIndexMinimumDisplayRowCount = 1;
        
        [self.tableView reloadData];
        [MBProgressHUD hide];

    } failure:^(NSError *error) {
        
        [MBProgressHUD showTip:error.errorMessage];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.viewModel numberOfSections];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    return cellModel.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([cellModel.identifier isEqualToString:@"VPCityListLocationCell"]){
        NSDictionary *cityInfo = cellModel.dataSource;
        if([[cityInfo allKeys] containsObject:@"cityModel"]){
            [[VPLocationManager sharedManager] saveLocationCoordinate2DWithType:self.locationType cityModel:cityInfo[@"cityModel"]];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCityNotification" object:nil];
        }
    }else if([cellModel.identifier isEqualToString:@"VPCityListNameCell"]){
        VPOpenCityInfoModel *cityInfoModel = cellModel.dataSource;
        [[VPLocationManager sharedManager] saveLocationCoordinate2DWithType:self.locationType cityModel:cityInfoModel];
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCityNotification" object:nil];
    }
}

#pragma mark - 索引的代理
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.viewModel sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    index +=1;
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    return index;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 23;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    VPCityListHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"VPCityListHeadView"];
//    if(section !=0){
//        headView.lb_title.text = [self.viewModel sectionIndexTitleWithSection:section-1];
//    }
//
//    return headView;
//}

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
