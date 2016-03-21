//
//  HMDropDownMenu.h
//  MyTextField
//
//  Created by chrise on 16/3/21.
//  Copyright © 2016年 chrise. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMDropDownMenu;

@protocol HMDropDownMenuDelegate <NSObject>

@optional
-(void)dropDownMenuDidDismiss:(HMDropDownMenu*)menu;
-(void)dropDownMenuDidShow:(HMDropDownMenu*)menu;

@end



@interface HMDropDownMenu : UIImageView

@property (nonatomic,weak)id<HMDropDownMenuDelegate>delegate;

/** 内容*/
@property(nonatomic,strong)UIView *content;
/**内容控制器*/
@property(nonatomic,strong)UIViewController *contentController;


+(instancetype)menu;

/** 显示*/
-(void)showFrom:(UIView*)from;
/** 销毁*/
-(void)dismiss;


@end
