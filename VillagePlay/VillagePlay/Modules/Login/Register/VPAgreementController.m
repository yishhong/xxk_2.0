//
//  VPAgreementController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPAgreementController.h"

@interface VPAgreementController ()<UIWebViewDelegate>

@property(strong, nonatomic)UIWebView * webView;

@end

@implementation VPAgreementController

+ (instancetype)instantiation{
    return [[VPAgreementController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"下乡客用户协议";
    self.view.backgroundColor =[UIColor whiteColor];
    self.webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    self.webView.backgroundColor =[UIColor whiteColor];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    NSURL * url =[NSURL URLWithString:@"http://apipage.xiaxiangke.com/agreement.aspx"];
    NSURLRequest * requrest =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requrest];
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
