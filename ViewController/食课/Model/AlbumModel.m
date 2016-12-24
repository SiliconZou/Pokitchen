//
//  AlbumModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "AlbumModel.h"

@implementation AlbumModel

+(JSONKeyMapper *)keyMapper{
    
    //字典的aa_bb 对应赋值给模型对象的aaBb属性
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
