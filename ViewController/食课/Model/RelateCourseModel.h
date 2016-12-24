//
//  RelateCourseModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/30.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"

@class RelationModel;//声明一个类
@interface RelateCourseModel : JSONModel

@property (nonatomic, copy) NSString * mediaId;
@property (nonatomic, copy) NSString * mediaType;
//json中的字典嵌套字典 转化为 模型嵌套模型
@property (nonatomic, strong) RelationModel * relation;

@end

@interface RelationModel : JSONModel

@property (nonatomic, copy) NSString * dishesId;

@property (nonatomic, copy) NSString *dishesImage;

@property (nonatomic, copy) NSString *dishesTitle;

@property (nonatomic, copy) NSString * materialVideo;

@property (nonatomic, copy) NSString * processVideo;

@end

