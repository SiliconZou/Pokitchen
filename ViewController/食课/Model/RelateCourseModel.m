//
//  RelateCourseModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/30.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "RelateCourseModel.h"

@implementation RelateCourseModel

+(JSONKeyMapper *)keyMapper{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end

@implementation RelationModel

+(JSONKeyMapper *)keyMapper{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
