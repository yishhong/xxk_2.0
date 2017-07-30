//
//  VPBeautifulVillageDetailViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBeautifulVillageDetailViewModel.h"
#import "VPVillageAPI.h"
#import "YYModel.h"
#import "NSString+Size.h"
#import "VPUserManager.h"
#import "VPCommentaryModel.h"
#import "VPCommendAPI.h"
#import "CommentDetaileEnum.h"


#define dtScreenWidth [UIScreen mainScreen].bounds.size.width

@interface VPBeautifulVillageDetailViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) VPVillageAPI *villageAPI;
@property (strong, nonatomic) VPVillageDetailModel * villageDetailModel;
@property (strong, nonatomic) VPCommendAPI * commentAPI;
@end

@implementation VPBeautifulVillageDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.villageAPI = [[VPVillageAPI alloc] init];
        self.commentAPI =[[VPCommendAPI alloc]init];
    }
    return self;
}

- (void)villageDetailID:(NSString *)villageID success:(void (^)())success failure:(void (^)(NSError *))failure{
    //如果没有登录以用户为0处理
    NSString *userid = [VPUserManager sharedInstance].xx_userinfoID.length>0?[VPUserManager sharedInstance].xx_userinfoID:@"0";
    
    NSDictionary *params =@{@"version":@"v14",
                            @"id":villageID,
                            @"userid":userid
                            };
    [self.villageAPI villageDetailParams:params success:^(NSDictionary *responseDict) {
        [self.dataSource removeAllObjects];
        self.villageDetailModel =[VPVillageDetailModel yy_modelWithJSON:responseDict[@"body"]];
        //布局
        //乡村详情图文
        for (VPLstSpecialModel *lstSpecialModel in self.villageDetailModel.lstSpecial) {
            
            if (lstSpecialModel.title.length>0) {
                XXCellModel * textAndImageCellModel = [XXCellModel instantiationWithIdentifier:@"VillageTitleTableViewCell" height:28 dataSource:lstSpecialModel.title action:nil];
                [self.dataSource addObject:textAndImageCellModel];
            }
            
            if (lstSpecialModel.textContents.length>0) {
                
                NSString *contentStr =lstSpecialModel.textContents;

                CGSize contentTextSize =[contentStr heightWithFont:[UIFont systemFontOfSize:14] paragraph:8 constrainedToWidth:dtScreenWidth-24 textString:contentStr];
                CGFloat contentHeight=contentTextSize.height+12;
                XXCellModel * subTitleCellModel = [XXCellModel instantiationWithIdentifier:@"VillageSubTitleTableViewCell" height:contentHeight dataSource:lstSpecialModel.textContents action:nil];
                [self.dataSource addObject:subTitleCellModel];
            }
            
            if (lstSpecialModel.photoUrl.length>0) {
                XXCellModel * mageCellModel = [XXCellModel instantiationWithIdentifier:@"VillageImageTableViewCell" height:189 dataSource:lstSpecialModel.photoUrl action:nil];
                [self.dataSource addObject:mageCellModel];
            }
        }
        //查看全文文字
        XXCellModel *lookFullCellModel = [XXCellModel instantiationWithIdentifier:@"VillageLookFullTextTableViewCell" height:44 dataSource:nil action:nil];
        [self.dataSource addObject:lookFullCellModel];
        
        //空行
        XXCellModel * linesCellModel1 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:linesCellModel1];
        
        //地址
        NSDictionary *addressInfo =@{@"location":[NSString stringWithFormat:@"地址:%@",self.villageDetailModel.address],
                                     @"hide":@""};
        XXCellModel * addressCellModel = [XXCellModel instantiationWithIdentifier:@"VPAddressTableViewCell" height:42 dataSource:addressInfo action:nil];
        [self.dataSource addObject:addressCellModel];
        
        //地址图片
        XXCellModel * addressImageCellModel = [XXCellModel instantiationWithIdentifier:@"VPAddressImageTableViewCell" height:112 dataSource:self.villageDetailModel.location action:nil];
        [self.dataSource addObject:addressImageCellModel];
        
        //出行
        XXCellModel * outCellModel = [XXCellModel instantiationWithIdentifier:@"VPDriveTableViewCell" height:42 dataSource:[NSString stringWithFormat:@"出行:%@",self.villageDetailModel.journey] action:nil];
        [self.dataSource addObject:outCellModel];
        
        //空行
        XXCellModel * linesCellModel3 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:linesCellModel3];
        
        //相关推荐
//        XXCellModel * recommendCellModel = [XXCellModel instantiationWithIdentifier:@"TopicRecommendTableViewCell" height:54 dataSource:nil action:nil];
//        [self.dataSource addObject:recommendCellModel];
//        
//        //各种推荐
//        for (int i=0; i<3; i++) {
//            XXCellModel *  relatedRecommentCell= [XXCellModel instantiationWithIdentifier:@"TopicRelatedRecommentTableViewCell" height:189 dataSource:nil action:nil];
//            [self.dataSource addObject:relatedRecommentCell];
//        }
        //空行
//        XXCellModel * linesCellModel4 = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
//        [self.dataSource addObject:linesCellModel4];
        
        //评论接口
        NSDictionary * commentParams =@{@"VillageID":villageID,
                                        @"commendType":@(VPChannelTypeVillage),
                                        @"pageNum":@"",
                                        @"pageSize":@"5"};
        [self.commentAPI loadCommendListWithParams:commentParams success:^(NSDictionary *responseDict) {
            NSArray * commentArray =[NSArray yy_modelArrayWithClass:[VPCommentaryModel class] json:responseDict[@"body"]];
            if (commentArray.count>0) {
                //评论数
                XXCellModel * commentNumberCellModel = [XXCellModel instantiationWithIdentifier:@"VillageCommentTableViewCell" height:40 dataSource:nil action:nil];
                [self.dataSource addObject:commentNumberCellModel];
                
                for (VPCommentaryModel * commentaryModel in commentArray) {
                    
                    XXCellModel * commentHeadImageCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentHeadImageViewTableViewCell" height:70 dataSource:commentaryModel action:nil];
                    [self.dataSource addObject:commentHeadImageCellModel];
                    
                    if (commentaryModel.content.length>0) {
                        CGFloat contHeight =[commentaryModel.content heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:[UIScreen mainScreen].bounds.size.width-78];
                        XXCellModel * commentContentCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentContentTableViewCell" height:contHeight+16 dataSource:@{@"commentModel":commentaryModel,                                                   @"isLineHide":@""} action:nil];
                        [self.dataSource addObject:commentContentCellModel];
                    }
                    
                    if (commentaryModel.imgs.count>0) {
                        XXCellModel * commentContentImageCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentContentImageViewTableViewCell" height:85 dataSource:commentaryModel action:nil];
                        [self.dataSource addObject:commentContentImageCellModel];
                    }
                    XXCellModel * commentLineCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentLineTableViewCell" height:1 dataSource:nil action:nil];
                    [self.dataSource addObject:commentLineCellModel];
                }
                XXCellModel * lookMoreCommentCellModel =[XXCellModel instantiationWithIdentifier:@"VillageLookMoreCommentTableViewCell" height:40 dataSource:nil action:nil];
                [self.dataSource addObject:lookMoreCommentCellModel];
            }else{
            
                XXCellModel * commentNoDataCellModel =[XXCellModel instantiationWithIdentifier:@"VPHotelCommentNoDataTableViewCell" height:164 dataSource:nil action:nil];
                [self.dataSource addObject:commentNoDataCellModel];
            }
            success();
        } failure:^(NSError *error) {
            failure(error);
        }];
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

- (VPVillageDetailModel *)detailModel{

    return self.villageDetailModel;
}

@end
