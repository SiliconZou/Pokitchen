//
//  CommentModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
//处理字典中key 和模型属性不匹配的情况
+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"createTime":@"create_time",@"headImg":@"head_img",@"Id":@"id",@"parentId":@"parent_id",@"relateId":@"relate_id",@"userId":@"user_id"}];
}
//属性个数和字典key个数不匹配情况
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    self = [super initWithDictionary:dict error:err];
    //执行完上一行代码之后，self.parents 数组中存放的还是字典，但是我们希望的是评论的模型对象
    self.parents = nil;
    NSArray *array = dict[@"parents"];
    self.parents = [CommentModel arrayOfModelsFromDictionaries:array error:nil];
    return self;
}


@end
