//
//  FriendModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/30.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"

@interface FriendModel : JSONModel

@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * createTimeCn;
@property (nonatomic, copy) NSString * headImg;
@property (nonatomic, copy) NSString * nick;
@property (nonatomic, assign) BOOL istalent;
@property (nonatomic, copy) NSString * userId;

@end
