//
//  VPMemberCenterController.mController
//  VillagePlay
//
//  Created by Apricot on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMemberCenterController.h"
#import "VPMemberCenterViewModel.h"
#import "UIColor+HUE.h"
#import "WebViewJavascriptBridge.h"

@interface VPMemberCenterController ()<UIWebViewDelegate>

@property (nonatomic, strong) VPMemberCenterViewModel *viewModel;
@property (nonatomic, strong) UIWebView *webView;
@property WebViewJavascriptBridge* bridge;


@end

@implementation VPMemberCenterController

+ (instancetype)instantiation{
    VPMemberCenterController *vc = [[VPMemberCenterController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPMemberCenterViewModel alloc] init];
    self.view.backgroundColor = [UIColor controllerBackgroundColor];
    self.title = @"会员中心";
    NSString *URLStr = @"http://192.168.2.16:8088/my/index.html";
//    NSString *URLStr = @"http://192.168.12.127:8088/my/index.html";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URLStr]]];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    [_bridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [_bridge registerHandler:@"getBlogNameFromObjC1" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [_bridge registerHandler:@"goHtmlUrl" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"goHtmlUrl called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
//    [_bridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"testObjcCallback called: %@", data);
//        responseCallback(@"Response from testObjcCallback");
//    }];
    
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
