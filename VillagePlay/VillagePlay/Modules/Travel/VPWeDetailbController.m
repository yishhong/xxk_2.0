//
//  VPWeDetailbController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPWeDetailbController.h"
#import "UIColor+HUE.h"

@interface VPWeDetailbController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation VPWeDetailbController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Travel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor controllerBackgroundColor];
    self.webView.backgroundColor =[UIColor controllerBackgroundColor];
    self.webView.scrollView.delegate = self;
    if (self.channelType==VPChannelTypeTravel) {
        NSURL * url =[NSURL URLWithString:self.stringUrl];
        NSURLRequest * request =[NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else{
        [self.webView loadHTMLString:self.stringUrl baseURL:nil];
    }
//    self.webView.scrollView.bounces = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!self.canScroll) {
        
        [scrollView setContentOffset:CGPointZero];
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY<0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil userInfo:@{@"canScroll":@"1"}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
