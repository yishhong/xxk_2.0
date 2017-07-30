//
//  ViewController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "ViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <YYWebImage/YYWebImage.h>
//#import "UMSocialUIManager.h"
#import "WebViewJavascriptBridge.h"
#import "VPTravelMainController.h"
#import "VPTicketController.h"
#import "VPMineController.h"
#import "UINavigationBar+Awesome.h"

#import "BMapKit.h"
#import "VPQiNiuAPI.h"
#import "VPHotelController.h"
#import "VPLoginController.h"
#import "VPTopicController.h"
#import "VPVickersController.h"
#import "VPLiveViewController.h"
#import "VPBeautifulVillageController.h"
#import "VPPlayController.h"
#import "QMShareUIManager.h"
#import "VPUserManager.h"
#import "VPUserAPI.h"
#import "NSError+Reason.h"
#import "UIImageView+VPWebImage.h"
#import "VPCalendarController.h"
#import "VPMapController.h"


@interface ViewController ()<BMKLocationServiceDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property WebViewJavascriptBridge* bridge;


/**
 *  百度地图
 */
@property (nonatomic, strong) BMKLocationService*locationService;
/**
 *  七牛API
 */
@property (nonatomic, strong) VPQiNiuAPI *qiNiuAPI;

@property (nonatomic, strong) UILabel * label;

@property (nonatomic, strong) VPUserAPI *userAPI;


@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.label.text =[[VPUserManager sharedInstance] xx_userinfoID];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"测试";
    
    //七牛
    self.qiNiuAPI = [[VPQiNiuAPI alloc] init];
    self.userAPI = [[VPUserAPI alloc] init];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(view.frame)*0.1, 0, CGRectGetWidth(view.frame)*0.8,44)];
    searchBar.backgroundImage = [[UIImage alloc] init];
    searchBar.placeholder =@"搜索目的地、旅游、景点、民宿等";
    /**
     *  显示取消按钮
     */
    searchBar.showsCancelButton = YES;
    // 设置SearchBar的颜色主题为白色
    searchBar.barTintColor = [UIColor colorWithRed:0.8323 green:0.2446 blue:0.8425 alpha:0.5];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    searchBar.translucent = YES;
    /**
     *  光标红色以及点击的效果颜色
     */
    searchBar.tintColor = [UIColor redColor];
    /**
     *  修改搜索的图标
     */
    [searchBar setImage:[UIImage imageNamed:@"Search"]
                  forSearchBarIcon:UISearchBarIconSearch
                             state:UIControlStateNormal];
    /**
     *  修改文字的颜色
     */
//    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = [UIColor whiteColor];
//    
//    
//    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = [UIColor blackColor];
//    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].tintColor = [UIColor orangeColor];
//
////    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor redColor]];
//    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"12"];


    [view addSubview:searchBar];
    
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    subView.backgroundColor = [UIColor redColor];
    searchBar.inputAccessoryView = subView;
    
    UITextField *searchField = [searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor orangeColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = [UIColor colorWithRed:247/255.0 green:75/255.0 blue:31/255.0 alpha:1].CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
        //修改搜索tintColor颜色以后需要重新设置TextFeld的tintColor 否则光标的颜色会被修改
//        [searchField setTintColor:[UIColor blackColor]];
    }
    

    
    
    
    self.navigationItem.titleView = view;
    self.webView = [[UIWebView alloc] init];
    self.webView .frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];

//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://42.96.136.86:8027/js_test/test.html"]];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://chuye.cloud7.com.cn/44342180"]];
//    [request setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1" forHTTPHeaderField:@"User-Agent"];
    
    
    [self.webView  loadRequest:request];
//    [self.view addSubview:self.webView ];


    [self.webView  reload];

    [self.bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(data);
    }];
    
    [self.bridge callHandler:@"testJavascriptHandler" data:@{@"parame": @2} responseCallback:^(id responseData) {
        NSLog(@"ObjC received response: %@", responseData);
    }];

//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)location:(id)sender {
    if(!self.locationService){
        self.locationService = [[BMKLocationService alloc] init];
        self.locationService.delegate = self;
    }
    [self.locationService startUserLocationService];
    NSLog(@"%@",[self.locationService userLocation]);
}


- (IBAction)travel:(id)sender {
    
    [self.navigationController pushViewController:[VPTravelMainController instantiation] animated:YES];
}

- (IBAction)ticket:(id)sender {
    [self.navigationController pushViewController:[VPTicketController instantiation] animated:YES];
}
- (IBAction)hotel:(id)sender {
    VPHotelController * hotelController =[VPHotelController instantiation];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:hotelController animated:YES];
}

- (IBAction)upload:(id)sender {
    //跳转到app设置界面
    NSURL*url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)topicAction:(id)sender {
    VPTopicController *topicController =[VPTopicController instantiation];
    topicController.title =@"专题列表";
    [self.navigationController pushViewController:topicController animated:YES];
}
- (IBAction)vickersAction:(id)sender {
    
    VPVickersController *vickersController =[VPVickersController instantiation];
    vickersController.title =@"微刊";
    [self.navigationController pushViewController:vickersController animated:YES];
}
- (IBAction)liveStreamingActon:(id)sender {
    
    VPLiveViewController * liveViewController = [VPLiveViewController instantiation];
    [self.navigationController pushViewController:liveViewController animated:YES];
}
- (IBAction)villageAction:(id)sender {
    
    VPBeautifulVillageController * beautifulVillageController =[VPBeautifulVillageController instantiation];
    [self.navigationController pushViewController:beautifulVillageController animated:YES];
}
- (IBAction)playe:(id)sender {
    
    VPPlayController *playController =[VPPlayController instantiation];
    [self.navigationController pushViewController:playController animated:YES];
}

@end
