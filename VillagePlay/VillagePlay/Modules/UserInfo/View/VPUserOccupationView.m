//
//  VPUserOccupationView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserOccupationView.h"
#import "CNPPopupController.h"
#import "UIColor+HUE.h"

@interface VPUserOccupationView ()<UITableViewDelegate,UITableViewDataSource,CNPPopupControllerDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) SelectOccupationBlock selectOccupationBlock;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) UILabel *lb_title;

@end

@implementation VPUserOccupationView

+ (instancetype)instantiation{
    VPUserOccupationView *view = [[VPUserOccupationView alloc] init];
    view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 300);
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = @[@"计算机/互联网/通信", @"生产/工艺/制造",
                            @"金融/银行/投资/保险", @"商业/服务业/个体经营",
                            @"文化/广告/传媒", @"娱乐/艺术/表演",
                            @"医疗/护理/制药", @"律师/法务", @"教育/培训",
                            @"公务员/事业单位", @"学生", @"打杂"];

//        [self addSubview:self.tableView];
    }
    return self;
}
- (void)showViewBlock:(SelectOccupationBlock)selectOccupationBlock{
    if(selectOccupationBlock){
        if(self.selectOccupationBlock){
            self.selectOccupationBlock = nil;
        }
        self.selectOccupationBlock = selectOccupationBlock;
    }
    
    self.lb_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    [self addSubview:self.lb_title];
    self.lb_title.font = [UIFont systemFontOfSize:16];
//    lb_title.backgroundColor = [UIColor navigationTintColor];
//    lb_title.textColor = [UIColor whiteColor];
    self.lb_title.text = @"职业";
    self.lb_title.textAlignment = NSTextAlignmentCenter;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lb_title.frame)-0.5, CGRectGetWidth(self.lb_title.frame), 0.5)];
    lineView.backgroundColor = [UIColor septalLineColor];
    [self addSubview:lineView];
    
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lb_title.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.lb_title.frame)) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[self]];
    CNPPopupTheme *theme = [CNPPopupTheme defaultTheme];
    theme.popupContentInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    theme.shouldDismissOnBackgroundTouch =YES;
    self.popupController.theme = theme;
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.delegate = self;
    
    [self.popupController presentPopupControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",self.dataSource.count);
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"occupation";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectOccupationBlock){
        self.selectOccupationBlock([self.dataSource objectAtIndex:indexPath.row]);
    }
    [self.popupController dismissPopupControllerAnimated:YES];
}

- (void)popupControllerDidDismiss:(nonnull CNPPopupController *)controller{
    [self removeFromSuperview];
}

-(void)dealloc{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
