//
//  TopicDetailImageTextModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/2.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TopicDetailImageTextViewModel.h"
#import "NSObject+KVO.h"

@interface TopicDetailImageTextViewModel ()

@property(strong, nonatomic)NSMutableArray * dataSource;

@end

@implementation TopicDetailImageTextViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

-(void)topicDetailImageTextModel:(VPTopicDetailModel *)topicDetailImageTextModel{

    //布局
    //专题详情图文web
        XXCellModel * cellWebModel = [XXCellModel instantiationWithIdentifier:@"VPWebTableViewCell" height:300 dataSource:topicDetailImageTextModel.projecturl action:nil];
        [self.dataSource addObject:cellWebModel];
    
    XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"TopicRecommendTableViewCell" height:54 dataSource:nil action:nil];
    [self.dataSource addObject:cellModel];
    NSMutableArray * recomment =[NSMutableArray arrayWithArray:topicDetailImageTextModel.lstVillage];
    for (int i=0; i<recomment.count; i++) {
        NSArray * recommnetArr =recomment[i];
        XXCellModel *  relatedRecommentCell= [XXCellModel instantiationWithIdentifier:@"TopicRelatedRecommentTableViewCell" height:189 dataSource:recommnetArr action:nil];
        [self.dataSource addObject:relatedRecommentCell];
    }
}



-(NSInteger)numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{

    
    return self.dataSource[row];
}

@end
