//
//  VPImgListModel.h
//  VillagePlay
//
//  Created by  易述宏 on 2016/11/30.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPImgListModel : NSObject

@property (nonatomic, strong) NSString *imgPix;

/**
 图片大小
 */
@property (nonatomic, strong) NSString *fromStr;

/**
 图片id
 */
@property (nonatomic, assign) NSInteger imgListIdentifier;

/**
 */
@property (nonatomic, strong) NSString *thumbnailImg;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *originalImg;

/**
 <#Description#>
 */
@property (nonatomic, assign) NSInteger quoteId;

/**
 时间
 */
@property (nonatomic, strong) NSString *createDate;

@end
