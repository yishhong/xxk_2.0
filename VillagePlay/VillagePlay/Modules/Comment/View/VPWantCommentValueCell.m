//
//  VPWantCommentValueCell.m
//  VillagePlay
//
//  Created by Apricot on 2016/12/19.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPWantCommentValueCell.h"
#import "XXCellModel.h"
#import "VPPostCommenModel.h"
#import "UITableViewCell+DataSource.h"
@interface VPWantCommentValueCell ()<UITextViewDelegate>
@property (nonatomic, strong) VPPostCommenModel *postCommenModel;
@end

@implementation VPWantCommentValueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeText:) name:UITextViewTextDidChangeNotification object:self.tv_comment];
    self.tv_comment.placeholder = @"请输入您想说的...";
    self.tv_comment.delegate = self;
    self.tv_comment.placeholderColor = [UIColor lightGrayColor];
}

- (void)xx_configCellWithEntity:(id)entity{
    XXCellModel *cellModel = entity;
    self.postCommenModel = cellModel.dataSource;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    self.postCommenModel.content = textView.text;
}

- (void)textViewDidChangeText:(NSNotification *)notification{
    /**
     *  最大输入长度,中英文字符都按一个字符计算
     */
    static int kMaxLength = 500;
    UITextView *textView = (UITextView *)notification.object;
    NSString *toBeString = textView.text;
    // 获取键盘输入模式
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
    // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮选择部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，表明输入结束,则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                // 截取子串
                textView.text = [toBeString substringToIndex:kMaxLength];
            }
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
//            NSLog(@"11111111111111========      %@",position);
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            // 截取子串
            textView.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
