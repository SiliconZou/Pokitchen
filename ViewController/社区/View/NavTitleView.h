//
//  NavTitleView.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/2.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavTitleViewDelegate <NSObject>

-(void)didSelectedTitleAtIndex:(NSInteger)index;

@end


@interface NavTitleView : UIView
@property(nonatomic,assign) NSInteger selectedIndex; //记录上一次选中的按钮
//通过frame和标题数组创建titleView
@property(nonatomic,weak) id <NavTitleViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

@end
