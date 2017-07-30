//
//  VPVickersViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPVickersViewModel.h"
#import "VPMagazineAPI.h"
#import "VPMagazineModel.h"
#import "YYModel.h"

@interface VPVickersViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPMagazineAPI *magazineAPI;

@property (assign, nonatomic) NSInteger pageNum;

@end

@implementation VPVickersViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.magazineAPI =[[VPMagazineAPI alloc]init];
    }
    return self;
}

- (void)vickListIsFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    
    if (isFirstLoading) {
        self.pageNum =1;
    }
    NSDictionary * params=@{@"pageNum":@(self.pageNum),
                            @"pageSize":@"20"};
    [self.magazineAPI magazineListParams:params success:^(NSDictionary *responseDict) {
        if(self.pageNum == 1){
            [self.dataSource removeAllObjects];
        }
        NSArray * vickArray =[NSArray yy_modelArrayWithClass:[VPMagazineModel class] json:responseDict[@"body"]];
        //布局
        //微刊列表
        for (VPMagazineModel *magazineModel in vickArray) {
            XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VPVickersTableViewCell" height:177 dataSource:magazineModel action:nil];
            [self.dataSource addObject:cellModel];
        }
        self.pageNum++;
        success([vickArray count]==0?NO:YES);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)vickersViewModel:(NSArray *)vickersViewModel{

}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{

    return self.dataSource[row];
}

@end
