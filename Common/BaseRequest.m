//
//  BaseRequest.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

+(void)getWithURL:(NSString *)url para:(NSDictionary *)para callBack:(void (^)(NSData *, NSError *))callBack
{
    //处理 url 和 para的拼接
    NSMutableString * urlStr = [[NSMutableString alloc]initWithString:url];
    //拼接资源参数部分
    [urlStr appendString:[self paraToString:para]];
    
    NSURL * URL = [NSURL URLWithString:urlStr];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    [request setTimeoutInterval:20];
    
    //创建session
    NSURLSession * session = [NSURLSession sharedSession];
    //创建task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //请求结束以后的回调block
        callBack(data,error);
        
    }];
    //启动任务
    [task resume];
}

+(void)postWithURL:(NSString *)url para:(NSDictionary *)para callBack:(void (^)(NSData *, NSError *))callBack
{
    //处理 url 和 para的拼接
    NSMutableString * urlStr = [[NSMutableString alloc]initWithString:url];
    //拼接资源参数部分
    [urlStr appendString:[self paraToString:para]];
    
    NSURL * URL = [NSURL URLWithString:urlStr];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    [request setTimeoutInterval:20];
    
    //创建session
    NSURLSession * session = [NSURLSession sharedSession];
    //创建task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //请求结束以后的回调block
        callBack(data,error);
    }];
    //启动任务
    [task resume];
}

//将para拼接成 key1=value1&key2=value2&...的形式
+(NSString *)paraToString:(NSDictionary *)para{
    
    NSMutableString *paraStr = [[NSMutableString alloc]initWithString:@"?"];//资源参数部分以 ？开头
    if(para && para.allKeys.count > 0){
        //字典不为nil 且有键值对才进行拼接
        for(NSString * key in para.allKeys){
            //拼接键值对
            [paraStr appendFormat:@"%@=%@&",key,para[key]];
        }
    }
    //如果有多余的& 要删除
    if([paraStr hasSuffix:@"&"]){
        //删除字符串最后一个字符
        [paraStr deleteCharactersInRange:NSMakeRange(paraStr.length - 1, 1)];
        
    }
    //如果参数中有中文或 "{" 、“}” “#”等特殊字符时，应该进行UNicode编码，否则请求会会得不到数据
    NSString * pStr = [paraStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //解码
//    [pStr stringByRemovingPercentEncoding];
    return pStr;
}


@end
