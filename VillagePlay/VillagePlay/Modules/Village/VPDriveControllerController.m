//
//  VPDriveControllerController.mController
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPDriveControllerController.h"
#import "VPDriveControllerViewModel.h"
#import "UIColor+HUE.h"
#import "VillageTitleTableViewCell.h"
#import "VPDriveContentTableViewCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

@interface VPDriveControllerController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) VPDriveControllerViewModel *viewModel;

@end

@implementation VPDriveControllerController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Village" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"出行线路";
    self.viewModel = [[VPDriveControllerViewModel alloc] init];
    [self.viewModel villageDriveLineString:self.driveLineString villageOhterLineString:self.ohterLineString];
    self.view.backgroundColor =[UIColor controllerBackgroundColor];
    //标题
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageTitleTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageTitleTableViewCell class])];
    //文
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPDriveContentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPDriveContentTableViewCell class])];

}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
