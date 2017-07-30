//
//  VPWebTableViewCell.m
//  VillagePlay
//
//  Created by qineng on 16/2/14.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import "VPWebTableViewCell.h"
#import "NSObject+KVO.h"
#import "UIView+Frame.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"

#define dtScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define dtScreenHeight           ([UIScreen mainScreen].bounds.size.height)

@interface VPWebTableViewCell ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) XXCellModel *cellModel;
@end

@implementation VPWebTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return self;
}

- (void)xx_configCellWithEntity:(id)entity{

    self.cellModel = entity;
    NSDictionary *webInfo= self.cellModel.dataSource;
    self.webString =webInfo[@"urlString"];
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    self.webView.delegate = self;
    self.webView.scrollView.bounces =NO;
    if ([webInfo[@"ishidContentsText"] isEqualToString:@""]) {
        
        [self.webView loadHTMLString:self.webString baseURL:nil];
    }else{
        NSURL *url = [NSURL URLWithString:self.webString];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    [self.KVOController observe:self.webView.scrollView keyPath:@"contentSize" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        CGSize contentSize = [change[NSKeyValueChangeNewKey] CGSizeValue];
        
        self.webView.height = contentSize.height;
        self.cellModel.height =self.webView.height;
        [UIView setAnimationsEnabled:NO];
        [self.xx_tableView beginUpdates];
        [self.xx_tableView endUpdates];
        [UIView setAnimationsEnabled:YES];
        //        if ([self.delegate respondsToSelector:@selector(webTableViewCell:webViewHeight:)]) {
        //            [self.delegate webTableViewCell:self webViewHeight:contentSize.height];
        //        }
    }];
    
}

- (void)setUp
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, dtScreenWidth, 40)];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    [self.contentView addSubview:self.webView];
    
//    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    self.indicatorView.center = self.contentView.center;
//    self.indicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
//    [self.contentView addSubview:self.indicatorView];
    

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.webView.delegate = nil;
}

- (void)dealloc
{
    self.webView.delegate = nil;
    self.webView = nil;
}

#pragma mark -- UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if([request.URL.absoluteString isEqualToString:self.webString]){
//        return YES;
//    }
//    if(self.delegate&&[self.delegate respondsToSelector:@selector(webViewWithToSubUrl:)]){
//        [self.delegate webViewWithToSubUrl:request.URL];
//    }
//    return NO;
//}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.indicatorView.hidden = YES;
    [self.indicatorView stopAnimating];
}
@end
