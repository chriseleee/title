//
//  TextFieldView.h
//  MyTextField
//
//  Created by chrise on 16/3/21.
//  Copyright © 2016年 chrise. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASTextField;
@interface TextFieldView : UIView
@property (nonatomic,strong)ASTextField *TraderPassWordTextField;//输入交易密码的输入框

-(void)showTextFieldFrom:(UIView*)from WithType:(ASTextFieldType)type withIconName:(NSString*)iconName titleName:(NSString *)titleName placeHolder:(NSString*)placeHolder returnKeyType:(UIReturnKeyType)returnKeyType;
@end
