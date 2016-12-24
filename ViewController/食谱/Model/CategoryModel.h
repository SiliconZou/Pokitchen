//
//  CategoryModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"

@interface CategoryModel : JSONModel

@property (nonatomic, copy) NSString *Id;//id是系统预留关键字，最好不要用它来定义变量

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *text;

@end
