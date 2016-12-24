//
//  DishClassModel+NetWork.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "DishClassModel.h"

#import "AlbumModel.h"

@interface DishClassModel (NetWork)

+(void)loadDishClassListWithPage:(NSInteger)page callBack:(void(^)(NSArray *array,NSError *error))callBack;

@end

//顶端图标的模型的类别
@interface AlbumModel (NetWork)

//获取顶端图标的网络请求处理
+(void)loadAlbumData:(void(^)(NSArray *array,NSError *error))callBack;

@end


