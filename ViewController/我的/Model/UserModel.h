//
//  UserModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel

@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, assign) BOOL isLogin;
//单例方法
+(instancetype)shareUser;

@end
