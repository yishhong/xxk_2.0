//
//  VPVillageDropView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/12.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPVillageDropView.h"
#import "JSDropDownMenu.h"
#import "UIColor+HUE.h"
#import "VPTagsModel.h"
#import "VPLocationManager.h"
#import "MBProgressHUD+Loading.h"

@interface VPVillageDropView ()<JSDropDownMenuDelegate,JSDropDownMenuDataSource>

@property (assign, nonatomic) NSInteger leftCurrentIndex;
@property (assign, nonatomic) NSInteger oldLeftCurrentIndex;
@property (assign, nonatomic) NSInteger leftSubCurrentIndex;

@property (assign, nonatomic) NSInteger rightCurrentIndex;

@property (strong, nonatomic) JSDropDownMenu *menu;


@property (nonatomic, strong) NSArray *leftArray;

@property (nonatomic, strong) NSArray *rightArray;

@end

@implementation VPVillageDropView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.leftCurrentIndex = 0;
    self.oldLeftCurrentIndex = self.leftCurrentIndex;
    self.leftSubCurrentIndex = 0;
    self.rightCurrentIndex = 0;
    self.menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
    self.menu.indicatorColor = [UIColor VPContentColor];
    self.menu.separatorColor = [UIColor VPBackgroundColor];
    self.menu.textColor = [UIColor VPContentColor];
    
}


- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 2;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    if(column == 0){
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    if (column==0) {
        return 0.3;
    }
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
            if(leftOrRight == 0){
                return [self.leftArray count];
            }else{
                VPTagsModel *tags =[self.leftArray objectAtIndex:leftRow];
                return tags.tags.count;
//                NSDictionary *menuDic = [self.leftArray objectAtIndex:leftRow];
//                return [menuDic[@"date"] count];
            }
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
//            NSDictionary *menuDic = [self.leftArray objectAtIndex:self.leftCurrentIndex];
//            return menuDic[@"date"][self.leftSubCurrentIndex];
            VPTagsModel *tags =[self.leftArray objectAtIndex:self.leftCurrentIndex];
            if([tags.tags count]>self.leftSubCurrentIndex){
                VPTagModel * tag = tags.tags[self.leftSubCurrentIndex];
                return tag.tagName;
            }
            return @"";
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
            if(indexPath.leftOrRight == 0){
//                NSDictionary *menuDic = [self.leftArray objectAtIndex:indexPath.row];
//                return menuDic[@"title"];
                VPTagsModel *tags =[self.leftArray objectAtIndex:indexPath.row];
                return tags.name;
                
            }else{
                NSInteger leftRow = indexPath.leftRow;
                VPTagsModel *tags =[self.leftArray objectAtIndex:leftRow];
                VPTagModel * tag =[tags.tags objectAtIndex:indexPath.row];
                return tag.tagName;

//                NSDictionary *menuDic = [self.leftArray objectAtIndex:leftRow];
//                return [[menuDic objectForKey:@"date"] objectAtIndex:indexPath.row];
            }
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
            if(indexPath.leftOrRight ==0){
                self.leftCurrentIndex = indexPath.row;
            }else{
//                self.leftCurrentIndex = indexPath.row;
                self.leftSubCurrentIndex = indexPath.row;
                NSInteger leftRow = indexPath.leftRow;
                VPTagsModel *tags =[self.leftArray objectAtIndex:leftRow];
                VPTagModel * tag =tags.tags[indexPath.row];
                if ([self.delegate respondsToSelector:@selector(villageTagName:)]) {
                    [self.delegate villageTagName:tag.tagId];
                }
            }
        }break;
        case 1:{
            self.rightCurrentIndex = indexPath.row;
            if ([self.delegate respondsToSelector:@selector(sortType:)]) {
                [self.delegate sortType:self.rightCurrentIndex];
            }
            //判断是否开启定位
            NSString * locationStr =  [self.rightArray objectAtIndex:indexPath.row];
            NSRange range = [locationStr rangeOfString:@"距离"];
            if(range.location != NSNotFound){
                if(![VPLocationManager sharedManager].isLocation){
                    [MBProgressHUD showTip:@"获取定位信息失败"];
                    return;
                }
            }
        }
        default:
            break;
    }
}



- (void)configLeftData:(NSArray *)leftArray rightData:(NSArray *)rightArray{
//    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐"];
//    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    
    
//    self.leftArray = @[@{@"title":@"美食", @"data":food}, @{@"title":@"旅游", @"data":travel}];
    self.leftArray = leftArray;
    self.rightArray = @[@"默认排序", @"热门优先", @"距离优先"];
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
