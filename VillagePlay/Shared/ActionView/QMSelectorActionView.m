//
//  QMSelectorActionView.m
//  Calendar
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QMSelectorActionView.h"
#import "UIView+Mold.h"
#import "QMEventWithActionView.h"


@interface QMSelectorActionView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) QMEventWithActionView *eventView;

@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSDictionary *details;
/**
 *  选中的坐标
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation QMSelectorActionView

- (instancetype)initWithDetails:(NSDictionary *)details
{
    self = [super init];
    if (self) {
        self.dataSource = [NSArray array];
        self.details = details;
        self.dataSource = self.details[@"dataSource"];
        self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return self;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFontSize;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
    }
    return _pickerView;
}

- (QMEventWithActionView *)eventView{
    if(!_eventView){
        _eventView = [[QMEventWithActionView alloc] init];
        [_eventView buttonTitleWith:self.details];
        [self addSubview:_eventView];
    }
    return _eventView;
}

- (void)setViews{
    self.titleLabel.text = self.details[@"title"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    CGFloat height = CGRectGetHeight(self.frame) - 162;
    self.titleLabel.frame = CGRectMake(10, 5, CGRectGetWidth(self.frame)-20, height*0.4);
    
    
//    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

    self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.frame), 162);
    self.eventView.frame = CGRectMake(0, CGRectGetMaxY(self.pickerView.frame), CGRectGetWidth(self.frame), height * 0.6);
    [self.eventView setViews];
}

#pragma mark - Delegate && DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [self.dataSource count];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.dataSource[component] count];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSString *title = @"";
    if(self.details[@"key"]){
        title = [self.dataSource[component][row] valueForKey:self.details[@"key"]];
    }else{
        title = self.dataSource[component][row];
    }
    UILabel *titleLabel = view ? (UILabel *) view : [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [titleLabel setFont:KFontSize];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text  = title;
    return titleLabel;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.indexPath = [NSIndexPath indexPathForRow:row inSection:component];
}

#pragma mark - 按钮事件
- (void)cancel{
    if([self.superview respondsToSelector:@selector(cancel)]){
        [self.superview cancel];
    }
}

- (void)confirm:(id)object{
    if([self.superview respondsToSelector:@selector(confirm:)]){
        [self.superview confirm:self.dataSource[self.indexPath.section][self.indexPath.row]];
    }
}

@end
