//
//  BaseRequest.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject
//请求：1.IP地址 url  2.资源路径、资源参数（para）3.回调（返回数据）
//GET请求方法
+(void)getWithURL:(NSString *)url para:(NSDictionary *)para callBack:(void(^)(NSData *data,NSError *error))callBack;
//post请求方式
+(void)postWithURL:(NSString *)url para:(NSDictionary *)para callBack:(void(^)(NSData *data,NSError *error))callBack;


@end
