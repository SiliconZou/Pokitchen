//
//  CourseModel+NetWork.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CourseModel.h"

@interface CourseModel (NetWork)

+(void)loadCourseDataWithId:(NSString *)relateId callBack:(void(^)(NSArray *array,NSError *error))callBack;


@end
