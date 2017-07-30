//
//  VPLiveInfoModel.m
//  VillagePlay
//
//  Created by Apricot on 2016/11/29.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPLiveInfoModel.h"

#import "UIColor+HUE.h"
@implementation VPLiveInfoModel

- (NSDictionary *)liveStateForInfo{
    NSMutableDictionary *stateInfo =[NSMutableDictionary dictionary];
    switch (self.liveState) {
        case 0:{
            [stateInfo setObject:@"未开始" forKey:@"title"];
            [stateInfo setObject:@"vp_live_finish" forKey:@"image"];
            [stateInfo setObject:[UIColor VPDetailColor] forKey:@"color"];
        }break;
        case 1:{
            [stateInfo setObject:@"正在直播" forKey:@"title"];
            [stateInfo setObject:@"vp_live_begin" forKey:@"image"];
            [stateInfo setObject:[UIColor navigationTintColor] forKey:@"color"];
        }break;
        case 2:{
            [stateInfo setObject:@"精彩回顾" forKey:@"title"];
            [stateInfo setObject:@"vp_live_finish" forKey:@"image"];
            [stateInfo setObject:[UIColor VPDetailColor] forKey:@"color"];
        }break;
        default:
            break;
    }
    switch (self.type) {
        case 0:{//图文
            [stateInfo setObject:@"" forKey:@"image"];
        }break;
        case 1:{//视频
            
        }break;
        default:
            break;
    }
    return stateInfo;
}

@end
