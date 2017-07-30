//
//  VPQiNiuAPI.m
//  VillagePlay
//
//  Created by Apricot on 16/10/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPQiNiuAPI.h"
#import "NSError+Reason.h"
#import <QiniuSDK.h>



@interface VPQiNiuAPI ()
@property (nonatomic, strong) QNUploadManager *upManager;
@property (nonatomic, strong) QNUploadOption *uploadOption;
@property (nonatomic, assign) NSInteger index;
/**
 *  开始时间
 */
@property (nonatomic, assign) NSTimeInterval beginTime;
@property (nonatomic, copy) NSString *token;

/**
 *  成功回调
 */
@property (copy, nonatomic) void (^singleSuccessBlock)(NSString *);

/**
 *  失败回调
 */
@property (copy, nonatomic) void (^singleFailureBlock)();
@end

@implementation VPQiNiuAPI
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.upManager = [[QNUploadManager alloc] init];
        self.uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
            NSLog(@"%s__KEY:%@ percent:%f",__func__,key,percent);
        } params:@{} checkCrc:YES cancellationSignal:^BOOL{
            return NO;
        }];
        
        self.index = 10;
    }
    return self;
}

- (void)uploadImageTokenWithQiNiuSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    [self sendGETAPI:@"api/QiNiu/GetUploadToken" withParams:nil success:^(NSDictionary *responseDict) {
        self.beginTime = CFAbsoluteTimeGetCurrent();
#warning 暂定
        self.token = responseDict[@"body"];
        success(responseDict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)uploadImageWithImage:(UIImage *)image Success:(void (^)(NSString *))success failure:(void (^)())failure{
    NSData *data = UIImageJPEGRepresentation(image, 0.6);
    NSLog(@"%s图片大小->%zd",__func__,data.length);
    [self.upManager putData:data key:nil token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"QiNiu:Resp->%@",resp);
        if (info.statusCode == 200 && resp) {
//            NSString * url= [NSString stringWithFormat:@"%@%@",@"http://x", ];
            NSString *url = resp[@"key"];

            if (success) {
                success(url);
            }
        }
        else {
            if (failure) {
                failure();
            }
        }
    } option:self.uploadOption];
//    [self.upManager putFile:[[NSBundle mainBundle] pathForResource:@"uploadTest" ofType:@"jpg"] key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        NSLog(@"info:%@ key:%@ resp:%@",info,key,resp);
//        if (info.statusCode == 200 && resp) {
//            NSString *url;
//            
//            if (success) {
//                success(url);
//            }
//        }
//        else {
//            if (failure) {
//                failure();
//            }
//        }
//    } option:self.uploadOption];
}

- (void)uploadImageWithImages:(NSArray *)imageDatas Success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    //userID

//    NSString *token = @"DS7hukNHAIJkH4KYCPEmIQZ7OSB9nTH1TZUQSHPl:TXqzbeCYwzd35qEuEeZn2uDS5Kc=:eyJzY29wZSI6InhpYXhpYW5na2UiLCJkZWFkbGluZSI6MTQ3NzAzOTQwMn0=";
//    NSString *token = self.token;
//
//    NSString *key = [NSString stringWithFormat:@"Test_%ld",self.index];
//    self.index++;
    NSMutableArray *imageUrlArray = [NSMutableArray array];
    __block NSUInteger currentIndex = 0;

    __weak typeof(VPQiNiuAPI *)weakSelf = self;
    self.singleFailureBlock = ^{
        failure([NSError errorMessage:@"图片上传失败!"]);
        return ;
    };
    self.singleSuccessBlock = ^(NSString *url){
        NSLog(@"QiNiu(%zd):%@",currentIndex,url);
        [imageUrlArray addObject:url];
        __strong typeof(VPQiNiuAPI *)strongSelf = weakSelf;
        if([imageUrlArray count] == [imageDatas count]){
            success([imageUrlArray copy]);
            return ;
        }else{
            currentIndex ++;
            [strongSelf uploadImageWithImage:imageDatas[currentIndex] Success:strongSelf.singleSuccessBlock failure:strongSelf.singleFailureBlock];
        }
    };
    if(!self.token){
        [self uploadImageTokenWithQiNiuSuccess:^{
            __strong typeof(VPQiNiuAPI *)strongSelf = weakSelf;
            [self uploadImageWithImage:imageDatas[currentIndex] Success:strongSelf.singleSuccessBlock failure:weakSelf.singleFailureBlock];

        } failure:^(NSError *error) {
            failure(error);
        }];
    }else{
        [self uploadImageWithImage:imageDatas[currentIndex] Success:weakSelf.singleSuccessBlock failure:weakSelf.singleFailureBlock];
    }
    
}

@end
