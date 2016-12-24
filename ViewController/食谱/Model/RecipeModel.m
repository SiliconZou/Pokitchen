//
//  RecipeModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "RecipeModel.h"

@implementation RecipeModel
//字典中的key 值个数少于模型属性时，导致key和属性不匹配，属性值为空的，会崩溃，需要忽略属性，正常赋值
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return  YES;
}
+(JSONKeyMapper *)keyMapper{
    //字典中key与属性名不一致时，通过字典的形式固定赋值的对应关系，模型的属性名作为Key 字典中的key名作为value
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"createDate":@"create_date",@"Description":@"description",@"Id":@"id",@"tagsInfo":@"tags_info"}];
}
//解决模型中嵌套数组的问题
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    //走完[super initWithDictionary:dict error:err]方法之后，除了tagsInfo这个属性之外，其他的属性都会被正常赋值，tagsInfo的值是一个数组，数组中存放的是字典对象；但是我们希望tagsInfo数组中存放的是TagsInfoModel的对象，所以需要进行特殊处理
    if (self){
        
        //先将tagsInfo对应的原数组取出
        NSArray *array = dict[@"tags_info"];
        //将数组中的一个个的字典转化为TagsInfoModel的对象
        self.tagsInfo = nil;
        //调用arrayOfModelsFromDictionaries:这个方法时，实际上就是遍历array中的字典，一个字典对应创建出一个TagsInfoModel的对象，并用字典的值给对应的属性赋值
        self.tagsInfo = [TagsInfoModel arrayOfModelsFromDictionaries:array error:nil];
    }
    return self;
}





@end
