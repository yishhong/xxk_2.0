//
//  VPAboutController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAboutController.h"
#import "VPAboutViewModel.h"
#import "UIColor+HUE.h"

@interface VPAboutController ()<UIWebViewDelegate>

@property (nonatomic, strong) VPAboutViewModel *viewModel;
@property (nonatomic, strong) UIWebView *webView;


@end

@implementation VPAboutController

+ (instancetype)instantiation{
    VPAboutController *vc = [[VPAboutController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPAboutViewModel alloc] init];
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    self.title = @"关于下乡客";
    NSString *url = @"http://apipage.xiaxiangke.com/about.aspx";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
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
