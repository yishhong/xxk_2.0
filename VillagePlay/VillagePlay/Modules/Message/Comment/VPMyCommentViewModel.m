//
//  VPMyCommentViewModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/14.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPMyCommentViewModel.h"
#import "VPCommendAPI.h"
#import "VPMyCommendModel.h"
#import "NSString+Size.h"

@interface VPMyCommentViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) VPCommendAPI *commendAPI;

@property (assign, nonatomic) NSInteger pageNum;
@property (assign, nonatomic) NSInteger pageSize;

@end

@implementation VPMyCommentViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.commendAPI = [[VPCommendAPI alloc] init];
        self.pageSize = 20;
        self.pageNum = 1;
    }
    return self;
}

- (void)loadMyCommentMessageWithIsFirst:(BOOL)isFirst success:(void (^)(BOOL isMore))success failure:(void (^)(NSError *))failure{
    if(isFirst){
        //首次加载
        self.pageNum = 1;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] = @(self.pageNum);
    params[@"pageSize"] = @(self.pageSize);
    [self.commendAPI loadUserCommendListWithParams:params success:^(NSDictionary *responseDict) {
        BOOL isMore = NO;
        NSArray *array = [NSArray yy_modelArrayWithClass:[VPMyCommendModel class] json:responseDict[@"body"]];
        NSInteger arrayCount = [array count];
        if(self.pageNum == 1){
            [self.dataSource removeAllObjects];
            isMore = YES;
        }
        for (VPMyCommendModel *myCommendModel in array) {
            XXCellModel *headCellModel = [XXCellModel instantiationWithIdentifier:@"VPMyCommentHeadCell" height:58 dataSource:myCommendModel action:nil];
            [self.dataSource addObject:headCellModel];
            
            CGFloat content = [myCommendModel.content heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:[UIScreen mainScreen].bounds.size.width-63-15];
            content +=8;
            XXCellModel *contentCellModel = [XXCellModel instantiationWithIdentifier:@"VPMyCommentContentCell" height:content dataSource:myCommendModel action:nil];
            [self.dataSource addObject:contentCellModel];
            XXCellModel *sourceCellModel = [XXCellModel instantiationWithIdentifier:@"VPMyCommentSourceCell" height:58 dataSource:myCommendModel action:nil];
            [self.dataSource addObject:sourceCellModel];

        }
        
        if(arrayCount==0||arrayCount<self.pageSize){
            isMore = NO;
        }else{
            isMore =YES;
        }
        self.pageNum++;
        success(isMore);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSInteger)numberOfRows{
    return self.dataSource.count;
}


- (XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[indexPath.row];
}

@end
