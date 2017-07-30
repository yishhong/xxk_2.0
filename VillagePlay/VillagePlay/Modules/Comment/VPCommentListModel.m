//
//  VPCommentListModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/8.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentListModel.h"
#import "VPCommentaryModel.h"
#import "NSString+Size.h"
#import "VPCommendAPI.h"
#import "YYModel.h"

@interface VPCommentListModel()

@property(strong, nonatomic)NSMutableArray * dataSource;

@property (strong, nonatomic) VPCommendAPI *commendAPI;

@property (assign ,nonatomic) NSInteger pageNum;

@end

@implementation VPCommentListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.commendAPI =[[VPCommendAPI alloc]init];
        self.pageNum =1;
    }
    return self;
}

- (void)commentListVillageID:(NSString *)VillageID commendType:(VPChannelType)commendType IsFirstLoading:(BOOL)isFirstLoading success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{

    if (isFirstLoading) {
        self.pageNum =1;
    }
    NSDictionary * params =@{@"VillageID":VillageID,
                             @"commendType":@(commendType),
                             @"pageNum":@(self.pageNum),
                             @"pageSize":@"10"};
    [self.commendAPI loadCommendListWithParams:params success:^(NSDictionary *responseDict) {
//        NSInteger index = [self.dataSource count];
        if(self.pageNum ==1){
            [self.dataSource removeAllObjects];
//            index =0;
        }
//        else{
//            //这句已经无效了
//            index -= 2;
//        }
        NSArray * commentArray =[NSArray yy_modelArrayWithClass:[VPCommentaryModel class] json:responseDict[@"body"]];
        for (VPCommentaryModel * commentModel in commentArray) {
            
            CGFloat conentHeight =[commentModel.content heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:[UIScreen mainScreen].bounds.size.width-(62+16)];
            if (commendType == VPChannelTypeLive) {
                
                XXCellModel * commentTypeCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentHeadImageViewTableViewCell" height:70 dataSource:commentModel action:nil];
                [self.dataSource addObject:commentTypeCellModel];
//                index++;
                //文
                if (commentModel.content.length>0) {
                    XXCellModel * contentOrderCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentContentTableViewCell" height:conentHeight+16 dataSource:@{@"isLineHide":@"1",
                                                                                                                                                                     @"commentModel":commentModel?:@""} action:nil];
                    [self.dataSource addObject:contentOrderCellModel];
//                    index++;
                }
            }else{
                
                XXCellModel * commentTypeCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentTableViewCell" height:70 dataSource:commentModel action:nil];
                [self.dataSource addObject:commentTypeCellModel];
//                index++;
                
                //文
                if (commentModel.content.length>0) {
                    
                    XXCellModel * contentOrderCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentContentTableViewCell" height:conentHeight+16 dataSource:@{@"isLineHide":@"",
                                                                                                                                                           @"commentModel":commentModel?:@""} action:nil];
                    [self.dataSource addObject:contentOrderCellModel];
//                    index++;
                }
                //collectionView滑动图片
                if (commentModel.imgs.count>0) {
                    XXCellModel * contentImageViewCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentContentImageViewTableViewCell" height:85 dataSource:commentModel action:nil];
                    [self.dataSource addObject:contentImageViewCellModel];
//                    index++;
                }
            }
            XXCellModel * commentLineCellModel = [XXCellModel instantiationWithIdentifier:@"VPCommentLineTableViewCell" height:1 dataSource:nil action:nil];
            [self.dataSource addObject:commentLineCellModel];
        }
            //查看更多评论
            if(commendType != VPChannelTypeLive &&[commentArray count]>0){
                XXCellModel * lookMoreCommentCellModel = [XXCellModel instantiationWithIdentifier:@"VillageLookMoreCommentTableViewCell" height:40 dataSource:nil action:nil];
                [self.dataSource addObject:lookMoreCommentCellModel];
        }
        self.pageNum++;
        success([commentArray count]==0?NO:YES);

    } failure:^(NSError *error) {
        failure(error);
    }];
}
-(NSInteger)numberOfRows{
    
    return self.dataSource.count;
}


-(XXCellModel *)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return self.dataSource[indexPath.row];
}


@end
