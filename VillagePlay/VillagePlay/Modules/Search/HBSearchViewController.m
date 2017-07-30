//
//  HBSearchViewController.m
//  HotelBusiness
//
//  Created by Apricot on 16/8/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "HBSearchViewController.h"

#import "UITableViewCell+DataSource.h"

#import "QMMediator.h"
#import "QMActionView.h"


@interface HBSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,HBOrderTableTableViewCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) HBSearchViewModel * viewModel;

@end

@implementation HBSearchViewController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
////    self.navigationController.navigationBar.hidden = NO;
////    [self.searchBar becomeFirstResponder];
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
////    self.navigationController.navigationBar.hidden = YES;
////    [self.searchBar resignFirstResponder];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationView:self.searchBar];

    self.viewModel =[[HBSearchViewModel alloc]init];
    [self.viewModel showSearchRecord:1];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self isShowViewType:0 message:@""];

    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBOrderTableTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([HBOrderTableTableViewCell class])];
}

#pragma mark -  tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBSearchCellInfoModel *cellInfoModel = [self.viewModel cellInfoInRow:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfoModel.identifier];
    [cell configCellWithEntity:cellInfoModel.info];
    if([cell respondsToSelector:@selector(burstAction:withTarget:)]){
        [cell burstAction:@"action:" withTarget:self];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBSearchCellInfoModel *cellInfoModel = [self.viewModel cellInfoInRow:indexPath.row];
    return cellInfoModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HBSearchCellInfoModel *cellInfoModel = [self.viewModel cellInfoInRow:indexPath.row];
    if([self respondsToSelector:cellInfoModel.action]){
        [self performSelector:cellInfoModel.action withObject:cellInfoModel];
    }
}


#pragma mark - cell触发的方法
//清除方法
- (void)clearSearchRecord{
    [self.searchBar resignFirstResponder];
    [self.viewModel clearSearchRecord];
    [self.tableView reloadData];
    
    [self isShowViewType:0 message:@""];
    [self.tableView reloadEmptyDataSet];
}
//点击搜索历史记录
- (void)selectSearchRecord:(HBSearchCellInfoModel *)model{
    self.viewModel.searchText = model.info[@"title"];
    self.searchBar.text = self.viewModel.searchText;
    [self searchBarSearchButtonClicked:self.searchBar];
}
//点击了搜索得到的结果
- (void)selectSearchResult:(HBSearchCellInfoModel *)model{
    HBOrderModel *orderModel = model.info;
    UIViewController *vc = [QMMediator openURL:[NSString stringWithFormat:@"hotel://%@?orderNum=%@",model.VCName,orderModel.orderNum] object:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - cell按钮的触发事件
- (void)OrderTableTableViewCell:(HBOrderTableTableViewCell *)orderTableTableViewCell refundDetailOrderModel:(HBOrderModel *)orderModel{
    if (orderModel.orderState==2) {
        [self message:@"是否有房吗?" cancel:@"确认无房" confirm:@"确认有房" orderModel:orderModel index:orderTableTableViewCell.index status:YES];
    }else if (orderModel.orderState==3){
        [self message:@"确定办理入住吗?" cancel:@"取消" confirm:@"确认" orderModel:orderModel index:orderTableTableViewCell.index status:NO];
    }else if(orderModel.orderState==9) {
        //注意修改 如果房间状态列表修改过的话
        UIViewController *vc = [QMMediator openURL:@"hotel://HBStatusListViewController"
                                            object:@{
                                                     @"orderNum":orderModel.orderNum,
                                                     @"orderType":@(1),
                                                     }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)message:(NSString *)message cancel:(NSString *)cancel confirm:(NSString *)confirm orderModel:(HBOrderModel *)orderModel index:(NSInteger)index status:(BOOL)status{
    
    [QMActionView showActionViewType:QMActionViewTypeWarn
                         withDetails:@{@"title":message,
                                       @"leftButton":cancel,
                                       @"rightButton":confirm}
                             confirm:^(id object) {
                                 if (status) {
                                     [self confirmLive:@"1" orderModel:orderModel];
                                 }
                                 [self liveRow:index orderModel:orderModel];
                                 NSLog(@"确认");
                             } cancel:^{
                                 if (status) {
                                     [self confirmLive:@"2" orderModel:orderModel];
                                 }
                                 NSLog(@"取消");
                             }];
    
}

-(void)confirmLive:(NSString *)roomStatus orderModel:(HBOrderModel *)orderModel{
    
    [self.viewModel confirmPostOrderID:orderModel.orderNum status:roomStatus Success:^{
        [self searchBarSearchButtonClicked:self.searchBar];
    } failure:^(NSError *error) {
        
    }];
}

-(void)liveRow:(NSInteger)row orderModel:(HBOrderModel *)orderModel{
    [self.viewModel liveOrderID:orderModel.orderNum
                        success:^{
                            [self searchBarSearchButtonClicked:self.searchBar];
                        } failure:^(NSError *error) {
                            
                        }];
}

#pragma mark -UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.viewModel.searchText = searchText;
    //如果为空 显示历史消息
    if(searchText.length == 0){
        [self.viewModel showSearchRecord:1];
        [self isShowViewType:0 message:@""];
        [self.tableView reloadEmptyDataSet];
        [self.tableView reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //显示历史消息
    [self.viewModel showSearchRecord:1];
    [self isShowViewType:0 message:@""];
    [self.tableView reloadEmptyDataSet];
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //开始请求
    [self.viewModel searchOrderWithFirst:YES success:^{
        //更新数据 数据是否为空
        [self.tableView reloadData];
        [self.searchBar resignFirstResponder];
        
        [self.viewModel showSearchRecord:0];
        
        [self isShowViewType:0 message:@""];
        [self.tableView reloadEmptyDataSet];
        

    } failure:^(NSError *error) {
        //网络异常
        [self.tableView reloadData];
        
        [self.searchBar resignFirstResponder];
        [self isShowViewType:error.code message:error.errorMessage];
        [self.tableView reloadEmptyDataSet];
    }];
}

#pragma mark -
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if([self.showViewType integerValue] != 0){
        return [super imageForEmptyDataSet:scrollView];
    }
    return nil;
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if([self.showViewType integerValue] != 0){
        return [super descriptionForEmptyDataSet:scrollView];
    }
    NSString *text = [self.viewModel fetchNotDataString];
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    if([self.showViewType integerValue] !=0){
        return [super verticalOffsetForEmptyDataSet:scrollView];
    }
    return -(64.0/2.0+CGRectGetHeight(scrollView.frame)/2.0/2.0);
}

#pragma mark -setter or getter
- (UISearchBar *)searchBar{
    
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        _searchBar.barTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
        _searchBar.placeholder = @"房间名称/订单编号/预定人/手机号码";
        [_searchBar sizeToFit];
        
        for (UIView *subView in _searchBar.subviews){
            for (UIView *ndLeveSubView in subView.subviews){
                if([ndLeveSubView isKindOfClass:[UITextField class]]){
                    UITextField *textField = (UITextField *)ndLeveSubView;
                    textField.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9176 blue:0.9176 alpha:1.0];
                }
                else if ([ndLeveSubView isKindOfClass:[UIButton class]]){
                    [(UIButton *)ndLeveSubView setTitleColor:[UIColor whiteColor]
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
