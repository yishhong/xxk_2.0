//
//  VPGeneralWebController.hController
//  VillagePlay
//
//  Created by Apricot on 2016/12/9.
//  Copyright © 2016年 Apricot. All rights reserved.
//  共用的webView

#import "VPBaseViewController.h"
#import "CommentDetaileEnum.h"

@interface VPGeneralWebShareModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) id thumImage;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, assign) VPChannelType channelType;

@end


@interface VPGeneralWebController : VPBaseViewController

+ (instancetype)instantiation;


/**
 指定类型
 */
@property (nonatomic, assign) VPChannelType  channelType;

@property (strong, nonatomic) NSString * imageString;

@property (strong, nonatomic) NSString * shareTitle;

/**
 需要加载的URL
 */
@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) VPGeneralWebShareModel *shareModel;

//- (void)configShareTitle:(NSString *)title desc:(NSString *)desc thumImage:(id)thumImage shareUrl:(NSString *)url;

@end
