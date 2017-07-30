//
//  UITableViewCell+DataSource.m
//  HotelBusiness
//
//  Created by Apricot on 16/7/15.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UITableViewCell+DataSource.h"

@implementation UIView (DataSource)
+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)xx_configCellWithEntity:(id)entity{
    
}
@end

@implementation UITableViewCell(XXCellEvent)

- (NSIndexPath *)xx_indexPath{
    NSIndexPath *indexPath = [self.xx_tableView indexPathForCell:self];
    return indexPath;
}

- (void)xx_cellClickAtView:(UIView *)view
{
    UITableView *tableView = self.xx_tableView;
    if (tableView) {
        UIResponder *responder = tableView.delegate;
        if (responder) {
            [responder tableView:tableView clickCell:self indexPath:self.xx_indexPath atView:view];
        }
    }
}

- (void)xx_cellClickAtView:(UIView *)view data:(id)data
{
    UITableView *tableView = self.xx_tableView;
    if (tableView) {
        UIResponder *responder = tableView.delegate;
        if (responder) {
            [responder tableView:tableView clickCell:self indexPath:self.xx_indexPath atView:view data:data];
        }
    }
}

- (UITableView *)xx_tableView
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UITableView class]]) {
            return (UITableView *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

@end


@implementation NSObject(XXCellEvent)

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{
    
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view data:(id)data{

}

@end
