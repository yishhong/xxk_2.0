//
//  VPOrderController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPOrderController.h"
#import "VPOrderViewModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIColor+HUE.h"

#import "VPTravelOrderOptionController.h"
#import "VPTicketOrderOptionController.h"
#import "VPHotelOrderOptionController.h"

@interface VPOrderController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) VPOrderViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VPOrderController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Order" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.viewModel = [[VPOrderViewModel alloc] init];
    [self.viewModel layerUI];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor controllerBackgroundColor];
    
}

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
        [self performSelector:cellModel.action];
    }
}

- (void)go_TravelOrder{
    [self.navigationController pushViewController:[VPTravelOrderOptionController instantiation] animated:YES];
}

- (void)go_HotelOrder{
    [self.navigationController pushViewController:[VPHotelOrderOptionController instantiation] animated:YES];
}

- (void)go_TicketOrder{
    [self.navigationController pushViewController:[VPTicketOrderOptionController instantiation] animated:YES];

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
