//
//  HBGravity.m
//  HGLabyrinthDemo
//
//  Created by  易述宏 on 16/8/16.
//  Copyright © 2016年 湖南同禾. All rights reserved.
//

#import "HBGravity.h"

typedef void(^completeBlockGyro)(float x,float y,float z);
typedef void(^completeBlockAccelerometer)(float x,float y,float z);
typedef void(^completeBlockDeviceMotion)(float x,float y,float z);

@interface HBGravity()

@property(strong,nonatomic)NSOperationQueue * queue;

@property(assign,nonatomic)completeBlockGyro completeBlockGyroBlock;

@property(assign,nonatomic)completeBlockAccelerometer completeBlockAccelerometerBlock;

@property(assign,nonatomic)completeBlockDeviceMotion completeBlockDeviceMotionBlock;

@end

@implementation HBGravity

#pragma mark -单例
+(HBGravity *)sharedGravity{
    
    static HBGravity * gravity =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        gravity =[[self alloc]init];
    });
    return gravity;
}

#pragma mark -初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [self configGravity];
    }
    return self;
}

#pragma mark - Custom method
-(void)configGravity{

    self.motionManager =[[CMMotionManager alloc]init];
    //初始化队列线程
    self.queue =[[NSOperationQueue alloc]init];
}

/**
 *  加速度
 *
 *  @param completeBlock <#completeBlock description#>
 */
-(void)startAccelerometerUpdatesBlock:(void (^)(float, float, float))completeBlock{
  //判断加速度
    if (self.motionManager.accelerometerAvailable) {
        self.motionManager.gyroUpdateInterval =self.timeInterval;
        [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            self.completeBlockAccelerometerBlock =completeBlock;
            if (error) {
                
                [self.motionManager stopAccelerometerUpdates];
                NSLog(@"%@",error.localizedDescription);
                
            }else{
            
                [self performSelectorOnMainThread:@selector(accelerometerUpdate:) withObject:accelerometerData waitUntilDone:NO];
            }
        }];
    }else{
    
        NSLog(@"设备没有加速器");
    }
}

/**
 *  重力感应
 *
 *  @param completeBlock <#completeBlock description#>
 */
-(void)startDeviceMotionUpdatesBlock:(void (^)(float, float, float))completeBlock{
    
    //判断重力感应
    if (self.motionManager.deviceMotionAvailable) {
        
        self.motionManager.deviceMotionUpdateInterval =self.timeInterval;
        [self.motionManager startDeviceMotionUpdatesToQueue:self.queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            if (error) {
                
                [self.motionManager stopDeviceMotionUpdates];
                NSLog(@"%@",error.localizedDescription);
                
            }else{
            
                self.completeBlockDeviceMotionBlock =completeBlock;
                [self performSelectorOnMainThread:@selector(deviceMotionUpdate:) withObject:motion waitUntilDone:NO];
            }
        }];
    }else{
    
        NSLog(@"设备没有重力感应");
    }
}

/**
 *  陀螺旋
 *
 *  @param completeBlock <#completeBlock description#>
 */
-(void)startGyroUpdatesBlock:(void (^)(float, float, float))completeBlock{

    //判断陀螺旋是否可用
    if (self.motionManager.gyroAvailable) {
        
        self.motionManager.gyroUpdateInterval =self.timeInterval;
        [self.motionManager startGyroUpdatesToQueue:self.queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            
            self.completeBlockGyroBlock =completeBlock;
            if (error) {
                
                [self.motionManager stopGyroUpdates];
                NSLog(@"%@",error.localizedDescription);
                
            }else{
            
                [self performSelectorOnMainThread:@selector(gyroUpdate:) withObject:gyroData waitUntilDone:NO];
            }
        }];
    }else{
    
        NSLog(@"没有陀螺旋");
    }
}


-(void)stop{

    [self.motionManager stopAccelerometerUpdates];
    [self.motionManager stopGyroUpdates];
    [self.motionManager stopDeviceMotionUpdates];
}


-(void)accelerometerUpdate:(CMAccelerometerData *)accelerometerData{

    self.completeBlockAccelerometerBlock(accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
}

-(void)deviceMotionUpdate:(CMDeviceMotion *)motion{

    self.completeBlockDeviceMotionBlock(motion.rotationRate.x,motion.rotationRate.y,motion.rotationRate.z);
}

-(void)gyroUpdate:(CMGyroData *)gyroData{

    self.completeBlockGyroBlock(gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
}


@end
