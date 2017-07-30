//
//  VPPlayIntroduceCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayIntroduceCell.h"
#import "UITableViewCell+DataSource.h"
#import "XXCellModel.h"
#import "VPPlayDetailModel.h"
#import "NSObject+KVO.h"
#import "UIView+Frame.h"


@interface VPPlayIntroduceCell ()<UIWebViewDelegate>
@property (nonatomic, strong) XXCellModel *cellModel;

@end

@implementation VPPlayIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)xx_configCellWithEntity:(id)entity{
    self.cellModel = entity;
    NSDictionary *cellInfo = self.cellModel.dataSource;
    VPPlayDetailModel* playDetailModel = cellInfo[@"value"];
    [self.webView loadHTMLString:playDetailModel.introduce baseURL:nil];
    [(UIScrollView *)[[self.webView subviews] objectAtIndex:0] setBounces:NO];
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",request.URL.absoluteString);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"var script = document.createElement('script');"
      "script.type = 'text/javascript';"
      "script.text = \"function ResizeImages() { "
      "var myimg,oldwidth,oldheight;"
      "var maxwidth=%f;"// 图片宽度
      "for(i=0;i <document.images.length;i++){" "myimg = document.images[i];" "if(myimg.width > maxwidth){"
      "myimg.width = maxwidth;"
      "}"
      "}"
      "}\";"
      "document.getElementsByTagName('head')[0].appendChild(script);",[UIScreen mainScreen].bounds.size.width-20]];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"]floatValue];
    self.cellModel.height = height;
    [UIView setAnimationsEnabled:NO];
    [self.xx_tableView beginUpdates];
    [self.xx_tableView endUpdates];
    [UIView setAnimationsEnabled:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
