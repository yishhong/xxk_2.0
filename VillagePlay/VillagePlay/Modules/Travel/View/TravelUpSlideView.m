//
//  TravelUpSlideView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//


#define dtNavBarDefaultHeight    64
#define dtScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define dtScreenHeight           ([UIScreen mainScreen].bounds.size.height)

#import "TravelUpSlideView.h"
#import "UIView+Frame.h"
#import "TravelUpSlideTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPLocationManager.h"
#import "MBProgressHUD+Loading.h"

@interface TravelUpSlideView ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UIView *bottomView;

@property(strong, nonatomic)UITableView * tableView;

@property(assign, nonatomic)NSInteger selectIndex;

@property (strong, nonatomic)NSArray * dateSource;

@end

@implementation TravelUpSlideView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {

        self.dateSource = @[@"默认排序",@"距离优先",@"热门优先"];
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.tableView];
    self.selectIndex =0;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UISwipeGestureRecognizer * swipeGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureTap:)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.bottomView addGestureRecognizer:swipeGesture];
    self.backgroundColor= [UIColor colorWithWhite:0 alpha:0.0];
    
    UITapGestureRecognizer * tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGesture];
    
    tapGesture.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelUpSlideTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TravelUpSlideTableViewCell class])];
}

#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    return YES;
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dateSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSString * sortingString =self.dateSource[indexPath.row];
    TravelUpSlideTableViewCell * travelUpSlideTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TravelUpSlideTableViewCell class])];
    travelUpSlideTableViewCell.titleLabel.text =sortingString;
    if (self.selectIndex ==indexPath.row) {
        
        travelUpSlideTableViewCell.titleLabel.textColor =[UIColor navigationTintColor];
    }else{
    
        travelUpSlideTableViewCell.titleLabel.textColor =[UIColor VPContentColor];
    }
    return travelUpSlideTableViewCell;
}


#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self hideAnimation:YES];

    if ([self.delegate respondsToSelector:@selector(selectIndex:)]) {
        [self.delegate selectIndex:indexPath.row];
    }
    self.selectIndex =indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

}

#pragma mark -VPBedTypeTableViewCellDelegate
-(void)deleteSlideView{
    
    [self hideAnimation:YES];
}

-(void)swipeGestureTap:(UISwipeGestureRecognizer *)recognizer{
    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        
        [self hideAnimation:YES];
    }
}

-(void)handleTapGesture:(UIGestureRecognizer *)gesture{
    
    [self hideAnimation:YES];
}

#pragma mark -- Event Response
-(void)didTappedConfirmButton:(UIButton *)button{
    
    [self hideAnimation:YES];
}

- (void)showAnimation:(BOOL)animation{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            _bottomView.top = dtScreenHeight-self.dateSource.count*45;
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else{
        
        _bottomView.top = dtScreenHeight-self.dateSource.count*45;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    
}

- (void)hideAnimation:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            _bottomView.top = self.height;
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else{
        
        _bottomView.top =self.height;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        [self removeFromSuperview];
    }
}


#pragma mark -setter or getter
- (UIView *)bottomView
{
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, dtScreenHeight, dtScreenWidth, self.dateSource.count*45)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bottomView;
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, dtScreenWidth, self.bottomView.height) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.dataSource =self;
        _tableView.tableFooterView =[UIView new];
    }
    return _tableView;
}

@end
