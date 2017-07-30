//
//  QMUpdateAndPraise.m
//  PraiseAndUpdate
//
//  Created by Apricot on 2017/1/13.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "QMUpdateAndPraise.h"
#import <UIKit/UIKit.h>
#import "InfoPlist.h"

#define KPraise @"K_com.Apricot.Praise"
#define KUpdate @"K_com.Apricot.Update"
#define KVersion @"K_com.Apricot.Version"

@interface QMUpdateAndPraise ()

@property (nonatomic, strong) UIAlertController *praiseAlertController;

@property (nonatomic, strong) UIAlertController *updateAlertController;

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation QMUpdateAndPraise

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static id _shared;
    dispatch_once(&onceToken, ^{
        _shared = [[[self class] alloc] init];
    });
    return _shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        //判断版本号是否一直 不一致则删除以前保存的信息并保存当前的版本号（注：这里版本号取得是build 非Version）
        NSString * versionStr = [self.userDefaults objectForKey:KVersion];
        NSString * nowVersionStr = [InfoPlist buildVersion];
        if(![versionStr isEqualToString:nowVersionStr]){
            [self.userDefaults setObject:nowVersionStr forKey:KVersion];
            [self.userDefaults removeObjectForKey:KPraise];
            [self.userDefaults removeObjectForKey:KUpdate];
            [self.userDefaults synchronize];
        }
    }
    return self;
}

- (void)showPraise{
    //打开应用多长时间弹出
    if(!self.praiseAlertController){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goPraise];
        });
    }
}
- (void)goPraise{
    NSDictionary *praiseDict = [self.userDefaults objectForKey:KPraise];
    if(praiseDict){
        switch ([praiseDict[@"status"] integerValue]) {
            case -1:{//拒绝或者同意
                return;
            }break;
            case 0:{//首次
                //判断打开时长超过3过小时
                CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
                CFTimeInterval beginTime = [praiseDict[@"time"] doubleValue];
                if(endTime< beginTime+(60*60*3)){
                    return;
                }
            }break;
            case 1:{//稍后评论
                //判断是否已经过了30天
                CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
                CFTimeInterval beginTime = [praiseDict[@"time"] doubleValue];
                if(endTime<beginTime+KPraiseTime){
                    return;
                }
                
            }break;
            default:
                break;
        }
        
    }else{
        NSMutableDictionary *dictInfo = [NSMutableDictionary dictionary];
        dictInfo[@"status"] = @(0);
        CFTimeInterval beginTime = CFAbsoluteTimeGetCurrent();
        dictInfo[@"time"] = @(beginTime);
        [self.userDefaults setObject:dictInfo forKey:KPraise];
        [self.userDefaults synchronize];
    }
    
    
    self.praiseAlertController = [UIAlertController alertControllerWithTitle:@"" message:praiseMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *praiseConfirmAction = [UIAlertAction actionWithTitle:praiseConfirmTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dictInfo = [NSMutableDictionary dictionary];
        dictInfo[@"status"] = @(-1);
        [self.userDefaults setObject:dictInfo forKey:KPraise];
        [self.userDefaults synchronize];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openURL]];
    }];
    [self.praiseAlertController addAction:praiseConfirmAction];
    UIAlertAction *praiseOtherAction = [UIAlertAction actionWithTitle:praiseOtherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CFTimeInterval beginTime = CFAbsoluteTimeGetCurrent();
        
        NSMutableDictionary *dictInfo = [NSMutableDictionary dictionary];
        dictInfo[@"status"] = @(1);
        dictInfo[@"time"] = @(beginTime);
        [self.userDefaults setObject:dictInfo forKey:KPraise];
        [self.userDefaults synchronize];
        
    }];
    [self.praiseAlertController addAction:praiseOtherAction];
    
    UIAlertAction *praiseCancelAction = [UIAlertAction actionWithTitle:praiseCancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dictInfo = [NSMutableDictionary dictionary];
        dictInfo[@"status"] = @(-1);
        [self.userDefaults setObject:dictInfo forKey:KPraise];
        [self.userDefaults synchronize];
        //        [self.praiseAlertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.praiseAlertController addAction:praiseCancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.praiseAlertController animated:YES completion:nil];
}

- (void)showUpdateWithMessage:(NSString *)message isForced:(BOOL)isForced{
    CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
    CFTimeInterval beginTime = [[self.userDefaults objectForKey:KUpdate] doubleValue];
    if(endTime < beginTime+KUpdateTime){
        return;
    }
    if(message.length<1){
        message = updateMessage;
    }
    if(self.updateAlertController){
        self.updateAlertController = nil;
    }
    
    self.updateAlertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *updateConfirmAlertAction = [UIAlertAction actionWithTitle:updateConfirmTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openURL]];
    }];
    [self.updateAlertController addAction:updateConfirmAlertAction];
    if(!isForced){
        UIAlertAction *updateCancelAlertAction = [UIAlertAction actionWithTitle:updateCancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CFTimeInterval beginTime = CFAbsoluteTimeGetCurrent();
            //保存拒绝更新的时间
            [self.userDefaults setObject:@(beginTime) forKey:KUpdate];
            [self.userDefaults synchronize];
        }];
        [self.updateAlertController addAction:updateCancelAlertAction];
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.updateAlertController animated:YES completion:nil];
}



@end
