//
//  CommentModel+NetWork.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CommentModel.h"
#import "FriendModel.h"
#import "RelateCourseModel.h"

//获取课程点赞好友的网络请求和解析处理
@interface FriendModel (NetWork)

+(void)loadFriendWithCourseId:(NSString *)courseId callBack:(void(^)(NSArray *array,NSError *error))callBack;

@end
//获取相关课程的网络请求处理
@interface RelateCourseModel (NetWork)

+(void)loadRelateCourseDataWithCourseId:(NSString *)courseId callBack:(void(^)(NSArray *array,NSError *error))callBack;

@end


//评论模型的网络请求过程以及显示逻辑处理
@interface CommentModel (NetWork)

+(void)loadCommentsWithRelateId:(NSString *)relateId callBack:(void(^)(NSArray *array,NSError *errror))callBack;

//处理显示评论内容的富文本字符串
-(NSAttributedString *)attibuteString;
//计算评论cell的高度
-(CGFloat)cellHeight;

@end


