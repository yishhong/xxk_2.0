//
//  TicketDetailModel.h
//  VillagePlay
//
//  Created by  易述宏 on 16/10/28.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCellModel.h"
#import "VPTicketDetailModel.h"
#import "VPTicketDetailModel.h"

@interface TicketDetailModel : NSObject

/**
 门票详情

 @param pid 门票ID
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ticketDetailPid:(NSString *)pid success:(void(^)())success failure:(void(^)(NSError * error))failure;


-(void)ticketModel:(NSArray *)ticketModel;

/**
 *  返回Cell行数
 *
 *  @param section <#section description#>
 *
 *  @return <#return value description#>
 */
-(NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 *  获取cell的详细信息
 *
 *  @param row     row坐标
 *  @param section section坐标
 *
 *  @return 返回指定的cell的详细信息
 */

-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section;


/**
 返回model数据

 @return <#return value description#>
 */
- (VPTicketDetailModel *)detailModel;

@end
