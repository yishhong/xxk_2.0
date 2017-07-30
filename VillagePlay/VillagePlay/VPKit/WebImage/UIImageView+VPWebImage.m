//
//  UIImageView+VPWebImage.m
//  VillagePlay
//
//  Created by Apricot on 16/10/18.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIImageView+VPWebImage.h"
//#import <YYWebImage/YYWebImage.h>
#import "UIImageView+WebCache.h"

@implementation NSString (VPWebImage)

- (NSString *)xx_configQiNiuImageUrlWithWidth:(CGFloat)width height:(CGFloat)height{
    return [NSString stringWithFormat:@"%@?imageView2/0/w/%0.0f/h/%0.0f",self,width,height];
}

@end

@implementation UIImage (DownloadImage)

+(void)xx_downImage:(NSString *)imageUrl{
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageRetryFailed|SDWebImageContinueInBackground progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
    }];
}

+ (UIImage *)xx_loadImage:(NSString *)imageURLStr{
    NSURL *imageUrl = [NSURL URLWithString:imageURLStr];
    UIImage *image = nil;
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:imageUrl];
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    image = [imageCache imageFromDiskCacheForKey:key];
    if (!image) {
        [[self class] xx_downImage:imageURLStr];
    }
    return image;
}

@end


@implementation UIImageView (VPWebImage)
- (void)xx_setImageWithURLStr:(NSString *)imageURLStr placeholder:(UIImage *)placeholder{
#warning 需要判断是不是使用的七牛的图片
    NSURL *imageUrl = nil;
    if([imageURLStr rangeOfString:@"image.xiaxiangke.com"].location != NSNotFound){
        NSString * params = [NSString stringWithFormat:@"?imageView2/0/w/%0.0f/h/%0.0f",self.bounds.size.width*2,self.bounds.size.height*2];
//        NSString * params = [NSString stringWithFormat:@"?imageView2/0/w/%0.0f",self.bounds.size.width*2];

        
//        NSString *params = @"?imageslim";
        imageUrl = [NSURL URLWithString:[imageURLStr stringByAppendingString:params]];
        NSLog(@"ImageURL:::>>>%@",imageUrl.absoluteString);
    }else{
        imageUrl = [NSURL URLWithString:imageURLStr];
    }
//    if(!placeholder){
//        placeholder = [UIImage imageNamed:@"vp _destination_playList_Iamge"];
//    }
    if(!imageUrl){
        imageUrl = [NSURL URLWithString:@""];
    }
    if(!placeholder){
        placeholder = [UIImage imageNamed:@"vp_topic_Image"];
    }
    
    [self sd_setImageWithURL:imageUrl placeholderImage:placeholder];
    
//    [self yy_setImageWithURL:imageUrl placeholder:placeholder];
}
- (void)xx_setImageWithURLStr:(NSString *)imageURLStr{
    [self xx_setImageWithURLStr:imageURLStr placeholder:nil];
}
@end
