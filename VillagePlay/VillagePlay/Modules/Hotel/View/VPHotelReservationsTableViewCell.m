//
//  VPHotelReservationsTableViewCell.m
//  VillagePlay
//
//  Created by  易述宏 on 16/10/25.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPHotelReservationsTableViewCell.h"
#import "UIColor+HUE.h"
#import "XXCellModel.h"
#import "UITableViewCell+DataSource.h"
#import "VPHotelRoomListRoomModel.h"
#import "UIImageView+VPWebImage.h"
#import "NSMutableAttributedString+AttributedString.h"

@implementation VPHotelReservationsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.roomNameLabel.textColor =[UIColor VPTitleColor];
    self.cancelLabel.textColor =[UIColor navigationTintColor];
    self.priceLabel.textColor =[UIColor VPRedColor];
    self.reservationButton.layer.borderWidth=1.0f;
    self.reservationButton.layer.masksToBounds=YES;
    self.reservationButton.layer.cornerRadius=2.0f;
    self.roomImageView.contentMode=UIViewContentModeScaleAspectFill;
    self.roomImageView.layer.masksToBounds = YES;

}

- (void)xx_configCellWithEntity:(id)entity{

    XXCellModel * cellModel =entity;
    VPHotelRoomListRoomModel *hotelRoomListRoom =cellModel.dataSource;
    [self.roomImageView xx_setImageWithURLStr:hotelRoomListRoom.imgUrl placeholder:[UIImage imageNamed:@"vp_hotel_roomType_Image"]];
    NSMutableAttributedString * attributedString =[[NSMutableAttributedString alloc]init];
    attributedString =[attributedString attributedString:[NSString stringWithFormat:@"￥%ld起",(long)hotelRoomListRoom.price]];
    self.priceLabel.attributedText =attributedString;
    self.roomNameLabel.text =hotelRoomListRoom.name;
    self.roomSizeLabel.text =[NSString stringWithFormat:@"%@m² %@",hotelRoomListRoom.area,hotelRoomListRoom.bed];
    if (hotelRoomListRoom.ruleId==1) {
        self.cancelLabel.text =@"限时取消";
    }else{
        self.cancelLabel.text =@"不可取消";
    }
    if ([hotelRoomListRoom.isReserveRoom isEqualToString:@"Y"]) {
           [self.reservationButton setTitleColor:[UIColor VPRedColor] forState:UIControlStateNormal];
        self.reservationButton.layer.borderColor =[UIColor VPRedColor].CGColor;
        [self.reservationButton setTitleColor:[UIColor VPRedColor] forState:UIControlStateNormal];
        [self.reservationButton setTitle:@"立即预订" forState:UIControlStateNormal];

    }else{
    
        [self.reservationButton setTitleColor:[UIColor VPDetailColor] forState:UIControlStateNormal];
        self.reservationButton.layer.borderColor =[UIColor VPDetailColor].CGColor;
        [self.reservationButton setTitleColor:[UIColor VPDetailColor] forState:UIControlStateNormal];
        [self.reservationButton setTitle:@"不可预订" forState:UIControlStateNormal];
        self.reservationButton.enabled =NO;
    }
}

- (IBAction)reservationAction:(UIButton *)sender {
 
    sender.tag=10;
    [self xx_cellClickAtView:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
