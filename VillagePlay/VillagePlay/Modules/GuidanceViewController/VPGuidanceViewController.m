//
//  VPGuidanceViewController.m
//  VillagePlay
//
//  Created by  易述宏 on 15/10/19.
//  Copyright © 2015年 zjh. All rights reserved.
//

/*手机物理宽高*/
#define dtScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define dtScreenHeight           ([UIScreen mainScreen].bounds.size.height)

#import "VPGuidanceViewController.h"
#import "UIView+Frame.h"
#import "VPGuidanceView.h"

@interface VPGuidanceViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * myScrollview;
@property (strong, nonatomic) UIButton * homeButton;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIView *guifanceView;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * detailLabel;
@property (strong, nonatomic) NSMutableArray *guidanceViewArray;

@end

@implementation VPGuidanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //滑动视图
    self.myScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, dtScreenWidth, dtScreenHeight)];
    self.myScrollview.showsHorizontalScrollIndicator=NO;
    [self.myScrollview setContentSize:CGSizeMake(dtScreenWidth*4, 0)];
    self.myScrollview.pagingEnabled = YES;
    self.myScrollview.delegate = self;
    self.myScrollview.bounces = NO;
    [self.view addSubview:self.myScrollview];

    [self.view addSubview:self.homeButton];
    self.homeButton.hidden =YES;
    
    UIPageControl * pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, dtScreenHeight-(45+20), 100, 45)];
    pageControl.numberOfPages =4;
    pageControl.currentPage =0;
    self.homeButton.hidden = YES;
    [self.view addSubview:pageControl];
    self.pageControl =pageControl;

    
    self.guidanceViewArray =[NSMutableArray array];
    NSArray *guidanceArray =@[@{@"title":@"乡",
                                @"detailTitle":@"——  一个承载乡愁的地方"},
                              @{@"title":@"乡村",
                                @"detailTitle":@"——  不再是落后的代名词"},
                              @{@"title":@"乡村游",
                                @"detailTitle":@"——  正成为旅游的新名词"},
                              @{@"title":@"下乡客",
                                @"detailTitle":@"——  乡约天下客"}];
    
    for (int i = 0; i<guidanceArray.count; i++) {
        NSDictionary *guidanceInfo =guidanceArray[i];
        VPGuidanceView * guidanceView =[[VPGuidanceView alloc]initWithFrame:CGRectMake(dtScreenWidth*i, 0, dtScreenWidth, dtScreenHeight)];
        guidanceView.userInteractionEnabled =YES;
        guidanceView.alpha = 0.0;
        if (i==0) {
            [UIView beginAnimations:@"HideArrow" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationDelay:0.3];
            guidanceView.alpha = 1.0;
            [UIView commitAnimations];
        }
        guidanceView.backgroundColor =[UIColor clearColor];
        guidanceView.dictionary =guidanceInfo;
        [self.guidanceViewArray addObject:guidanceView];
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(dtScreenWidth*i, 0, dtScreenWidth, dtScreenHeight);
        if ([UIScreen mainScreen].bounds.size.height<=960) {
            NSString * string = [NSString stringWithFormat:@"yindaoip4%d",i+1];
            imageView.image = [UIImage imageNamed:string];
        }else{
            NSString * string = [NSString stringWithFormat:@"yindaoip6p%d",i+1];
            imageView.image = [UIImage imageNamed:string];
        }
           [self.myScrollview addSubview:imageView];
        [self.myScrollview addSubview:guidanceView];
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger selectIndex =scrollView.contentOffset.x/dtScreenWidth;
    self.pageControl.currentPage =selectIndex;
    VPGuidanceView * guidanceView = self.guidanceViewArray[selectIndex];
    guidanceView.hidden=NO;
    [UIView beginAnimations:@"HideArrow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.3];
    guidanceView.alpha = 1.0;
    [UIView commitAnimations];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger selectIndex =scrollView.contentOffset.x/dtScreenWidth;
    self.pageControl.currentPage =selectIndex;
    if(scrollView.contentOffset.x/dtScreenWidth == 3){
        self.homeButton.hidden =NO;
    }else{
        self.homeButton.hidden =YES;
    }
}

//立即体验
-(UIButton *)homeButton{

    if (!_homeButton) {
        _homeButton = [[UIButton alloc]initWithFrame:CGRectMake(dtScreenWidth-(100), dtScreenHeight-(45+20), 100, 45)];
        [_homeButton addTarget:self action:@selector(didHomeTapped) forControlEvents:UIControlEventTouchDown];
        [_homeButton setTitle:@"立即体验" forState:UIControlStateNormal];
        [_homeButton setImage:[UIImage imageNamed:@"yindaoKeiken"] forState:UIControlStateNormal];
        _homeButton.imageEdgeInsets =UIEdgeInsetsMake(0, 70, 0, 0);
        _homeButton.titleEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
        [_homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _homeButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [_homeButton setBackgroundColor:[UIColor clearColor]];
    }
    return _homeButton;
}

-(void)didHomeTapped{

    [self.view removeFromSuperview];
}

@end
