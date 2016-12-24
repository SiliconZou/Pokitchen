//
//  UserModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static UserModel * user = nil;
+(instancetype)shareUser{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!user){
            user
            = [[self alloc]init];
            user.isLogin = NO;
        }
    });
    return user;
    
}

@end
