//
//  VPPostCommenModel.h
//  VillagePlay
//
//  Created by Apricot on 2016/12/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPCommentaryModel.h"

@interface VPPostCommenModel : VPCommentaryModel
@property (nonatomic, strong) NSString *typeId;
/*
 {
 "imgs": [
 "string"
 ],
 "typeId": "string",
 "vid": "string",
 "content": "string",
 "userId": "string",
 "star": "string",
 "beUserId": "string",
 "beNickname": "string"
 }
 */
@end
