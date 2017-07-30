//
//  VPSearchController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPSearchController.h"

#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPTicketDetailController.h"
#import "VPTravelDetailController.h"
#import "VPHotelDetailViewController.h"
#import "VPBeautifulVillageDetailController.h"
#import "VPSearchModel.h"

@interface VPSearchController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, strong) VPSearchViewModel *viewModel;

@end

@implementation VPSearchController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPSearchViewModel alloc] init];
    self.viewModel.searchType = self.searchType;
    self.viewModel.cityID = self.cityID;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationItem setHidesBackButton:YES];
    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = self.searchBar;
    //设置tableView的背景颜色
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
//    [self.tableView xx_addHeaderRefreshWithBlock:^{
//        [self loadSearchWithIsFirs:YES];
//    }];
    if(self.searchType != SearchTypeAll){
        [self.tableView xx_addFooterRefreshWithBlock:^{
            [self loadSearchWithIsFirs:NO];
        }];
    }
    
}
- (void)loadSearchWithIsFirs:(BOOL)isFirs{
    [self.viewModel loadSearchWithIsFirs:isFirs success:^(BOOL isMore,NSString *message) {
        [self.tableView reloadData];
        [self.tableView xx_isHasMoreData:isMore];
        if(message.length>0){
            [MBProgressHUD showTip:message];
        }else{
            [MBProgressHUD hide];
        }
    } failure:^(NSError *error) {
        [self.tableView xx_endRefreshing];
        [MBProgressHUD showTip:error.errorMessage];
    }];
}
#pragma mark - UITableViewDelegate&&DataSource
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
    [cell xx_configCellWithEntity:[self.viewModel cellModelForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    if([self respondsToSelector:cellModel.action]){
        [self performSelector:cellModel.action withObject:indexPath];
    }
}

- (void)hotel:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    VPSearchModel * searchModel=cellModel.dataSource;
    VPHotelDetailViewController * hotelDetailViewController =[VPHotelDetailViewController instantiation];
    hotelDetailViewController.dateInfo = [[self.viewModel dateTimeInfo] mutableCopy];
    hotelDetailViewController.hid =searchModel.pid;
    [self.navigationController pushViewController:hotelDetailViewController animated:YES];
}

- (void)ticket:(NSIndexPath *)indexPath{

    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    VPSearchModel * searchModel=cellModel.dataSource;
    VPTicketDetailController * ticketDetailController =[VPTicketDetailController instantiation];
    ticketDetailController.pid =[NSString stringWithFormat:@"%zd",searchModel.pid];
    [self.navigationController pushViewController:ticketDetailController animated:YES];
}

- (void)travel:(NSIndexPath *)indexPath{

    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    VPSearchModel * searchModel=cellModel.dataSource;
    VPTravelDetailController * travelDetailController =[VPTravelDetailController instantiation];
    travelDetailController.travelID =[NSString stringWithFormat:@"%zd",searchModel.pid];
    [self.navigationController pushViewController:travelDetailController animated:YES];
}

- (void)village:(NSIndexPath *)indexPath{
    
    XXCellModel *cellModel = [self.viewModel cellModelForRowAtIndexPath:indexPath];
    VPSearchModel * searchModel=cellModel.dataSource;
    VPBeautifulVillageDetailController * beautifulVillageDetailController =[VPBeautifulVillageDetailController instantiation];
    beautifulVillageDetailController.villageID =[NSString stringWithFormat:@"%zd",searchModel.pid];
    [self.navigationController pushViewController:beautifulVillageDetailController animated:YES];
}

#pragma mark -UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.viewModel.searchText = searchText;
    //如果为空 显示历史消息
//    if(searchText.length == 0){
//        [self.viewModel showSearchRecord:1];
//        [self isShowViewType:0 message:@""];
//        [self.tableView reloadEmptyDataSet];
//        [self.tableView reloadData];
//    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"取消");
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
    //显示历史消息
//    [self.viewModel showSearchRecord:1];
//    [self isShowViewType:0 message:@""];
//    [self.tableView reloadEmptyDataSet];
//    
//    [self.tableView reloadData];
}

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    return YES;
//}
//
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    return YES;
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [MBProgressHUD showLoading];
    [self.searchBar resignFirstResponder];
    [self loadSearchWithIsFirs:YES];
//    //开始请求
//    [self.viewModel searchOrderWithFirst:YES success:^{
//        //更新数据 数据是否为空
//        [self.tableView reloadData];
//        [self.searchBar resignFirstResponder];
//        
//        [self.viewModel showSearchRecord:0];
//        
//        [self isShowViewType:0 message:@""];
//        [self.tableView reloadEmptyDataSet];
//        
//        
//    } failure:^(NSError *error) {
//        //网络异常
//        [self.tableView reloadData];
//        
//        [self.searchBar resignFirstResponder];
//        [self isShowViewType:error.code message:error.errorMessage];
//        [self.tableView reloadEmptyDataSet];
//    }];
}

#pragma mark -setter or getter
- (UISearchBar *)searchBar{
    
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        _searchBar.barTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
//        _searchBar.placeholder = @"搜索乡村/旅游/民宿/门票等";
        _searchBar.placeholder = @"输入关键字搜索";
        [_searchBar setShowsCancelButton:YES animated:YES];
        [_searchBar sizeToFit];
        
        for (UIView *subView in _searchBar.subviews){
            for (UIView *ndLeveSubView in subView.subviews){
                if([ndLeveSubView isKindOfClass:[UITextField class]]){
                    UITextField *textField = (UITextField *)ndLeveSubView;
                    textField.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9176 blue:0.9176 alpha:1.0];
                }
                else if ([ndLeveSubView isKindOfClass:[UIButton class]]){
                    [(UIButton *)ndLeveSubView setTitleColor:[UIColor navigationTintColor]
                                                    forState:UIControlStateNormal];
                }
            }
        }
    }
    return _searchBar;
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
