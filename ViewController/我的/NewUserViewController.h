//
//  NewUserViewController.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController

@property (nonatomic, copy) NSString * userId;//用户ID
@property (nonatomic, copy) NSString * token;//后台标记你的会话权限的一个字符串，由后台生成

@end
