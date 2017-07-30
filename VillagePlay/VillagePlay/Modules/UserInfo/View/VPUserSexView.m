//
//  VPUserSexView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserSexView.h"
#import "CNPPopupController.h"
#import "UIColor+HUE.h"

@interface VPUserSexView ()<UITableViewDataSource,UITableViewDelegate,CNPPopupControllerDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString * selectSex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) SelectSexBlock selectSexBlock;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) UILabel *lb_title;

@end

@implementation VPUserSexView

+ (instancetype)instantiation{
    VPUserSexView *view = [[VPUserSexView alloc] init];
    view.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.1, 0, CGRectGetWidth([UIScreen mainScreen].bounds)*0.8, 128);
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = @[@"男",@"女"];
        self.selectSex = @"";
    }
    return self;
}


- (void)showViewWithNowSelectSex:(NSString *)nowSelectSex Block:(SelectSexBlock)selectSexBlock{
    if(selectSexBlock){
        if(self.selectSexBlock){
            self.selectSexBlock = nil;
        }
        self.selectSexBlock = selectSexBlock;
    }
    
    self.selectSex = nowSelectSex;
    
    self.lb_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    [self addSubview:self.lb_title];
    self.lb_title.font = [UIFont systemFontOfSize:16];
    //    lb_title.backgroundColor = [UIColor navigationTintColor];
    //    lb_title.textColor = [UIColor whiteColor];
    self.lb_title.text = @"性别";
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
    self.popupController.theme.popupStyle = CNPPopupStyleCentered;
    self.popupController.delegate = self;
    
    [self.popupController presentPopupControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",self.dataSource.count);
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"userSex";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    NSString *sex = [self.dataSource objectAtIndex:indexPath.row];
    if([self.selectSex isEqualToString:sex]){
        cell.textLabel.textColor = [UIColor navigationTintColor];
    }else{
        cell.textLabel.textColor = [UIColor blackTextColor];
    }
    cell.textLabel.text = sex;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectSexBlock){
        self.selectSexBlock([self.dataSource objectAtIndex:indexPath.row]);
    }
    [self.popupController dismissPopupControllerAnimated:YES];
}

- (void)popupControllerDidDismiss:(nonnull CNPPopupController *)controller{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
