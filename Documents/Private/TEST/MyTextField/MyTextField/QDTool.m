//
//  UITool.m
//  MyTextField
//
//  Created by chrise on 16/3/16.
//  Copyright © 2016年 chrise. All rights reserved.
//

#import "QDTool.h"


@implementation NSString(QD)


-(NSString*) hashString{
    return [NSString stringWithFormat:@"%lu", [self hash]];
}


@end

@implementation QDTool


+(UILabel*)createLabelWithFrame:(CGRect)rect fontColor:(UIColor*)fontColor fontSize:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment
{
    UILabel *label=[[UILabel alloc] initWithFrame:rect];
    label.font=[UIFont systemFontOfSize:fontSize];
    label.textColor=fontColor;
    label.backgroundColor=[UIColor clearColor];
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment= textAligment;
    
    
    return label;
}
+(NSMutableDictionary*)readCacheFromFile:(NSString*)path url:(NSString*)url
{
    NSData *data=[[NSMutableData alloc]initWithContentsOfFile:path];
    NSKeyedUnarchiver *unArchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSMutableDictionary* dic=[unArchiver decodeObjectForKey:[url hashString]];
    [unArchiver finishDecoding];
    
    //    NSData *Data=[NSData dataWithContentsOfFile:path];
    //    NSError *error=nil;
    //    NSMutableDictionary *dic=(NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:Data options:NSJSONReadingAllowFragments error:&error];
    return dic;
}


+(NSString*)pathforTradeBookUserMessage
{
    NSString *path=[self pathInDocumentDirectory:[NSString stringWithFormat:@"documents/TradeBookUserMessage"]];
    if(![[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)pathInDocumentDirectory:(NSString*) fileName{
    //获取沙盒中的文档目录
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:fileName];
}

+(void)writeCacheToFile:(NSMutableDictionary*)dic path:(NSString*)path url:(NSString*)url
{
    [dic setObject:[NSDate date] forKey:@"QDdate"];
    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:dic forKey:[url hashString]];
    NSLog(@"hasString = %@", [url hashString]);
    [archiver finishEncoding];
    [data writeToFile:path atomically:YES];
    
    //    NSString *dateString=[QDTool stringFromDate:[NSDate date]];
    //    [dic setObject:dateString forKey:@"QDdate"];
    //    NSError *error=nil;
    //    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    //
    //    [jsonData writeToFile:path atomically:YES];
    
}

+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end
