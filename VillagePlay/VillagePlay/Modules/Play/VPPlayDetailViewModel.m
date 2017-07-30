//
//  VPPlayDetailViewModel.m
//  VillagePlay
//
//  Created by  易述宏 on 16/11/5.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPPlayDetailViewModel.h"
#import "VPPlayAPI.h"
#import "YYModel.h"
#import "VPPlayListModel.h"

@interface VPPlayDetailViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) VPPlayAPI * playAPI;

@property (strong, nonatomic) NSMutableArray *dayArray;

@property (strong, nonatomic) VPPlayListModel * playListModel;


@end

@implementation VPPlayDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.dayArray = [NSMutableArray array];
        self.playAPI =[[VPPlayAPI alloc]init];
    }
    return self;
}

- (BOOL)isShowButton{
    return [self.dayArray count]>1?YES:NO;
}
- (NSString *)topImageURL{
    if([self.playListModel.imgs count]>0){
        return [self.playListModel.imgs objectAtIndex:0];
    }else{
        return @"";
    }
}
- (void)playDetailPlayID:(NSInteger)playID success:(void (^)())success failure:(void (^)(NSError *))failure{

    NSDictionary *params =@{@"id":@(playID)};
    [self.playAPI playDetailParams:params success:^(NSDictionary *responseDict) {
        
        self.playListModel = [VPPlayListModel yy_modelWithJSON:responseDict[@"body"]];
        
        [self.dataSource removeAllObjects];
        //布局
        //游玩详情推荐地址
        XXCellModel * recommentCellModel = [XXCellModel instantiationWithIdentifier:@"RecommentPlayTableViewCell" height:76 dataSource:self.playListModel action:nil];
        //空行
        XXCellModel * blankLineCellModel = [XXCellModel instantiationWithIdentifier:@"VPBlankLinesTableViewCell" height:10 dataSource:nil action:nil];
        [self.dataSource addObject:@[recommentCellModel,blankLineCellModel]];
//后续看看以下代码需要如何优化
        
        //首先截取出标题栏
        NSMutableDictionary * playDict = [NSMutableDictionary dictionary];
        for (VPPlayDetailModel *playDetailModel in self.playListModel.items) {
            NSMutableArray * dayArray = playDict[@(playDetailModel.currentDay)];
            if(!dayArray||[dayArray count]<1){
                dayArray = [NSMutableArray array];
                [self.dayArray addObject:dayArray];
                NSMutableDictionary *dayDict = [NSMutableDictionary dictionary];
                dayDict[@"type"] = @"day";
                dayDict[@"value"] = playDetailModel;

                dayDict[@"title"] = [NSString stringWithFormat:@"DAY %ld",playDetailModel.currentDay];
                [dayArray addObject:dayDict];
                playDict[@(playDetailModel.currentDay)] = dayArray;
            }
            
            NSMutableDictionary *detailDict = [NSMutableDictionary dictionary];
            detailDict[@"type"] = @"sort";
            detailDict[@"title"] = playDetailModel.title;
            detailDict[@"introduce"] = playDetailModel.introduce;
            detailDict[@"value"] = playDetailModel;
            [dayArray addObject:detailDict];
        }
        //通过标题栏的形式分配内容
        for (NSArray *dayArray in self.dayArray) {
            NSMutableArray *cellDayArray = [NSMutableArray array];
            for (NSDictionary*dict in dayArray) {
//                VPPlayDetailModel* playDetailModel = dict[@"value"];

                if([dict[@"type"] isEqualToString:@"day"]){
                    //取天数
                    XXCellModel *cellModel = [XXCellModel instantiationWithIdentifier:@"VPPlayDayCell" height:85 dataSource:dict action:nil];
                    [cellDayArray addObject:cellModel];
                }else if([dict[@"type"] isEqualToString:@"sort"]){
                    //取攻略
                    XXCellModel *titleCellModel = [XXCellModel instantiationWithIdentifier:@"VPPlayTitleCell" height:44 dataSource:dict action:nil];
                    [cellDayArray addObject:titleCellModel];
                    XXCellModel *introduceCellModel = [XXCellModel instantiationWithIdentifier:@"VPPlayIntroduceCell" height:100 dataSource:dict action:nil];
                    [cellDayArray addObject:introduceCellModel];
                }
            }
            XXCellModel *cellModel = [cellDayArray lastObject];
            cellModel.location = CellLocationEnd;
            
            [self.dataSource addObject:cellDayArray];
            if([self.dataSource count]>1){
                XXCellModel *spaceCellModel = [XXCellModel instantiationWithIdentifier:@"VPSpaceCell" height:25 dataSource:nil action:nil];
                [cellDayArray addObject:spaceCellModel];
            }
        }
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (NSInteger) numberOfSections{
    return [self.dataSource count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}


-(XXCellModel *)cellForRow:(NSInteger)row inSection:(NSInteger)section{
    return self.dataSource[section][row];
}

- (NSArray *)leftArray{
    return self.dayArray;
}



//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

//去掉 HTML 字符串中的标签
- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}


@end
