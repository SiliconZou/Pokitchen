//
//  TagsInfoModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"

@interface TagsInfoModel : JSONModel

@property (nonatomic, copy) NSString * Id;

@property (nonatomic, copy) NSString * text;

@property (nonatomic, copy) NSString * type;

@end
