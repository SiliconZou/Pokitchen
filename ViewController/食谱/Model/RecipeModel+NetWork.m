//
//  RecipeModel+NetWork.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "RecipeModel+NetWork.h"

@implementation RecipeModel (NetWork)

+(void)loadReicpeModels:(void (^)(NSArray *, NSArray *, NSArray *, NSError *))callBack{
    
    NSDictionary *para = @{@"methodName":@"HomeIndex"};
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        
        if(error == nil){
            //请求处理成功，进行解析
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //解析banner
            NSMutableArray *banner = [[NSMutableArray alloc]init];
            NSArray * bannerArray = dict[@"data"][@"banner"][@"data"];
            
            for(NSDictionary *dic in bannerArray){
                //解析图片地址
                [banner addObject:dic[@"image"]];
            }
            //分类模型的解析
            NSArray *categoryArray = dict[@"data"][@"category"][@"data"];
            //将分类对应的字典转化为CategoryModel的对象
            NSMutableArray *category = [CategoryModel arrayOfModelsFromDictionaries:categoryArray error:nil];
            
            //解析食谱模型
            NSMutableArray *recipe = [[NSMutableArray alloc]init];
            //取到食谱的四个分组的数组
            NSArray *dataArray = dict[@"data"][@"data"];
            for(NSDictionary *dic in dataArray){
                
                NSArray *recipeArray = dic[@"data"];
                NSMutableArray *models = [RecipeModel arrayOfModelsFromDictionaries:recipeArray error:nil];
                //添加每一分组的小数组
                [recipe addObject:models];
            }
            //回调到主线程中，刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(banner,category,recipe,nil);
            });
        }else{
            //请求处理失败
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(nil,nil,nil, error);
            });
        }
        
    }];
 
    
}
@end
