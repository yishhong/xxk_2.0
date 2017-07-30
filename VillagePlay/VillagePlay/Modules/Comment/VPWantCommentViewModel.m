//
//  VPWantCommentViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/1.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPWantCommentViewModel.h"
#import "VPCommendAPI.h"
#import "VPQiNiuAPI.h"
#import "VPPostCommenModel.h"
#import "VPUserManager.h"
#import "NSError+Reason.h"

@interface VPWantCommentViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) VPCommendAPI *commendAPI;
@property (nonatomic, strong) VPQiNiuAPI * qiNiuAPI;


@property (strong, nonatomic) VPPostCommenModel *postCommenModel;

@end

@implementation VPWantCommentViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.commendAPI = [[VPCommendAPI alloc] init];
        self.qiNiuAPI = [[VPQiNiuAPI alloc] init];
        self.dataSource = [NSMutableArray array];
        self.imageArray = [NSMutableArray array];
        self.postCommenModel = [[VPPostCommenModel alloc] init];
        self.postCommenModel.imgs = self.imageArray;
//        [self.imageArray addObject:@{@"type":@0,@"image":[UIImage imageNamed:@"btn_photo_add"]}];
    }
    return self;
}
- (void)layerUI{
    self.postCommenModel.userId = [VPUserManager sharedInstance].xx_userinfoID;
    self.postCommenModel.vid = [@(self.objeID) stringValue];
    self.postCommenModel.typeId = [@(self.channelType) stringValue];
    [self.dataSource removeAllObjects];
    XXCellModel *starCellModel = [XXCellModel instantiationWithIdentifier:@"VPWantCommentStarCell" height:44 dataSource:self.postCommenModel action:nil];
    [self.dataSource addObject:starCellModel];
    XXCellModel *valueCellModel = [XXCellModel instantiationWithIdentifier:@"VPWantCommentValueCell" height:170 dataSource:self.postCommenModel action:nil];
    [self.dataSource addObject:valueCellModel];
    XXCellModel *imageCellModel = [XXCellModel instantiationWithIdentifier:@"VPWantCommentImageCell" height:120 dataSource:self.imageArray action:nil];
    [self.dataSource addObject:imageCellModel];
}

- (NSInteger)numberOfRows{
    return [self.dataSource count];
}

- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}

- (void)submitCommentSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //首先验证评论是否为空 目前必须的填写评论内容才能提交评论 可以没有评论图片
    if(self.postCommenModel.content.length<1){
        NSError *error = [NSError errorMessage:@"评论不能为空"];
        failure(error);
        return;
    }
    if([self.postCommenModel.imgs count]>1){
        NSMutableArray *postImage =  [NSMutableArray array];
        for (NSDictionary *dict in self.postCommenModel.imgs) {
            if([dict[@"type"] isEqual:@1]){
                [postImage addObject:dict[@"image"]];
            }
        }
        [self.qiNiuAPI uploadImageWithImages:postImage Success:^(NSArray *imageUrlArray) {
            NSMutableArray *postImageArray = [NSMutableArray array];
            for (NSString *imageStr in imageUrlArray) {
                [postImageArray addObject:[NSString stringWithFormat:@"http://image.xiaxiangke.com/%@",imageStr]];
            }
            self.postCommenModel.imgs = postImageArray;
            [self addCommendSuccess:^{
                success();
            } failure:^(NSError *error) {
                failure(error);
            }];
        } failure:^(NSError *error) {
            failure(error);
        }];
    }else{
        self.postCommenModel.imgs = [NSArray array];
        [self addCommendSuccess:^{
            success();
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (void)addCommendSuccess:(void (^)())success failure:(void (^)(NSError *error))failure{
    NSDictionary *params = [self.postCommenModel yy_modelToJSONObject];
    [self.commendAPI addCommendWithParams:params success:^(NSDictionary *responseDict) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
