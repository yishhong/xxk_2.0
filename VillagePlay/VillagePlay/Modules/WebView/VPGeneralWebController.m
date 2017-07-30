//
//  VPGeneralWebController.mController
//  VillagePlay
//
//  Created by Apricot on 2016/12/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPGeneralWebController.h"
#import "VPGeneralWebViewModel.h"
#import "WebViewJavascriptBridge.h"
#import "UIColor+HUE.h"
#import "VPTravelDetailController.h"
#import "VPHotelDetailViewController.h"
#import "VPTicketDetailController.h"
#import "VPShareManage.h"
#import "VPUserManager.h"

@implementation VPGeneralWebShareModel


@end


@interface VPGeneralWebController ()<UIWebViewDelegate>

@property (nonatomic, strong) VPGeneralWebViewModel *viewModel;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation VPGeneralWebController

+ (instancetype)instantiation{
    VPGeneralWebController *vc = [[VPGeneralWebController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[VPGeneralWebViewModel alloc] init];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    self.webView.backgroundColor = [UIColor controllerBackgroundColor];
    [self.view addSubview:self.webView];
    
//    if(self.channelType == VPChannelTypeGift){
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]]]];
//    }else{
//    }
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]]];

    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [self.bridge setWebViewDelegate :self];
//分享触发分享事件
    __weak typeof(VPGeneralWebController) *weakSelf = self;
    [self.bridge registerHandler:@"callShare" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf shareAction];
        responseCallback(@1);
    }];
    
    if (self.channelType==VPChannelTypeMagazine||self.channelType==VPChannelTypeTopic) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_share_white"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    }
}

-(void)shareAction{
    //    显示分享面板
    if (self.channelType==VPChannelTypeTopic) {
        
         [VPShareManage getShareWebPageToPlatform:VPChannelTypeTopic title:self.shareTitle  descr:nil shareUrl:self.url thumImage:self.imageString];
        
    }else if (self.channelType==VPChannelTypeMagazine){
    
        [VPShareManage getShareWebPageToPlatform:VPChannelTypeMagazine title:self.shareTitle  descr:nil shareUrl:self.url thumImage:self.imageString];
    }else if (self.channelType == VPChannelTypeGift){
        [VPShareManage getShareWebPageToPlatform:VPChannelTypeGift title:[VPUserManager sharedInstance].xx_userinfoID  descr:nil shareUrl:self.url thumImage:nil];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    BOOL isJump = YES;
    NSString *urlStr = request.URL.absoluteString;
    if([urlStr rangeOfString:@"mobile/activeinfo.aspx"].location != NSNotFound){
        isJump = NO;//旅游活动
        NSDictionary *paramsDict = [self analyzeParams:request.URL.query];
        if([[paramsDict allKeys] containsObject:@"id"]){
            VPTravelDetailController * travelVC = [VPTravelDetailController instantiation];
            travelVC.travelID = paramsDict[@"id"];
            [self.navigationController pushViewController:travelVC animated:YES];
        }
    }else if ([urlStr rangeOfString:@"homestay/hotelDetail.html"].location != NSNotFound){
        isJump = NO;//民宿
        NSDictionary *paramsDict = [self analyzeParams:request.URL.query];
        if([[paramsDict allKeys] containsObject:@"hid"]){
            VPHotelDetailViewController *hotelVC = [VPHotelDetailViewController instantiation];
            hotelVC.hid = [paramsDict[@"hid"] integerValue];
            [self.navigationController pushViewController:hotelVC animated:YES];
        }
    }else if ([urlStr rangeOfString:@"ticket/ticketinfo.aspx"].location != NSNotFound){
        isJump = NO;//门票
        NSDictionary *paramsDict = [self analyzeParams:request.URL.query];
        if([[paramsDict allKeys] containsObject:@"id"]){
            VPTicketDetailController *ticketVC = [VPTicketDetailController instantiation];
            ticketVC.pid = paramsDict[@"id"];
            [self.navigationController pushViewController:ticketVC animated:YES];
        }
    }
    return isJump;
}


/**
 分析URL中的参数

 @param paramsStr 参数
 @return 返回参数的字典
 */
- (NSDictionary *)analyzeParams:(NSString *)paramsStr{
    if(paramsStr.length<1){
        return nil;
    }
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    
    NSArray *paramsArray = [paramsStr componentsSeparatedByString:@"="];
    if([paramsArray count]>=2){
        for (int i = 0; i<[paramsArray count]; i+=2) {
            paramsDict[paramsArray[i]] = paramsArray[i+1];
        }
    }
    return paramsDict;
}

- (void)dealloc{
    self.webView = nil;
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
