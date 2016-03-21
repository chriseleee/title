//
//  TextFieldView.m
//  MyTextField
//
//  Created by chrise on 16/3/21.
//  Copyright © 2016年 chrise. All rights reserved.
//

#import "TextFieldView.h"

@interface TextFieldView ()<UITextFieldDelegate>
@property (nonatomic,assign)BOOL saveTraderPassWord;//是否保存交易密码//保存交易密码按钮状态

@property (nonatomic,strong)NSString *TraderPassWordSavePath;
@property (nonatomic,strong)NSMutableDictionary *saveTradePwdDic;//保存交易密码与按钮状态

@property (nonatomic,strong)UIView *superView;
@end

@implementation TextFieldView

-(NSString *)TraderPassWordSavePath{
    if (!_TraderPassWordSavePath) {
        _TraderPassWordSavePath =[QDTool pathforTradeBookUserMessage];
        _TraderPassWordSavePath =[_TraderPassWordSavePath stringByAppendingPathComponent:UDKEY_QDJYBTRADEPASSWORD];
    }
    return _TraderPassWordSavePath;
}

-(NSMutableDictionary *)saveTradePwdDic{
    if (!_saveTradePwdDic) {
        NSMutableDictionary *dic = [QDTool readCacheFromFile:self.TraderPassWordSavePath url:UDKEY_QDJYBTRADEPASSWORD];
        if (dic) {
            _saveTradePwdDic = dic;
        }else{
            _saveTradePwdDic = [[NSMutableDictionary alloc]init];
        }
    }
    return _saveTradePwdDic;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)showTextFieldFrom:(UIView*)from WithType:(ASTextFieldType)type withIconName:(NSString*)iconName titleName:(NSString *)titleName placeHolder:(NSString*)placeHolder returnKeyType:(UIReturnKeyType)returnKeyType
{
    self.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    UILabel *PWDLabel =[QDTool createLabelWithFrame:CGRectMake(5, -2, 60, 40) fontColor:[UIColor blackColor] fontSize:20 textAligment:NSTextAlignmentLeft];
    PWDLabel.text = titleName;
    ASTextField * textPassWord = [[ASTextField alloc]initWithFrame:CGRectMake(60+2*5,0 , self.frame.size.width - 80, 40)];
    textPassWord.placeholder = NSLocalizedString(placeHolder, @"");
    textPassWord.returnKeyType = returnKeyType;
    textPassWord.textColor = [UIColor blackColor];
    self.saveTraderPassWord = [self.saveTradePwdDic[@"saveTraderPassWord"] boolValue];
    
    //获取保存的密码
    if (self.saveTraderPassWord) {
        NSString *passWord = self.saveTradePwdDic[@"TradePassWord"];
        textPassWord.text = passWord;
    }
    
    self.TraderPassWordTextField = textPassWord;
    [self addSubview:PWDLabel];
    [self addSubview:self.TraderPassWordTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    //注册对键盘将要消失 事件的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];

    [self.TraderPassWordTextField setupTextFieldWithType:type delegate:self withIconName:iconName withRadioSelected:self.saveTraderPassWord];
    [from addSubview:self];
    
    self.TraderPassWordTextField.delegate = self;
    self.superView = from;
}

#pragma mark - radioButtonDelegate
//点击了记住按钮
-(void)selectAccount:(BOOL)select{
    self.saveTraderPassWord=select;
    [self.saveTradePwdDic setObject:[NSNumber numberWithBool:self.saveTraderPassWord] forKey:@"saveTraderPassWord"];
    
    [QDTool writeCacheToFile:self.saveTradePwdDic path:self.TraderPassWordSavePath url:UDKEY_QDJYBTRADEPASSWORD];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if( textField.returnKeyType == UIReturnKeyGo){
        [textField resignFirstResponder];
    }
    else if (textField.returnKeyType == UIReturnKeyNext){
        
    }
    return  YES;
}


#pragma mark - 键盘事件
- (void)closeKeyboard:(NSNotification *)notification{
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
     UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        CGRect frame = window.frame;
        frame.origin.y = window.bounds.size.height - frame.size.height;
        
        window.frame = frame;
    } completion:nil];
        [window layoutIfNeeded];
}
- (void)openKeyboard:(NSNotification *)notification{
    NSLog(@"keyboarInfo %@", notification.userInfo);
    //获取键盘弹起后的frame, 转化为CGRect类型
    CGRect keyboarFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘弹起时动画时长
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //获取键盘弹起时的动画选项
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSLog(@"%@",[UIApplication sharedApplication].windows);
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        window.y -= keyboarFrame.size.height;
        
        [window layoutIfNeeded];
    } completion:nil];
    //如果是改变约束，要执行下方代码才好用
        [window layoutIfNeeded];
}



@end
