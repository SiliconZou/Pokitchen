//
//  RecipeModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"
#import "TagsInfoModel.h"

@interface RecipeModel : JSONModel

@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * createDate;
@property (nonatomic, copy) NSString * Description;
@property (nonatomic, copy) NSString * favorite;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * play;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * video;
@property (nonatomic, copy) NSString * video1;
//模型中嵌套数组，数组中存放另一模型的对象
@property (nonatomic, strong) NSMutableArray * tagsInfo;

@end
