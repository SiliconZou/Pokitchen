//
//  FriendModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/30.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

+(JSONKeyMapper *)keyMapper{
    
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
