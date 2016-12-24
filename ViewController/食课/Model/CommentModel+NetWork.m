//
//  CommentModel+NetWork.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CommentModel+NetWork.h"

@implementation FriendModel (NetWork)

+(void)loadFriendWithCourseId:(NSString *)courseId callBack:(void (^)(NSArray *, NSError *))callBack{
    
    //media_type=3&methodName=DianzanList&page=1&post_id=663&size=7&token=9B6EF4052641DB78766773995185F896&user_id=947432&version=4.4
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:@{@"media_type":@3,@"methodName":@"DianzanList",@"page":@1,@"post_id":courseId,@"size":@99999,@"version":@"4.4"}];
    UserModel *user = [UserModel shareUser];
    if(user.isLogin){
        [para setObject:user.userId forKey:@"user_id"];
        [para setObject:user.token forKey:@"token"];
    }
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        if(!error){
            //成功解析
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = dict[@"data"][@"data"];
            //将数组中的字典转化为FriendModel的对象
            NSMutableArray *models = [FriendModel arrayOfModelsFromDictionaries:array error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(models,nil)
                ;
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(nil, error);
            });
        }
        
    }];
    
}

@end


//获取相关课程的网络请求处理
@implementation RelateCourseModel (NetWork)

+(void)loadRelateCourseDataWithCourseId:(NSString *)courseId callBack:(void (^)(NSArray *, NSError *))callBack{
    
    //course_id=851&methodName=CourseRelate&page=1&size=10&token=&user_id=&version=4.4
    NSMutableDictionary*para = [NSMutableDictionary dictionaryWithDictionary:@{@"course_id":courseId,@"methodName":@"CourseRelate",@"page":@"1",@"version":@"4.4",@"size":@99999}];
    UserModel *user = [UserModel shareUser];
    if(user.isLogin){
        [para setObject:user.userId forKey:@"user_id"];
        [para setObject:user.token forKey:@"token"];
    }
    
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        
        if(!error){
            //解析根目录字典
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * array = dict[@"data"][@"data"];
            
            NSMutableArray *models = [RelateCourseModel arrayOfModelsFromDictionaries:array error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                callBack(models, nil);
            });
            
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(nil, error);
            });
        }
        
    }];
    
}

@end





@implementation CommentModel (NetWork)

+(void)loadCommentsWithRelateId:(NSString *)relateId callBack:(void(^)(NSArray *array,NSError *errror))callBack
{
    //methodName=CommentList&page=1&relate_id=60&size=10&token=9B6EF4052641DB78766773995185F896&type=2&user_id=947432&version=4.4
    UserModel *user = [UserModel shareUser];
     NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:@{@"methodName":@"CommentList",@"page":@1,@"relate_id":relateId,@"size":@99999,@"version":@"4.4",@"type":@2}];
    if(user.isLogin){
        [para setObject:user.userId forKey:@"user_id"];
        [para setObject:user.token forKey:@"token"];
    }
   
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        
        if(!error){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * array = dict[@"data"][@"data"];
            NSMutableArray *models = [CommentModel arrayOfModelsFromDictionaries:array error:nil];

            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(models, nil);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(nil,error);
            });
        }
       
    }];
}
#pragma  mark - ViewModel显示逻辑处理

-(NSAttributedString *)attibuteString{
    
    NSMutableString * content = [[NSMutableString alloc]init];
    NSMutableAttributedString * attStr = nil;
    if(self.parents && self.parents.count){
        
        CommentModel *pm = self.parents.firstObject;
        [content appendFormat:@"回复 %@ : %@",pm.nick,self.content];
        attStr = [[NSMutableAttributedString alloc]initWithString:content];
        //将被回复人的昵称改为orangeColor
        [attStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor orangeColor]} range:[content rangeOfString:pm.nick]];
        
    }else{
        
        [content appendString:self.content];
        attStr = [[NSMutableAttributedString alloc]initWithString:content];
    }
    return  attStr;
}
-(CGFloat)cellHeight{
    
    CGRect rect = [self.attibuteString boundingRectWithSize:CGSizeMake(SCREEN_W - 153, 99999) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.height + 100;
    
}



@end
