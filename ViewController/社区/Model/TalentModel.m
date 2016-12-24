//
//  TalentModel.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "TalentModel.h"

@implementation TalentModel

+(JSONKeyMapper *)keyMapper{
    
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end


@implementation MarrowModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"Description":@"description",@"Id":@"id"}];
}

@end


/**专题作品*/
@implementation TopicModel

+(JSONKeyMapper *)keyMapper{
    
    return  [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"Id":@"id",@"topicName":@"topic_name"}];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    self = [super initWithDictionary:dict error:err];
    if(self){
        
        self.data = nil;
        NSArray *array = dict[@"data"];
        self.data = [TopicDataModel arrayOfModelsFromDictionaries:array error:nil];
    }
    return self;
}

@end

@implementation TopicDataModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"agreeCount":@"agree_count",@"commentCount":@"comment_count",@"createTime":@"create_time",@"deleteTime":@"delete_time",@"Description":@"description",@"Id":@"id",@"marrowTime":@"marrow_time",@"userId":@"user_id"}];
}

@end

