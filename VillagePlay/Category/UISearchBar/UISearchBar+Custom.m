//
//  UISearchBar+Custom.m
//  VillagePlay
//
//  Created by Apricot on 16/10/24.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "UISearchBar+Custom.h"
#define XX_IOS9 [[UIDevice currentDevice].systemVersion doubleValue] >= 9

@implementation UISearchBar (Custom)

- (void)xxTextFont:(UIFont *)font{
    if (XX_IOS9) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
    }else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:font];
    }
}

- (void)xxTextColor:(UIColor *)textColor{
    if (XX_IOS9) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    }else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:textColor];
    }
}

- (void)xxCancelButtonTitle:(NSString *)title{
    if (XX_IOS9) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    }else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

- (void)xxCancelButtonTitleColor:(UIColor *)textColor{
    UIColor * textFieldColor = self.tintColor;
    self.tintColor = textColor;
    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].tintColor = textFieldColor;

}

- (void)xxCancelButtonFont:(UIFont *)font {
    NSDictionary *textAttr = @{NSFontAttributeName : font};
    if (XX_IOS9) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    }else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    }
}


@end
