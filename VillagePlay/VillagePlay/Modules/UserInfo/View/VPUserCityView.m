//
//  VPUserCityView.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/13.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPUserCityView.h"
#import "CNPPopupController.h"
#import "UIColor+HUE.h"

@interface VPUserCityView ()<UIPickerViewDataSource,UIPickerViewDelegate,CNPPopupControllerDelegate>
@property (nonatomic, strong) NSArray *dataSource;
//@property (nonatomic, strong) NSString * selectSex;
@property (nonatomic, copy) SelectCityBlock selectCityBlock;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, assign) NSInteger selectProvinceIndex;
@property (nonatomic, assign) NSInteger selectCityIndex;


@end

@implementation VPUserCityView

+ (instancetype)instantiation{
    VPUserCityView *view = [[VPUserCityView alloc] init];
    view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 280);
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectProvinceIndex = 0;
        self.selectCityIndex = 0;
        NSString * path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        self.dataSource = [NSArray arrayWithContentsOfFile:path];
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self addSubview:self.pickerView];
    }
    return self;
}

- (void)showViewWithNowSelectCity:(NSString *)nowSelectSex Block:(SelectCityBlock)selectCityBlock{
    if(selectCityBlock){
        if(self.selectCityBlock){
            self.selectCityBlock = nil;
        }
        self.selectCityBlock = selectCityBlock;
    }
    
    if(nowSelectSex.length>1){
        for (int i =0; i<[self.dataSource count]; i++) {
            NSDictionary *cityDict = self.dataSource[i];
            NSString * provinceString = cityDict[@"state"];
            if([nowSelectSex hasPrefix:provinceString]){
                self.selectProvinceIndex = i;
                for (int j =0; j<[cityDict[@"cities"] count]; j++) {
                    NSString * cityString = cityDict[@"cities"][j];
                    if([nowSelectSex hasSuffix:cityString]){
                        self.selectCityIndex = j;
                        break;
                    }
                }
                break;
            }
        }
    }
    [self.pickerView selectRow:self.selectProvinceIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:self.selectCityIndex inComponent:1 animated:YES];
    
    self.lb_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    [self addSubview:self.lb_title];
    self.lb_title.font = [UIFont systemFontOfSize:16];
    //    lb_title.backgroundColor = [UIColor navigationTintColor];
    //    lb_title.textColor = [UIColor whiteColor];
    self.lb_title.text = @"所在地";
    self.lb_title.textAlignment = NSTextAlignmentCenter;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lb_title.frame)-0.5, CGRectGetWidth(self.lb_title.frame), 0.5)];
    lineView.backgroundColor = [UIColor septalLineColor];
    [self addSubview:lineView];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.backgroundColor = [UIColor navigationTintColor];
    confirmButton.layer.cornerRadius = 3;
    [confirmButton addTarget:self action:@selector(tapSelectCity) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.frame = CGRectMake(CGRectGetWidth(self.frame)-54, 3, 50, CGRectGetHeight(self.lb_title.frame)-6);
    [self addSubview:confirmButton];
    
    self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.lb_title.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.lb_title.frame));
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[self]];
    CNPPopupTheme *theme = [CNPPopupTheme defaultTheme];
    theme.popupContentInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    theme.shouldDismissOnBackgroundTouch = NO;
    self.popupController.theme = theme;
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.delegate = self;
    
    [self.popupController presentPopupControllerAnimated:YES];
}

- (void)popupControllerDidDismiss:(nonnull CNPPopupController *)controller{
    [self removeFromSuperview];
}

- (void)tapSelectCity{
    NSDictionary *cityDict = [self.dataSource objectAtIndex:self.selectProvinceIndex];
    self.selectCityBlock(cityDict[@"state"],cityDict[@"cities"][self.selectCityIndex]);
    [self.popupController dismissPopupControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component==0){
        return [self.dataSource count];
    }else{
        return [[self.dataSource objectAtIndex:self.selectProvinceIndex][@"cities"] count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component ==0){
        NSDictionary *dict = [self.dataSource objectAtIndex:row];
        return dict[@"state"];
    }else{
        NSDictionary *dict = [self.dataSource objectAtIndex:self.selectProvinceIndex];
        return dict[@"cities"][row];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component==0){
        if(self.selectProvinceIndex ==row){
            return;
        }
        self.selectProvinceIndex = row;
        self.selectCityIndex = 0;
        [pickerView reloadComponent:component+1];
        [pickerView selectRow:self.selectCityIndex inComponent:component+1 animated:YES];
    }else{
        self.selectCityIndex = row;
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
