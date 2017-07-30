//
//  VPTicketDropView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/10.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPTicketDropView.h"
#import "JSDropDownMenu.h"
#import "UIColor+HUE.h"
#import "VPTagModel.h"

@interface VPTicketDropView ()<JSDropDownMenuDelegate,JSDropDownMenuDataSource>


@property (assign, nonatomic) NSInteger leftCurrentIndex;

@property (assign, nonatomic) NSInteger rightCurrentIndex;

@property (strong, nonatomic) JSDropDownMenu *menu;


@property (nonatomic, strong) NSArray *leftArray;

@property (nonatomic, strong) NSArray *rightArray;

@end

@implementation VPTicketDropView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.leftCurrentIndex = 0;
    self.rightCurrentIndex = 0;
    self.menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
    self.menu.indicatorColor = [UIColor VPContentColor];
    self.menu.separatorColor = [UIColor VPBackgroundColor];
    self.menu.textColor = [UIColor VPContentColor];

}

- (void)configLeftData:(NSArray *)leftArray rightData:(NSArray *)rightArray{
    self.leftArray = leftArray;
    self.rightArray = rightArray;
    self.menu.dataSource = self;
    self.menu.delegate = self;
    [self.superview addSubview:self.menu];
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 2;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    if(column == 1){
        return self.rightCurrentIndex;
    }
    return self.leftCurrentIndex;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    switch (column) {
        case 0:{
            return [self.leftArray count];
        }break;
        case 1:{
            return [self.rightArray count];
        }break;
        default:
            break;
    }
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    switch (column) {
        case 0:{
            VPTagModel * tagModel=[self.leftArray objectAtIndex:self.leftCurrentIndex];
            return tagModel.tagName;
        }break;
        case 1:{
            return [self.rightArray objectAtIndex:self.rightCurrentIndex];
        }break;
        default:
            break;
    }
    return @"";
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
    switch (indexPath.column) {
        case 0:{
            VPTagModel * tagModel=[self.leftArray objectAtIndex:indexPath.row];
            return tagModel.tagName;
        }break;
        case 1:{
            return [self.rightArray objectAtIndex:indexPath.row];
        }break;
        default:
            break;
    }
    return @"";
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    switch (indexPath.column) {
        case 0:{
            self.leftCurrentIndex = indexPath.row;
            VPTagModel * tagModel=[self.leftArray objectAtIndex:indexPath.row];
            if ([self.delegate respondsToSelector:@selector(whereStr:)]) {
                [self.delegate whereStr:tagModel.tagName];
            }
        }break;
        case 1:{
            self.rightCurrentIndex = indexPath.row;
            if ([self.delegate respondsToSelector:@selector(orderby:)]) {
                [self.delegate orderby:indexPath.row];
            }
        }
        default:
            break;
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
