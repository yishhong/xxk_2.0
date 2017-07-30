//
//  VPHotelInformationView.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelInformationView.h"
#import "VPHotelInformationViewModel.h"
#import "UITableViewCell+DataSource.h"
#import "UIView+Frame.h"
#import "UIColor+HUE.h"
#import "VPHotelRoomListTableViewCell.h"
#import "VPHotelFacilitiesNameTableViewCell.h"
#import "VPHotelIntroductioncitiesTableViewCell.h"


#define dtNavBarDefaultHeight    64
#define dtScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define dtScreenHeight           ([UIScreen mainScreen].bounds.size.height)

@interface VPHotelInformationView ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UITableView * tableView;

@property(strong, nonatomic) NSMutableArray * dataSource;

@property(strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) VPHotelInformationViewModel *viewModel;

@end

@implementation VPHotelInformationView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    self.viewModel =[[VPHotelInformationViewModel alloc]init];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.tableView];    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    UISwipeGestureRecognizer * swipeGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureTap:)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.bottomView addGestureRecognizer:swipeGesture];
    self.backgroundColor= [UIColor colorWithWhite:0 alpha:0.0];
    
    UITapGestureRecognizer * tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGesture];
    
    tapGesture.delegate = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelRoomListTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelRoomListTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelFacilitiesNameTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelFacilitiesNameTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelIntroductioncitiesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelIntroductioncitiesTableViewCell class])];
    

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -VPBedTypeTableViewCellDelegate
/**
 deleteSlideView
 */
- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    
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
            _bottomView.top = 180;
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else{
        
        _bottomView.top = 180;
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
-(void)setHotelDetailModel:(VPHotelDetailModel *)hotelDetailModel{

    _hotelDetailModel =hotelDetailModel;
    [self.viewModel hotelInforMationModel:hotelDetailModel];
}


- (UIView *)bottomView
{
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, dtScreenHeight, dtScreenWidth, dtScreenHeight-180)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bottomView;
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, dtScreenWidth, self.bottomView.height) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.backgroundColor =[UIColor controllerBackgroundColor];
        _tableView.dataSource =self;
        _tableView.tableFooterView =[UIView new];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
