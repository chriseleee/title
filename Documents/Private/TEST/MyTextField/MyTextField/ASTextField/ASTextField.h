//
//  UITextField+ASTextField.h
//  ASTextViewDemo
//
//  Created by Adil Soomro on 4/14/14.
//  Copyright (c) 2014 Adil Soomro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"

typedef enum {
    /**账号非明文，可选保存*/
    ASTextFieldTypeAccount,
    /**密码不保存，可选明文*/
    ASTextFieldTypePassWord,
    /**交易密码非明文，可选保存*/
    ASTextFieldTypeTraderPassWord,
    ASTextFieldTypeCompetitonAccount,
    ASTextFieldTypeCompetitonPassWord,
}ASTextFieldType;


@protocol ASTextFieldDelegate <NSObject>

@optional -(void)selectAccount:(BOOL)select;

@end

@interface ASTextField : UITextField<QRadioButtonDelegate>

@property(nonatomic,weak)id<ASTextFieldDelegate>asDelegate;

@property(nonatomic,strong)QRadioButton *radio1 ;

@end


@interface UITextField ()



- (void)setupTextFieldWithIconName:(NSString *)name;
- (void)setupTextFieldWithType:(ASTextFieldType)type delegate:(id)fromDelegate withIconName:(NSString *)name;
/**TextField设置参数(button的字眼，颜色)*/
- (void)setupTextFieldWithType:(ASTextFieldType)type delegate:(id)fromDelegate withIconName:(NSString *)name withRadioSelected:(BOOL)selected;//添加按钮的状态
/**重置颜色*/
-(void)resetSkinColor;
@end
