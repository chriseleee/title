//
//  UITool.h
//  MyTextField
//
//  Created by chrise on 16/3/16.
//  Copyright © 2016年 chrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define UDKEY_QDJYBTRADEPASSWORD @"UDKEY_QDJYBTRADEPASSWORD"

@interface NSString(QD)

- (NSString*) hashString;


@end


@interface QDTool : NSObject

+(NSString*)pathforTradeBookUserMessage;


+(NSMutableDictionary*)readCacheFromFile:(NSString*)path url:(NSString*)url;



+(UILabel*)createLabelWithFrame:(CGRect)rect fontColor:(UIColor*)fontColor fontSize:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment;


+(void)writeCacheToFile:(NSMutableDictionary*)dic path:(NSString*)path url:(NSString*)url;
/** 16进制颜色转换为UIColor*/
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
