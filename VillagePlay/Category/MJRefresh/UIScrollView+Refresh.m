//
//  UIScrollView+Refresh.m
//  VillagePlay
//
//  Created by Apricot on 16/10/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import <MJRefresh/MJRefresh.h>
@implementation UIScrollView (Refresh)
- (void)xx_addHeaderRefreshWithBlock:(dispatch_block_t)block{
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(block){
            block();
        }
    }];
    self.mj_header = header;
}

- (void)xx_addFooterRefreshWithBlock:(dispatch_block_t)block{
    MJRefreshFooter * footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if(block){
            block();
        }
    }];
    footer.automaticallyHidden = YES;
    self.mj_footer = footer;
}

- (void)xx_beginRefreshing{
    [self.mj_header beginRefreshing];
}

- (void)xx_endRefreshing{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    } else if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)xx_isHasMoreData:(BOOL)more{
    [self.mj_header endRefreshing];
    if (!more) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mj_footer endRefreshing];
    }
}
@end
