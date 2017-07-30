//
//  VPWebTableViewCell.h
//  VillagePlay
//
//  Created by qineng on 16/2/14.
//  Copyright © 2016年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VPWebTableViewCell;

@protocol VPWebTableViewCellDelegate <NSObject>

- (void)webTableViewCell:(VPWebTableViewCell *)cell webViewHeight:(CGFloat)height;
- (void)webViewWithToSubUrl:(NSURL *)openURL;
@end

@interface VPWebTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *webString;
@property (nonatomic, weak) id<VPWebTableViewCellDelegate> delegate;

@end
