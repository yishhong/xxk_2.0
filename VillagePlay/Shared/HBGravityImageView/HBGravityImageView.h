//
//  HBGravityImageView.h
//  HGLabyrinthDemo
//
//  Created by  易述宏 on 16/8/16.
//  Copyright © 2016年 湖南同禾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBGravityImageView : UIView

@property(strong,nonatomic)UIImage * image;
@property(strong,nonatomic)UIImageView * imageView;

//开始动力感应
-(void)startAnimation;

/**
 *  停止动力感应
 */
-(void)stopAnimation;

@end
