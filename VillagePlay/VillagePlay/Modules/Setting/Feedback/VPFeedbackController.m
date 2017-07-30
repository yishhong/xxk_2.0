//
//  VPFeedbackController.m
//  VillagePlay
//
//  Created by Apricot on 16/10/31.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPFeedbackController.h"
#import "UIBarButtonItem+Custom.h"
#import "VPFeedbackViewModel.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"

@interface VPFeedbackController ()

@property (nonatomic, strong) VPFeedbackViewModel *viewModel;
/**
 *  内容控件
 */
@property (strong, nonatomic) IBOutlet UITextView *contentText;

@end

@implementation VPFeedbackController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Setting" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"给我们提意见";
    self.viewModel = [[VPFeedbackViewModel alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    [self.navigationItem.rightBarButtonItem xx_barButtonTitleFont];
}

- (void)submit{
    [self.contentText resignFirstResponder];
    [MBProgressHUD showLoading];
    [self.viewModel submitAdviceContents:self.contentText.text success:^{
        [MBProgressHUD hide];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
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
