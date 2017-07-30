//
//  VPLiveImageTextViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveImageTextViewModel.h"
#import "VPLiveDetailAPI.h"
#import "VPLiveDetailModel.h"
#import "YYModel.h"
#import "NSString+Size.h"

@interface VPLiveImageTextViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPLiveDetailAPI *liveDetailAPI;

@end

@implementation VPLiveImageTextViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.liveDetailAPI =[[VPLiveDetailAPI alloc]init];
    }
    return self;
}

- (void)liveDetailLiveId:(NSUInteger)liveId success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary * params=@{@"version":@"v15",
                            @"liveId":@(liveId)};
    [self.liveDetailAPI liveDetailParams:params success:^(NSDictionary *responseDict) {
        NSArray * liveDetailArray =[NSArray yy_modelArrayWithClass:[VPLiveDetailModel class] json:responseDict[@"body"]];
        //布局
        //图文
        for (VPLiveDetailModel *liveDetailModel in liveDetailArray) {
            XXCellModel * liveHeadCellModel = [XXCellModel instantiationWithIdentifier:@"VPLiveHeadTableViewCell" height:50 dataSource:liveDetailModel action:nil];
            [self.dataSource addObject:liveHeadCellModel];
            
            CGFloat liveTextCellHeight =[liveDetailModel.contentsText heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:[UIScreen mainScreen].bounds.size.width-99];
            if (liveDetailModel.contentsText.length>0) {
                XXCellModel * liveTextCellModel = [XXCellModel instantiationWithIdentifier:@"VPLiveTextTableViewCell" height:liveTextCellHeight+23 dataSource:liveDetailModel.contentsText action:nil];
                [self.dataSource addObject:liveTextCellModel];
            }
            if (liveDetailModel.photoUrl.length>0) {
                XXCellModel * liveImageCellModel = [XXCellModel instantiationWithIdentifier:@"VPLiveImageTableViewCell" height:212 dataSource:liveDetailModel.photoUrl action:nil];
                [self.dataSource addObject:liveImageCellModel];
            }
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

-(void)topicViewModel:(NSArray *)topicViewModel{
    

}



-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    
    
    return self.dataSource[row];
}

@end
