//
//  NSString+MD5.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/8/26.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

-(NSString *)MD5String
{
    const char * Cstr = [self UTF8String];
    unsigned char buff[16];
    CC_MD5(Cstr, (CC_LONG)strlen(Cstr), buff);
    NSMutableString *strrr = [NSMutableString string];
    for (int i = 0; i < 16; i ++) {
        [strrr appendFormat:@"%02x",buff[i]];
    }
    return strrr;
}
@end
