//
//  CourseModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"

@interface CourseModel : JSONModel

@property (nonatomic, copy) NSString * courseId;
@property (nonatomic, copy) NSString * courseImage;
@property (nonatomic, copy) NSString * courseIntroduce;
@property (nonatomic, copy) NSString * courseName;
@property (nonatomic, copy) NSString * courseSubject;
@property (nonatomic, copy) NSString * courseVideo;
@property (nonatomic, copy) NSString * episode;
@property (nonatomic, copy) NSString * isCollect;
@property (nonatomic, copy) NSString * isLike;
@property (nonatomic, copy) NSString *ischarge;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *videoWatchcount;

@end
