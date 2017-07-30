//
//  VPTopicDetailImageTextViewController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicDetailImageTextController.h"
#import "TopicDetailImageTextViewModel.h"
#import "VPTiketDescribeTableViewCell.h"
#import "TopicRelatedRecommentTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "TopicRecommendTableViewCell.h"
#import "VPWebTableViewCell.h"

@interface VPTopicDetailImageTextController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic)    TopicDetailImageTextViewModel * viewModel;

@end

@implementation VPTopicDetailImageTextController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Topic" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.viewModel =[[TopicDetailImageTextViewModel alloc]init];
    [self.viewModel topicDetailImageTextModel:self.topicDetailModel];
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTiketDescribeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTiketDescribeTableViewCell class])];
    [self.tableView registerClass:[VPWebTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VPWebTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicRecommendTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TopicRecommendTableViewCell class])];

    [self.tableView registerClass:[TopicRelatedRecommentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TopicRelatedRecommentTableViewCell class])];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    if ([cellModel.identifier isEqualToString:@"TopicRelatedRecommentTableViewCell"]) {
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
