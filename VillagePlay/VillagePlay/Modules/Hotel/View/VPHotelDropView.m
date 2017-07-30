//
//  VPHotelDropView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelDropView.h"
#import "JSDropDownMenu.h"
#import "UIColor+HUE.h"
#import "VPLocationManager.h"
#import "MBProgressHUD+Loading.h"

@interface VPHotelDropView ()<JSDropDownMenuDelegate,JSDropDownMenuDataSource>

@property (assign, nonatomic) NSInteger leftCurrentIndex;

@property (assign, nonatomic) NSInteger rightCurrentIndex;

@property (strong, nonatomic) JSDropDownMenu *menu;


@property (nonatomic, strong) NSArray *leftArray;

@property (nonatomic, strong) NSArray *rightArray;

@end

@implementation VPHotelDropView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.leftCurrentIndex = 0;
    self.rightCurrentIndex = 0;
    self.menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 50) andHeight:40];
    self.menu.indicatorColor = [UIColor VPContentColor];
    self.menu.separatorColor = [UIColor VPBackgroundColor];
    self.menu.textColor = [UIColor VPContentColor];
    
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
            return [self.leftArray objectAtIndex:self.leftCurrentIndex];
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
            return [self.leftArray objectAtIndex:indexPath.row];
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
        }break;
        case 1:{

            self.rightCurrentIndex = indexPath.row;
            if ([self.delegate respondsToSelector:@selector(orderByType:)]) {
                [self.delegate orderByType:indexPath.row];
            }
            NSString * locationStr =  [self.rightArray objectAtIndex:indexPath.row];
            NSRange range = [locationStr rangeOfString:@"距离"];
            if(range.location != NSNotFound){
                if(![VPLocationManager sharedManager].isLocation){
                    [MBProgressHUD showTip:@"获取定位信息失败"];
                }
            }
        }
        default:
            break;
    }
}

- (void)startPrice:(double)startPrice endPrice:(double)endPrice{

    if ([self.delegate respondsToSelector:@selector(hotelStartPrice:hotelEndPrice:)]) {
        [self.delegate hotelStartPrice:startPrice hotelEndPrice:endPrice];
    }
}

//需要显示不同的Cell
- (NSString *)tableViewCellIdentifierInColumn:(NSInteger)column indexPath:(NSIndexPath *)indexPath{
    if(column == 0){
        return  @"VPSelectPriceCell";
    }
    return @"DropDownMenuCell";
}

- (void)configLeftData:(NSArray *)leftArray rightData:(NSArray *)rightArray{
    self.leftArray = @[@"价格"];
    self.rightArray = @[@"默认排序",@"价格由低到高",@"距离由近到远"];
    self.menu.dataSource = self;
    self.menu.delegate = self;
    [self.superview addSubview:self.menu];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
