//
//  CourseModel+NetWork.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CourseModel+NetWork.h"

@implementation CourseModel (NetWork)

+(void)loadCourseDataWithId:(NSString *)relateId callBack:(void (^)(NSArray *, NSError *))callBack{
    
    //methodName=CourseSeriesView&series_id=60&token=9B6EF4052641DB78766773995185F896&user_id=947432&version=4
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:@{@"methodName":@"CourseSeriesView",@"series_id":relateId,@"version":@"4.4"}];
    UserModel *user = [UserModel shareUser];
    if(user.isLogin){
        [para setObject:user.userId forKey:@"user_id"];
        [para setObject:user.token forKey:@"token"];
    }
    
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        if(!error){
            //解析根目录字典
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = dict[@"data"][@"data"];
            
            NSMutableArray *models = [CourseModel arrayOfModelsFromDictionaries:array error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                callBack(models,nil);
            });
            
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                callBack(nil, error);
            });
        }
        
        
    }];
    
    
}


@end
