//
//  NSString+MD5.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/8/26.
//  Copyright © 2016年 Silicon.Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <objc/runtime.h>
@interface NSString (MD5)

-(NSString *)MD5String;

@end
