//
//  VPHotelUpSlideView.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/26.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#define dtNavBarDefaultHeight    64
#define dtScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define dtScreenHeight           ([UIScreen mainScreen].bounds.size.height)


#import "VPHotelRoomListUpSlideView.h"
#import "UIView+Frame.h"
#import "UIColor+HUE.h"
#import "VPBedTypeTableViewCell.h"
#import "VPRoomFacilitiesTableViewCell.h"
#import "VPRoomDescriptionTableViewCell.h"
#import "VPHotelRemoveTableViewCell.h"
#import "VPHotelHeadView.h"
#import "VPHotelPayView.h"
#import "XXNibConvention.h"
#import "VPHotelRoomListViewModel.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPHotelRoomListTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPHotelPopupTopView.h"

@interface VPHotelRoomListUpSlideView ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,VPHotelPayViewDelegate>

@property(strong, nonatomic) UITableView * tableView;

@property(strong, nonatomic) NSMutableArray * dataSource;

@property(strong, nonatomic) UIView *bottomView;

@property(strong, nonatomic) VPHotelPayView * hotelPayView;

@property (strong, nonatomic) VPHotelRoomListViewModel *viewModel;

@property (strong, nonatomic) VPHotelPopupTopView *topView;

@end

@implementation VPHotelRoomListUpSlideView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    self.viewModel =[[VPHotelRoomListViewModel alloc]init];
    [self addSubview:self.bottomView];
    
    self.topView = [[VPHotelPopupTopView alloc] init];
    self.topView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 44);
    __weak typeof(VPHotelRoomListUpSlideView)* weakSelf = self;
    [self.topView tapClose:^{
        [weakSelf hideAnimation:YES];
    }];
    [self.bottomView addSubview:self.topView];
    
    [self.bottomView addSubview:self.tableView];
    [self.bottomView addSubview:self.hotelPayView];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UISwipeGestureRecognizer * swipeGesture =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureTap:)];
    self.tableView.bounces = NO;
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.bottomView addGestureRecognizer:swipeGesture];
    self.backgroundColor= [UIColor colorWithWhite:0 alpha:0.0];
    
    UITapGestureRecognizer * tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGesture];
    
    tapGesture.delegate = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelRoomListTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelRoomListTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBedTypeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBedTypeTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPRoomFacilitiesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPRoomFacilitiesTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPRoomDescriptionTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPRoomDescriptionTableViewCell class])];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelRemoveTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelRemoveTableViewCell class])];
    
    //空行
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];
}

- (void)loadNewDate{

    [MBProgressHUD showLoading];
    [self.viewModel hotelRuleType:[NSString stringWithFormat:@"%ld",(long)self.hotelRoomListRoomModel.ruleId] success:^{
        [MBProgressHUD hide];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:error.errorMessage];
    }];
}

#pragma mark -VPHotelPayViewDelegate
-(void)paymentView{

    if ([self.delegate respondsToSelector:@selector(roomListRoomModel:)]) {
        [self.delegate roomListRoomModel:self.hotelRoomListRoomModel];
    }
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

/**
 deleteSlideView
 */
- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    
    if (view.tag ==-10) {
        [self hideAnimation:YES];
    }
    if ([self.delegate respondsToSelector:@selector(VPHotelHeadViewSelectImage:roomListRoomModel:)]) {
        [self hideAnimation:YES];
        [self.delegate VPHotelHeadViewSelectImage:view.tag roomListRoomModel:self.hotelRoomListRoomModel];
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
            _bottomView.top = 90;
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else{
        
        _bottomView.top = 90;
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
-(void)setHotelRoomListRoomModel:(VPHotelRoomListRoomModel *)hotelRoomListRoomModel{

    _hotelRoomListRoomModel =hotelRoomListRoomModel;
    self.topView.lb_title.text = self.hotelRoomListRoomModel.name;
    self.hotelPayView.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",hotelRoomListRoomModel.price];
    self.hotelPayView.isReserveRoom =hotelRoomListRoomModel.isReserveRoom;
    [self.viewModel hotelRoomListModel:self.hotelRoomListRoomModel];
    [self loadNewDate];

}

- (UIView *)bottomView
{
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, dtScreenHeight, dtScreenWidth, dtScreenHeight-90)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bottomView;
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,44, dtScreenWidth, self.bottomView.height-45-44) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.backgroundColor =[UIColor controllerBackgroundColor];
        _tableView.dataSource =self;
        _tableView.tableFooterView =[UIView new];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(VPHotelPayView *)hotelPayView{

    if (!_hotelPayView) {
        _hotelPayView =[VPHotelPayView xx_instantiateFromNib];
        _hotelPayView.delegate =self;
        _hotelPayView.frame=CGRectMake(0, self.bottomView.height-45, dtScreenWidth, 45);
    }
    return _hotelPayView;
}
@end
