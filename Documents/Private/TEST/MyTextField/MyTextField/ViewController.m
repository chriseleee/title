//
//  ViewController.m
//  MyTextField
//
//  Created by chrise on 16/3/18.
//  Copyright © 2016年 chrise. All rights reserved.
//

#import "ViewController.h"
#import "TextFieldView.h"
#import "HMDropDownMenu.h"
#import "HWTitleMenuViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property(nonatomic,strong)TextFieldView *textField;
@end
@implementation ViewController

-(void)viewDidLoad{
    
    self.textField = [[TextFieldView alloc]init];

    [self.textField showTextFieldFrom:self.textView WithType:ASTextFieldTypeAccount withIconName:nil titleName:@"交易密码" placeHolder:@"hahaha" returnKeyType:UIReturnKeyGo];
}
- (IBAction)clickBtn:(id)sender {
    
    
    HMDropDownMenu *menu = [[HMDropDownMenu alloc]init];
    
    // 2.设置内容
    HWTitleMenuViewController *vc = [[HWTitleMenuViewController alloc] init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;
    
    
    [menu showFrom:self.testBtn];
    
}

#pragma mark - 键盘事件

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //取消对键盘的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self.textField name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self.textField name:UIKeyboardWillShowNotification object:nil];
}



@end
