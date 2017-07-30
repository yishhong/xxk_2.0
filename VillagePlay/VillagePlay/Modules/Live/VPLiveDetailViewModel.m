//
//  VPLiveDetailViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/3.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveDetailViewModel.h"
#import "VPLiveDetailAPI.h"
#import "VPRecommendModel.h"
#import "VPCommendAPI.h"
#import "VPPostCommenModel.h"
#import "YYModel.h"
#import "VPUserManager.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height

@interface VPLiveDetailViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPCommendAPI *commendAPI;

@property (strong, nonatomic) VPPostCommenModel *postCommenModel;


@end

@implementation VPLiveDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.commendAPI = [[VPCommendAPI alloc] init];
        self.postCommenModel =[[VPPostCommenModel alloc]init];
    }
    return self;
}

-(void)liveDetailViewModel:(VPLiveInfoModel *)liveDetailViewModel{
    
    self.postCommenModel.userId =[[VPUserManager sharedInstance]xx_userinfoID];
    self.postCommenModel.typeId =[NSString stringWithFormat:@"%zd",self.channelType];
    self.postCommenModel.vid =[NSString stringWithFormat:@"%zd",liveDetailViewModel.pid];
    //布局
    //点评播放数
    XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VPLiveDetailTableViewCell" height:75 dataSource:liveDetailViewModel action:nil];
        [self.dataSource addObject:cellModel];
    
    //空行
    XXCellModel * blankLineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
    [self.dataSource addObject:blankLineCellModel];
    
    //相关推荐
//    XXCellModel * recommendCellModel = [XXCellModel instantiationWithIdentifier:@"TopicRecommendTableViewCell" height:54 dataSource:nil action:nil];
//    [self.dataSource addObject:recommendCellModel];
//    
//    XXCellModel * recommendListCellModel = [XXCellModel instantiationWithIdentifier:@"TopicRelatedRecommentTableViewCell" height:189 dataSource:nil action:nil];
//    [self.dataSource addObject:recommendListCellModel];
    
    //空行
//    XXCellModel *lineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
//    [self.dataSource addObject:lineCellModel];
    
    //滑动菜单
    XXCellModel *detailSlideCellModel = [XXCellModel instantiationWithIdentifier:@"VPTravelDetailSlideTableViewCell" height:Main_Screen_Height-(64) dataSource:nil action:nil];
    
    [self.dataSource addObject:detailSlideCellModel];
}

- (void)liveAddCommendContent:(NSString *)content success:(void (^)())success failure:(void (^)(NSError *))failure{

    self.postCommenModel.content =content;
    NSDictionary *params =[self.postCommenModel yy_modelToJSONObject];
    [self.commendAPI addCommendWithParams:params success:^(NSDictionary *responseDict) {
        success();
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
