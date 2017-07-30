//
//  VPHGNumberView.m
//  VillagePlay
//
//  Created by  易述宏 on 2017/1/13.
//  Copyright © 2017年 Apricot. All rights reserved.
//

#import "VPHGNumberView.h"
#import "UIColor+HUE.h"

@implementation VPHGNumberView

-(void)awakeFromNib{

    [super awakeFromNib];
}

-(void)setUp{
    
    self.subtractButton.layer.cornerRadius=2.0f;
    self.subtractButton.layer.borderColor =[UIColor VPBackgroundColor].CGColor;
    self.subtractButton.layer.borderWidth =1.0f;
    self.addButton.layer.cornerRadius=2.0f;
    self.addButton.layer.borderColor =[UIColor VPBackgroundColor].CGColor;
    self.addButton.layer.borderWidth =1.0f;
    self.numberTextField.layer.borderColor =[UIColor VPBackgroundColor].CGColor;
    self.numberTextField.layer.borderWidth =1.0f;
    self.numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.numberTextField.clearsOnBeginEditing = YES;
    self.currentAmount = 0;
    self.numberTextField.text = [NSString stringWithFormat:@"%@", @(_currentAmount)];
    
    [self.numberTextField addTarget:self action:@selector(amountTextFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    self.numberTextField.delegate = self;
}


- (IBAction)subtractAction:(id)sender {
 
    if (_currentAmount == 0) {
        [self showAlertView:@"亲，不能再减了"];
        return;
    }
    self.currentAmount--;
    if(self.currentAmount<1){
        self.subtractButton.layer.borderWidth =1.0f;
        [self.subtractButton setImage:[UIImage imageNamed:@"tab_tour_reduce"] forState:UIControlStateNormal];
        self.numberTextField.text =[NSString stringWithFormat:@"%@",@(_currentAmount)];
        self.currentAmount=0;
    }
    if ([self.delegate respondsToSelector:@selector(VPCurrentAmount:)]) {
        [self.delegate VPCurrentAmount:self.currentAmount];
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
            self.numberTextField.text =@"0";
            
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
    if ([self.delegate respondsToSelector:@selector(VPCurrentAmount:)]) {
        [self.delegate VPCurrentAmount:self.currentAmount];
    }
}

- (IBAction)addAction:(id)sender {
    
    self.currentAmount++;
    if (self.purchaseNum>0) {
        
        if (self.currentAmount>self.purchaseNum) {
            
            NSString * stringNumber =[NSString stringWithFormat:@"每人限购%ld张",(long)self.purchaseNum];
            [self showAlertView:stringNumber];
            self.numberTextField.text = [NSString stringWithFormat:@"%@", @(self.purchaseNum)];
            self.currentAmount=self.purchaseNum;
            
        }else if(self.buyNum>=self.purchaseNum){
            
            NSString * stringNumber =[NSString stringWithFormat:@"每人限购%ld张",(long)self.purchaseNum];
            [self showAlertView:stringNumber];
            self.currentAmount =0;
            self.numberTextField.text =@"0";
            
        }else{
            
            self.numberTextField.text = [NSString stringWithFormat:@"%@", @(self.currentAmount)];
        }
        
    }else{
        
        if (self.currentAmount>=1) {
            [self.subtractButton setImage:[UIImage imageNamed:@"tab_tour_reduce_blue"] forState:UIControlStateNormal];
            self.subtractButton.layer.borderWidth =1.0f;
        }
    }
    if ([self.delegate respondsToSelector:@selector(VPCurrentAmount:)]) {
        [self.delegate VPCurrentAmount:self.currentAmount];
    }
}

- (void)setCurrentAmount:(NSInteger)currentAmount
{
    _currentAmount = currentAmount;
    self.numberTextField.text =[NSString stringWithFormat:@"%@", @(_currentAmount)];
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


@end
