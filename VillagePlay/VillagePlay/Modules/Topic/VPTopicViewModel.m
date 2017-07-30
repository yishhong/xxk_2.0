//
//  VPTopicViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTopicViewModel.h"
#import "VPTopicAPI.h"
#import "YYModel.h"
#import "VPTopicListModel.h"

@interface VPTopicViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic)VPTopicAPI *topicAPI;
@property (assign, nonatomic)NSInteger pageNum;

@end

@implementation VPTopicViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.topicAPI =[[VPTopicAPI alloc]init];
        self.pageNum =1;
    }
    return self;
}

-(void)topicListIsFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    if (isFirstLoading) {
        self.pageNum = 1;
    }
    NSDictionary * dic =@{@"version":@"v14",
                          @"pageNum":@(self.pageNum),
                          @"pageNum":@"20"};
    [self.topicAPI topicListParams:dic success:^(NSDictionary *responseDict) {
        if(self.pageNum == 1){
            [self.dataSource removeAllObjects];
        }
        NSArray * topArray =[NSArray yy_modelArrayWithClass:[VPTopicListModel class] json:responseDict[@"body"]];
        for (int i=0; i<topArray.count; i++) {
            VPTopicListModel * topicListModel =topArray[i];
            XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"TopicTableViewCell" height:195 dataSource:topicListModel action:nil];
            [self.dataSource addObject:cellModel];
        }
        self.pageNum++;
        success([topArray count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{

    
    return self.dataSource[row];
}


@end
