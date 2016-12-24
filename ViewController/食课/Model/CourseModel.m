//
//  CourseModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CourseModel.h"

@implementation CourseModel

+(JSONKeyMapper *)keyMapper{
    
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
