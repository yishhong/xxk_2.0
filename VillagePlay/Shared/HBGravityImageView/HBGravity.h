//
//  HBGravity.h
//  HGLabyrinthDemo
//
//  Created by  易述宏 on 16/8/16.
//  Copyright © 2016年 湖南同禾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface HBGravity : NSObject

@property(strong,nonatomic)CMMotionManager *motionManager;

/**
 *  时间戳
 */
@property(assign,nonatomic)NSTimeInterval timeInterval;

/**
 *  单例创建方法
 *
 *  @return 单例
 */
+(HBGravity *)sharedGravity;

/**
 *  开始重力加速度
 *
 *  @param completeBlock 中级加速度block 返回xyx
 */
-(void)startAccelerometerUpdatesBlock:(void(^)(float x,float y, float z))completeBlock;

/**
 *  开始重力感应
 *
 *  @param completeBlock 陀螺旋block 返回xyx
 */
-(void)startDeviceMotionUpdatesBlock:(void(^)(float x, float y, float z))completeBlock;

/**
 *  开始陀螺旋
 *
 *  @param completeBlock 重力感应block 返回xyx
 */
-(void)startGyroUpdatesBlock:(void(^)(float x, float y, float z))completeBlock;


/**
 *  停止
 */
-(void)stop;

@end
