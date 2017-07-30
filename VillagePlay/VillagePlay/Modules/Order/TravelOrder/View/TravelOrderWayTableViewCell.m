//
//  TravelOrderWayTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "TravelOrderWayTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPTravelOrdersListModel.h"

@interface TravelOrderWayTableViewCell ()

@property (strong, nonatomic) NSDictionary * cellInfo;

@end

@implementation TravelOrderWayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.placeButton setTitleColor:[UIColor VPContentColor] forState:UIControlStateNormal];
    self.placeButton.layer.cornerRadius =2.0f;
    self.placeButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    self.placeButton.layer.borderWidth =1.0f;
    self.placeButton.layer.cornerRadius =2.0f;
    self.placeButton.hidden =YES;
    
    [self.payButton setTitleColor:[UIColor VPContentColor] forState:UIControlStateNormal];
    self.payButton.layer.cornerRadius =2.0f;
    self.payButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
    self.payButton.layer.borderWidth =1.0f;
    self.payButton.layer.cornerRadius =2.0f;
    self.payButton.hidden =YES;
}

- (void)xx_configCellWithEntity:(id)entity{
    
    XXCellModel * cellModel =entity;
    self.cellInfo=cellModel.dataSource;
     NSDictionary * orderInfo=self.cellInfo[@"orderStateInfo"];
    
    if ([orderInfo[@"placeString"] isEqualToString:@""]) {
        self.placeButton.hidden =YES;
    }else{
        self.placeButton.hidden =NO;
        [self.placeButton setTitle:orderInfo[@"placeString"] forState:UIControlStateNormal];
    }
    self.payButton.hidden =NO;
    [self.payButton setTitle:orderInfo[@"payString"] forState:UIControlStateNormal];

}

- (IBAction)placeAction:(UIButton *)sender {
    
    sender.tag =18;
    [self xx_cellClickAtView:sender];
}
- (IBAction)payAction:(UIButton *)sender {
    
    sender.tag =[self.cellInfo[@"orderStatus"] integerValue];
    [self xx_cellClickAtView:sender];
}

@end
