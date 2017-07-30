//
//  VPPlayCourseView.m
//  scrollView
//
//  Created by Apricot on 16/11/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayCourseView.h"
#import "VPPlayCourseDayCell.h"
#import "VPPlayCourseStrategyCell.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"

#define AnimateDuration 0.3

#define DayCellIdentifier @"dayCellIdentifier"
#define StrategyCellIdentifier @"strategyCellIdentifier"

@interface VPPlayCourseView () <UITableViewDelegate,UITableViewDataSource>

/**
 *  显示的按钮
 */
@property (nonatomic, strong) UIButton * showButton;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGRect originalRect;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) SelectIndex selectIndex;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation VPPlayCourseView


- (void)layoutUIWithViewFrame:(CGRect)frame{
    self.dataArray = [NSMutableArray array];
    self.originalRect = frame;
    self.frame = frame;
    
    self.backgroundColor = [UIColor clearColor];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self addSubview:self.bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAnimation)];
    [self.bgView addGestureRecognizer:tap];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.tableView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.tableView.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[VPPlayCourseDayCell class] forCellReuseIdentifier:DayCellIdentifier];
    [self.tableView registerClass:[VPPlayCourseStrategyCell class] forCellReuseIdentifier:StrategyCellIdentifier];
    [self addSubview:self.tableView];
    
    
    self.showButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.showButton setTitle:@"点我" forState:UIControlStateNormal];
    [self.showButton setImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
    [self.showButton addTarget:self action:@selector(showAnimation) forControlEvents:UIControlEventTouchUpInside];
    self.showButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self addSubview:self.showButton];
    
    self.bgView.frame = self.showButton.frame;
    
}

- (void)configDataSource:(NSArray *)array block:(SelectIndex)selectIndex{
    if(selectIndex){
        if(self.selectIndex){
            self.selectIndex = nil;
        }
        self.selectIndex =selectIndex;
    }
    [self.dataArray removeAllObjects];
    for (NSArray *dayArray in array) {
        NSMutableArray *cellDayArray = [NSMutableArray array];
        for (NSDictionary*dict in dayArray) {
            NSString *identifier = @"";
            if([dict[@"type"] isEqualToString:@"day"]){
                identifier = DayCellIdentifier;
            }else if([dict[@"type"] isEqualToString:@"sort"]){
                identifier = StrategyCellIdentifier;
            }
            XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:identifier height:44 dataSource:dict action:nil];
            [cellDayArray addObject:cellModel];
        }
        XXCellModel *cellModel = [cellDayArray lastObject];
        cellModel.location = CellLocationEnd;
        [self.dataArray addObject:cellDayArray];
    }
    [self.tableView reloadData];
}

- (void)showAnimation{
    [UIView animateWithDuration:AnimateDuration animations:^{
        self.showButton.hidden = YES;
        self.tableView.hidden = NO;
        self.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
        self.tableView.frame = CGRectMake(0, 0, 180,  CGRectGetHeight(self.frame));
        self.bgView.frame = CGRectMake(CGRectGetWidth(self.tableView.frame), 0, CGRectGetWidth(self.frame)-CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.frame));

    }];
}

- (void)hideAnimation{
    [UIView animateWithDuration:AnimateDuration animations:^{
        self.frame = self.originalRect;
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame));
        self.bgView.frame = self.tableView.frame;

    } completion:^(BOOL finished) {
        self.tableView.hidden = YES;
        self.showButton.hidden = NO;
    }];
}


#pragma mark - TableViewDelegate&&DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.dataArray objectAtIndex:indexPath.section][indexPath.row];
    return cellModel.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.dataArray objectAtIndex:indexPath.section][indexPath.row];
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel *cellModel = [self.dataArray objectAtIndex:indexPath.section][indexPath.row];
//    NSLog(@"%zd %zd",indexPath.section, indexPath.row);
    [self hideAnimation];
    if(self.selectIndex){
        self.selectIndex(indexPath,indexPath.section,indexPath.row);
    }
}


@end
