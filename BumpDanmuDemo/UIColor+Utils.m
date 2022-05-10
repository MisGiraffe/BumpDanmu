//
//  UIColor+Utils.m
//  DanmuDemo
//
//  Created by fangtingting on 2022/4/20.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    NSString *cString = [[inColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    if ( ([cString length] != 6) && ([cString length] != 8) ) return [UIColor blackColor];
    // Separate into a, r, g, b substrings
    NSRange range;
    NSUInteger location = 0, length = 2;
    range.location = location;
    range.length = length;
    
    BOOL isARGB = ([cString length] == 8); // 判断是否是带透明度的ARGB形式
    NSString *aString;
    if (isARGB) {
        aString = [cString substringWithRange:range];
        location += length;
        range.location = location;
    }
    
    NSString *rString = [cString substringWithRange:range];
    location += length;
    range.location = location;
    
    NSString *gString = [cString substringWithRange:range];
    location += length;
    range.location = location;
    
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int a, r, g, b;
    CGFloat alpha = 1.0;
    if (isARGB) {
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        alpha = a / 255.0f;
    }
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

@end
