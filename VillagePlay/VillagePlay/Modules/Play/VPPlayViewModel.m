//
//  VPPlayViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayViewModel.h"
#import "VPPlayAPI.h"
#import "VPPlayListModel.h"
#import "YYModel.h"

@interface VPPlayViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic)VPPlayAPI *playAPI;
@property (assign, nonatomic) NSInteger pageNum;
@end

@implementation VPPlayViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.playAPI =[[VPPlayAPI alloc]init];
    }
    return self;
}

-(void)palyListlineName:(NSString *)lineName title:(NSString *)title tag:(NSString *)tag orderColumn:(NSString *)orderColumn orderDir:(NSString *)orderDir isFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    if (isFirstLoading) {
        self.pageNum =1;
    }
    NSDictionary *params=@{@"lineName":lineName,
                           @"title":title,
                           @"tag":tag,
                           @"orderColumn":orderColumn,
                           @"orderDir":orderDir,
                           @"pageNum":@(self.pageNum),
                           @"pageSize":@"20"};
    [self.playAPI playListParams:params success:^(NSDictionary *responseDict) {
        if(self.pageNum == 1){
            [self.dataSource removeAllObjects];
        }
        NSArray * playArray =[NSArray yy_modelArrayWithClass:[VPPlayListModel class] json:responseDict[@"body"]];
        //布局
        //精选游玩列表
        for (VPPlayListModel*playListModel in playArray) {
            XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"PlayTableViewCell" height:105 dataSource:playListModel action:nil];
            [self.dataSource addObject:cellModel];
        }
        self.pageNum++;

        success([playArray count]==0?NO:YES);
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
