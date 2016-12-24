//
//  CommentModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"

@interface CommentModel : JSONModel
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, assign) BOOL istalent;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, strong) NSMutableArray *parents;
@property (nonatomic, copy) NSString *relateId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString * userId;



@end
