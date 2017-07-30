//
//  VPDriveControllerViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//
#define dtScreenWidth [UIScreen mainScreen].bounds.size.width

#import "VPDriveControllerViewModel.h"
#import "NSString+Size.h"

@interface VPDriveControllerViewModel ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation VPDriveControllerViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)villageDriveLineString:(NSString *)driveLineString villageOhterLineString:(NSString *)ohterLineString{

    //布局
    //出行线路

    if (driveLineString.length>0) {
        
        XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VillageTitleTableViewCell" height:40 dataSource:@"自驾游出行线路" action:nil];
        [self.dataSource addObject:cellModel];
        
        CGFloat driveLineHeight =[driveLineString heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:dtScreenWidth-24];
        XXCellModel * villageSubTitlecellModel = [XXCellModel instantiationWithIdentifier:@"VPDriveContentTableViewCell" height:driveLineHeight dataSource:driveLineString action:nil];
        [self.dataSource addObject:villageSubTitlecellModel];
    }
    if (ohterLineString.length>0) {
        XXCellModel * cellModel = [XXCellModel instantiationWithIdentifier:@"VillageTitleTableViewCell" height:40 dataSource:@"其他出行线路" action:nil];
        [self.dataSource addObject:cellModel];
        
        CGFloat ohterLineHeight =[ohterLineString heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:dtScreenWidth-24];
        XXCellModel * villageSubTitlecellModel = [XXCellModel instantiationWithIdentifier:@"VPDriveContentTableViewCell" height:ohterLineHeight dataSource:ohterLineString action:nil];
        [self.dataSource addObject:villageSubTitlecellModel];
    }
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
