//
//  VPQuantityView.m
//  VillagePlay
//
//  Created by  易述宏 on 15/9/24.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "VPQuantityView.h"
#import "UIColor+HUE.h"

@interface VPQuantityView ()<UITextFieldDelegate>

@end

@implementation VPQuantityView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];

    }
    return self;
}

-(void)setUp{
    
    self.subtractButton.layer.cornerRadius=2.0f;
    self.subtractButton.layer.borderColor =[UIColor VPBackgroundColor].CGColor;
    self.subtractButton.layer.borderWidth =1.0f;
    self.addButton.layer.cornerRadius=2.0f;
    self.addButton.layer.borderColor =[UIColor VPBackgroundColor].CGColor;
    self.addButton.layer.borderWidth =1.0f;
    self.amountTextField.layer.borderColor =[UIColor VPBackgroundColor].CGColor;
    self.amountTextField.layer.borderWidth =1.0f;
    self.amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.amountTextField.clearsOnBeginEditing = YES;
    self.currentAmount = 0;
    self.amountTextField.text = [NSString stringWithFormat:@"%@", @(_currentAmount)];
    
    [self.amountTextField addTarget:self action:@selector(amountTextFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    self.amountTextField.delegate = self;
}
/*
  * minString @“-”最小值
  * defaultTextString 文本框默认值
  * maxString @“+”最大值
 */

- (IBAction)didSubtractTappend:(id)sender {

    if (_currentAmount == 0) {
        [self showAlertView:@"亲，不能再减了"];
        return;
    }
    self.currentAmount--;
    if(self.currentAmount<1){
            self.subtractButton.layer.borderWidth =1.0f;
            [self.subtractButton setImage:[UIImage imageNamed:@"tab_tour_reduce"] forState:UIControlStateNormal];
            self.amountTextField.text =[NSString stringWithFormat:@"%@",@(_currentAmount)];
            self.currentAmount=0;
    }
    
}

- (IBAction)didAddTappend:(id)sender {

    self.currentAmount++;
    if (self.purchaseNum>0) {
        
        if (self.currentAmount>self.purchaseNum) {
            
            NSString * stringNumber =[NSString stringWithFormat:@"每人限购%ld张",(long)self.purchaseNum];
            [self showAlertView:stringNumber];
            self.amountTextField.text = [NSString stringWithFormat:@"%@", @(self.purchaseNum)];
            self.currentAmount=self.purchaseNum;
            
        }else if(self.buyNum>=self.purchaseNum){
            
            NSString * stringNumber =[NSString stringWithFormat:@"每人限购%ld张",(long)self.purchaseNum];
            [self showAlertView:stringNumber];
            self.currentAmount =0;
            self.amountTextField.text =@"0";
        
        }else{
        
            self.amountTextField.text = [NSString stringWithFormat:@"%@", @(self.currentAmount)];
        }
        
    }else{
        
        if (self.currentAmount>=1) {
            [self.subtractButton setImage:[UIImage imageNamed:@"tab_tour_reduce_blue"] forState:UIControlStateNormal];
            self.subtractButton.layer.borderWidth =1.0f;
        }
    }
}

- (void)amountTextFieldTextChanged:(UITextField*)textField
{
    if (self.purchaseNum>0) {

        if ([textField.text integerValue]>self.purchaseNum) {
            
            NSString * stringNumber =[NSString stringWithFormat:@"每人限购%ld张",(long)self.purchaseNum];
            [self showAlertView:stringNumber];
            self.currentAmount=self.purchaseNum;
            
        }else if(self.buyNum>=self.purchaseNum){
            
            NSString * stringNumber =[NSString stringWithFormat:@"每人限购%ld张",(long)self.purchaseNum];
            [self showAlertView:stringNumber];
            self.currentAmount=0;
            self.amountTextField.text =@"0";
            
        }else{
            
            self.currentAmount=[textField.text integerValue];
        }
        
    }else{
        
        self.currentAmount = [textField.text integerValue];
        
    }
    if (self.currentAmount>=1) {
        [self.subtractButton setImage:[UIImage imageNamed:@"tab_tour_reduce_blue"] forState:UIControlStateNormal];
        self.subtractButton.layer.borderWidth =1.0f;
    }else{
    
        self.subtractButton.layer.borderWidth =1.0f;
        [self.subtractButton setImage:[UIImage imageNamed:@"tab_tour_reduce"] forState:UIControlStateNormal];
    }
}

- (void)setCurrentAmount:(NSInteger)currentAmount
{
    _currentAmount = currentAmount;
    self.amountTextField.text =[NSString stringWithFormat:@"%@", @(_currentAmount)];
}

-(void)setPurchaseNum:(NSInteger)purchaseNum{

    _purchaseNum =purchaseNum;
}

-(void)setBuyNum:(NSInteger)buyNum{

    _buyNum =buyNum;
}

-(void)showAlertView:(NSString *)message{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message  delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
    [alert show];
}

#pragma mark -- UITextViewDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    // allow backspace
    if (!string.length)
    {
        return YES;
    }
    
    // Prevent invalid character input, if keyboard is numberpad
    if (textField.keyboardType == UIKeyboardTypeNumberPad)
    {
        if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
        {
            // BasicAlert(@"", @"This field accepts only numeric entries.");
            return NO;
        }
    }
    

    return YES;
}
@end
