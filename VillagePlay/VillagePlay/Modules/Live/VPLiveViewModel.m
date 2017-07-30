//
//  VPLiveViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveViewModel.h"
#import "VPLiveListAPI.h"
#import "YYModel.h"
#import "VPLiveInfoModel.h"
#import "NSString+Size.h"

#define Main_Screen_Height      [UIScreen mainScreen].bounds.size.height
#define Main_Screen_Width       [UIScreen mainScreen].bounds.size.width

@interface VPLiveViewModel ()

@property (strong, nonatomic)NSMutableArray *dataSource;

@property (strong, nonatomic) VPLiveListAPI *liveListAPI;

@property (assign, nonatomic) NSInteger pageNum;

@end

@implementation VPLiveViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.liveListAPI =[[VPLiveListAPI alloc]init];
    }
    return self;
}

- (void)liveListIsFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{

    if (isFirstLoading) {
        self.pageNum =1;
    }
    NSDictionary * params =@{@"pageNum":@(self.pageNum),
                                 @"pageSize":@"20"};
    [self.liveListAPI liveListParams:params success:^(NSDictionary *responseDict) {
        if(self.pageNum ==1){
            [self.dataSource removeAllObjects];
        }
        NSArray * liveArray =[NSArray yy_modelArrayWithClass:[VPLiveInfoModel class] json:responseDict[@"body"]];
        //布局
        //直播列表
        for (VPLiveInfoModel *liveInfoModel in liveArray) {
//            CGFloat liveCellModelHeight =[liveInfoModel.title heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:((Main_Screen_Width-36)/2)-14];
//            if (liveCellModelHeight>34) {
//                liveCellModelHeight =34;
//            }
            XXCellModel * liveCellModel = [XXCellModel instantiationWithIdentifier:@"VPLiveCollectionViewCell" height:273 dataSource:liveInfoModel action:nil];
            [self.dataSource addObject:liveCellModel];
        }
        self.pageNum++;
        success([liveArray count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row{
    
    
    return self.dataSource[row];
}

@end
