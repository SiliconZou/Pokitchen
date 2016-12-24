//
//  CourseHeaderView.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@class CourseHeaderView;
@protocol CourseHeaderViewDelegate <NSObject>

//当headerView的高度发生变化时，让代理对象重设高度
-(void)updateHeaderView:(CourseHeaderView *)headerView;
//当选中的剧集发生变化时，让代理对象去获取 点赞好友和相关课程的数据
-(void)headerVeiwDidSelectedCourse:(NSInteger)index;
//播放当前选中的视频
-(void)playVideoOfCourseAtIndex:(NSInteger)index;
//播放相关课程的视频
-(void)playRelatePlayItems:(NSArray *)items;

@end

@interface CourseHeaderView : UIView

// 第一部分的控件
@property (nonatomic, strong) UIImageView *dishImage;

@property (nonatomic, strong) UILabel * numOfPlayL;//显示上课人数
@property (nonatomic, strong) UILabel *nameL;//显示食课名

@property (nonatomic, strong) UILabel *subjectL;//显示描述


//第二部分

@property (nonatomic, strong) UIView *courseView;//显示剧集的父视图（第二部分的父视图）
@property (nonatomic, strong) UILabel *updateL;//更新至XX集

//第三部分
@property (nonatomic, strong) UIView *thirdView;//第三部分的父视图
@property (nonatomic, strong) UILabel *numOfAdmireL;//点赞个数
@property (nonatomic, strong) UICollectionView *friendView;//显示点赞好友
@property(nonatomic, strong) UICollectionView * relateCoureView;//显示相关课程的视图
@property (nonatomic, strong) UILabel * numOfCommetL;//显示总的评论条数

@property(nonatomic, strong) NSArray *courseArray;//课程的剧集数据

@property(nonatomic, strong) NSArray *friendArray;//点赞好友数据
@property(nonatomic, strong) NSArray *relateArray;//存放相关课程的数据


@property (nonatomic,weak) id <CourseHeaderViewDelegate> delegate;

@end
