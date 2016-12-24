//
//  DishClassModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "DishClassModel.h"

@implementation DishClassModel

+(JSONKeyMapper *)keyMapper{
    
    //将字典中aa_bb 的字段的值对应赋给 模型中 aaBb的字段
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}


@end
