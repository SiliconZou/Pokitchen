//
//  TalentModel+NetWork.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "TalentModel.h"
/**社区模块  推荐页面的网络请求处理*/
@interface TalentModel (NetWork)

+(void)loadRecommendData:(void(^)(NSArray *banner,NSArray *array,NSError *error))callBack;

@end
