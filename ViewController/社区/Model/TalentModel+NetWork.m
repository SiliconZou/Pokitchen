//
//  TalentModel+NetWork.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "TalentModel+NetWork.h"

@implementation TalentModel (NetWork)

+(void)loadRecommendData:(void (^)(NSArray *, NSArray *, NSError *))callBack
{
    
    //    methodName=ShequRecommend&token=&user_id=&version=4.4
    
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:@{@"methodName":@"ShequRecommend",@"version":@"4.4"}];
    UserModel *user = [UserModel shareUser];
    if(user.isLogin){
        [para setObject:user.userId forKey:@"user_id"];
        [para setObject:user.token forKey:@"token"];
    }
    
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        if (!error) {
            //解析根目录字典
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //解析轮播图片的数组
            NSArray * bannerArr = dict[@"data"][@"banner"];
            NSMutableArray *imageArray = [[NSMutableArray alloc]init];
            for(NSDictionary *dic in bannerArr)
            {
                [imageArray addObject:dic[@"banner_picture"]];
            }
            //解析掌厨达人
            NSArray *talentArr = dict[@"data"][@"shequ_talent"];
            //将所有的字典转化为达人模型对象
            NSMutableArray *talents = [TalentModel arrayOfModelsFromDictionaries:talentArr error:nil];
            //解析精选专题
            NSArray *marrowArr = dict[@"data"][@"shequ_marrow"];
            NSMutableArray *marrows = [MarrowModel arrayOfModelsFromDictionaries:marrowArr error:nil];
            //继续专题
            NSArray *topicArr = dict[@"data"][@"shequ_topics"];
            NSMutableArray * topics = [TopicModel arrayOfModelsFromDictionaries:topicArr error:nil];
            
            //将掌厨达人 和 精选专题的数组 添加到 topics 数组中
            [topics insertObject:marrows atIndex:0];
            [topics insertObject:talents atIndex:0];

            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                callBack(imageArray,topics,nil);
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                callBack(nil,nil,error);
            });
        }
        
        
    }];
}
@end
