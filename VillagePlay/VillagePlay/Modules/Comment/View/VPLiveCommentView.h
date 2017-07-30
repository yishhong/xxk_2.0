//
//  VPLiveCommentView.h
//  VillagePlay
//
//  Created by  易述宏 on 16/11/21.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VPLiveCommentViewDelegate <NSObject>

-(void)commentContent:(NSString *)commentCont;

@end

@interface VPLiveCommentView : UIView

@property(strong, nonatomic)id<VPLiveCommentViewDelegate>delegate;

@end
