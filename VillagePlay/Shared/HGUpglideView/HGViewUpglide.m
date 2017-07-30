//
//  HGViewUpglide.m
//  HGDemo
//
//  Created by  易述宏 on 16/10/16.
//  Copyright © 2016年 JamesYi. All rights reserved.
//

#define dtNavBarDefaultHeight    64
#define dtScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define dtScreenHeight           ([UIScreen mainScreen].bounds.size.height)


#import "HGViewUpglide.h"
#import "UIView+Frame.h"
#import "UIColor+HUE.h"
#import "VPTravelSelectCouponTableViewCell.h"
#import "VPOrderCouponModel.h"

@interface HGViewUpglide ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView * tableView;

@property(strong,nonatomic) NSMutableArray * dataSource;

@property(strong,nonatomic) UIView *bottomView;

@property(nonatomic,strong) UIButton *confirmButton;

@property(assign, nonatomic)NSInteger selectIndex;

@property (assign, nonatomic) NSInteger sectionIndex;

@property (assign, nonatomic)CGFloat totalRealPrice;

@end

@implementation HGViewUpglide

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

-(void)setUp{
 
    [self addSubview:self.bottomView];
    self.selectIndex =-1;
    self.sectionIndex =-1;
    [self.bottomView addSubview:self.tableView];
    [self.bottomView addSubview:self.confirmButton];
    self.dataSource =[[NSMutableArray alloc]init];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UISwipeGestureRecognizer * swipeGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureTap:)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.bottomView addGestureRecognizer:swipeGesture];
    self.backgroundColor= [UIColor colorWithWhite:0 alpha:0.0];
    
    UITapGestureRecognizer * tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPTravelSelectCouponTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPTravelSelectCouponTableViewCell class])];
    self.tableView.tableHeaderView =[self headView];
}

#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    return YES;
}

- (void)fouCouponArray:(NSArray *)couponArray totalRealPrice:(CGFloat)totalRealPrice{

    self.dataSource =[couponArray copy];
    self.totalRealPrice =totalRealPrice;
    [self.tableView reloadData];
}


#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) {
        return self.dataSource.count;
    }else{
    
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    VPTravelSelectCouponTableViewCell * travelSelectCouponTableViewCell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VPTravelSelectCouponTableViewCell class])];
    if (indexPath.section==0) {
        VPOrderCouponModel * couponModel =self.dataSource[indexPath.row];
        travelSelectCouponTableViewCell.titleLabel.text =couponModel.desc;
        if (indexPath.row==self.selectIndex) {
            
            travelSelectCouponTableViewCell.selectImageView.image =[UIImage imageNamed:@"icon_round_sel"];
            self.sectionIndex =-1;
        }else{
            
            travelSelectCouponTableViewCell.selectImageView.image =[UIImage imageNamed:@"icon_round_nor"];
        }
    }else{
        travelSelectCouponTableViewCell.titleLabel.text =@"暂不使用优惠劵";
        if (indexPath.row==self.sectionIndex) {
            
            travelSelectCouponTableViewCell.selectImageView.image =[UIImage imageNamed:@"icon_round_sel"];
            self.selectIndex =-1;
        }else{
            
            travelSelectCouponTableViewCell.selectImageView.image =[UIImage imageNamed:@"icon_round_nor"];
        }
    }
    return travelSelectCouponTableViewCell;
}


#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        VPOrderCouponModel * couponModel =self.dataSource[indexPath.row];
        self.selectIndex =indexPath.row;
        self.sectionIndex =-1;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        CGFloat discountMoney=0;
        switch (couponModel.discountType) {
            case 0|1:{
                discountMoney = couponModel.discountMoney;
            }break;
            case 2:{
                discountMoney = self.totalRealPrice*(couponModel.discountValue/100.0);
            }break;
                
            default:
                break;
        }
        [self.tableView reloadData];
        if (self.tappBlock) {
            if (discountMoney<=0) {
                discountMoney=0.01;
            }
            self.tappBlock(couponModel,couponModel.couponCode,discountMoney);
        }
        [self hideAnimation:YES];
    }else{
        self.sectionIndex =indexPath.row;
        self.selectIndex=-1;
        [self.tableView reloadData];
        if (self.tappBlock) {

            self.tappBlock(nil,@"",self.totalRealPrice);
        }
        [self hideAnimation:YES];
    }
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
            _bottomView.top = dtScreenHeight/2;
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else{
        
        _bottomView.top = dtScreenHeight/2;
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
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, dtScreenHeight, dtScreenWidth, dtScreenHeight/2)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bottomView;
}

-(UIView *)headView{

    
        UIView * sectionView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, dtScreenWidth, 70)];
        UILabel * nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 25, dtScreenWidth, 17)];
        nameLabel.text =@"优惠券";
        nameLabel.textAlignment =NSTextAlignmentCenter;
        nameLabel.textColor =[UIColor VPContentColor];
        [sectionView addSubview:nameLabel];
         return sectionView;
}

-(UITableView *)tableView{

    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, dtScreenWidth, self.bottomView.height-45) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[UIView new];
    }
    return _tableView;
}

-(UIButton *)confirmButton{
    
    if (!_confirmButton) {
        _confirmButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(0, self.bottomView.height-45, dtScreenWidth, 45);
        _confirmButton.backgroundColor=[UIColor navigationTintColor];
        [_confirmButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(didTappedConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
