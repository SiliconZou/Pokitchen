//
//  RecipeModel+NetWork.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "RecipeModel.h"
#import "CategoryModel.h"
//通过类别，将本该在ViewController中编写的网络请求过程以及解析、建模的过程，写到类别当中（ViewModel）

@interface RecipeModel (NetWork)

+(void)loadReicpeModels:(void(^)(NSArray *banner,NSArray *category,NSArray *recipe,NSError * error))callBack;

@end
