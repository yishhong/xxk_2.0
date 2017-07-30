//
//  VPVickersDetailController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPVickersDetailController.h"
#import "VPShareManage.h"

@interface VPVickersDetailController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic)UIBarButtonItem * shareButtonItem;

@end

@implementation VPVickersDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Vickers" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem =self.shareButtonItem;
    NSURL * url =[NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest * request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark -Response Action

/**
 *  分享
 */
-(void)shareAction{
    
    //    显示分享面板
    [VPShareManage getShareWebPageToPlatform:VPChannelTypeMagazine title:@"下乡客"  descr:@"快点来" shareUrl:@"http://www.xiaxiangke.com" thumImage:@"icon_mark"];
}

#pragma mark -setter or getter
-(UIBarButtonItem*)shareButtonItem{
    
    if (!_shareButtonItem) {
        _shareButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_share_white"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    }
    return _shareButtonItem;
}

@end
