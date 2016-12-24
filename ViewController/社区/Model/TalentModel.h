//
//  TalentModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"
/**掌厨达人模型*/
@interface TalentModel : JSONModel

@property (nonatomic, copy) NSString * beFollow;
@property (nonatomic, copy) NSString * headImg;
@property (nonatomic, copy) NSString * nick;
@property (nonatomic, copy) NSString * tongjiBeFollow;
@property (nonatomic, assign) BOOL istalent;
@property (nonatomic, copy) NSString * userId;

@end

/**精选作品模型*/
@interface MarrowModel : JSONModel

@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * Description;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * video;

@end

/**专题作品*/

@class TopicDataModel;
@interface TopicModel : JSONModel

@property(nonatomic, copy) NSString * Id;

@property (nonatomic, copy) NSString * topicName;

@property(nonatomic, strong) NSMutableArray *data;

@end


@interface TopicDataModel : JSONModel

@property (nonatomic, copy) NSString * agreeCount;

@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * deleteTime;
@property (nonatomic, copy) NSString * Description;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * marrowTime;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * video;


@end


