//
//  VPOrdercompleteController.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPOrdercompleteController.h"
#import "UIColor+HUE.h"
#import "VPTabBarController.h"
#import "VPNavigationController.h"
#import "VPOrderController.h"
#import "VPTravelOrderOptionController.h"
#import "VPTicketOrderOptionController.h"
#import "VPHotelOrderOptionController.h"
#import "VPTravelOrderDetailController.h"
#import "VPOrderController.h"

@interface VPOrdercompleteController ()
@property (strong, nonatomic) IBOutlet UILabel *payWayLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIButton *lookOrderButton;
@property (strong, nonatomic) IBOutlet UIButton *completeButton;
@property (strong, nonatomic) IBOutlet UILabel *attentionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *grogshopImageView;
@property (strong, nonatomic) IBOutlet UILabel *grogshopNameLabel;

@end

@implementation VPOrdercompleteController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Travel" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}
/**
 *  查看订单
 *
 *  @param sender <#sender description#>
 */
- (IBAction)lookOrderAction:(id)sender {
 
    VPTabBarController *tabbarVC = (VPTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    VPNavigationController *navigationVC = [tabbarVC.viewControllers lastObject];
    NSArray * oldNavigations = navigationVC.viewControllers;
    NSMutableArray *newNavigations = [NSMutableArray arrayWithObject:[oldNavigations objectAtIndex:0]];
    [newNavigations addObject:[VPOrderController instantiation]];
//    switch (self.channelType) {
//        case VPChannelTypeTravel:
//            [newNavigations addObject:[VPOrderController instantiation]];
//            break;
//        case VPChannelTypeHotel:
//            [newNavigations addObject:[VPOrderController instantiation]];
//            break;
//        case VPChannelTypeTicket:
//            [newNavigations addObject:[VPOrderController instantiation]];
//            break;
//            
//        default:
//            break;
//    }
    navigationVC.viewControllers = newNavigations;
    tabbarVC.selectedViewController = navigationVC;
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  完成
 *
 *  @param sender <#sender description#>
 */
- (IBAction)completeAction:(id)sender {
    /**
     *  跳转到详情页
     *
     *
     */
    VPTabBarController *tabbarVC = (VPTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    VPNavigationController *navigationVC = tabbarVC.selectedViewController;
    NSArray * oldNavigations = navigationVC.viewControllers;
    NSMutableArray *newNavigations = [NSMutableArray arrayWithObject:[oldNavigations objectAtIndex:0]];
    navigationVC.viewControllers = newNavigations;
    switch (self.channelType) {
        case VPChannelTypeTravel:
            break;
        case VPChannelTypeHotel:
            
            break;
        case VPChannelTypeTicket:
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIColor];
    self.payWayLabel.text =self.paymethod;
    self.priceLabel.text =[NSString stringWithFormat:@"%.2f",self.price];
}

-(void)setUIColor{

    self.payWayLabel.textColor =[UIColor VPRedColor];
    self.priceLabel.textColor = [UIColor VPRedColor];
    self.lookOrderButton.layer.borderColor =[UIColor VPContentColor].CGColor;
    self.lookOrderButton.layer.borderWidth =1.0f;
    self.completeButton.layer.borderColor =[UIColor VPContentColor].CGColor;
    self.completeButton.layer.borderWidth =1.0f;
    
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
