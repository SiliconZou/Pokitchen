//
//  CourseHeaderView.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CourseHeaderView.h"
#import "CourseModel.h"
#import "FriendCell.h"
#import "FriendModel.h"
#import "RelateCourseCell.h"
#import "RelateCourseModel.h"



@interface CourseHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGFloat topSpace;
    CGFloat leftSapce;
    CGFloat space;//剧集按钮之际的空格
    CGFloat btnW;
}
@property (nonatomic, strong) CourseModel *course;
@property (nonatomic, assign) NSInteger selectedIndex;//当前选中的剧集下标
@property (nonatomic, assign) BOOL isShowContent;//显示描述
@property (nonatomic, assign) BOOL isShowCourse;//显示全部剧集（大于16集)


@end

@implementation CourseHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        topSpace = 10;
        leftSapce = 15;
        space = 5;
        [self createSuviews];
    }
    return self;
}
-(void)createSuviews{
    
    _dishImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 150)];
    _dishImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVideo:)];
    [_dishImage addGestureRecognizer:ges];
    
    [self addSubview:_dishImage];
    
    UIImageView *play = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    play.image = [UIImage imageNamed:@"首页-播放.png"];
    [_dishImage addSubview:play];
    //设置显示到父试图的正中央
    play.center = _dishImage.center;
    
    _numOfPlayL = [[UILabel alloc]initWithFrame:CGRectMake(leftSapce, _dishImage.mj_h + topSpace, SCREEN_W - 2 * leftSapce, 23)];
    _numOfPlayL.textColor = TEXT_GRAYCOLOR;
    _numOfPlayL.font = [UIFont systemFontOfSize:16];
    _numOfPlayL.text = @"上课人数:4567";
    [self addSubview:_numOfPlayL];
    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(leftSapce, _numOfPlayL.mj_y + _numOfPlayL.mj_h + topSpace, SCREEN_W - leftSapce - 60, 23)];
    _nameL.textColor = [UIColor blackColor];
    _nameL.font = [UIFont boldSystemFontOfSize:18];
    _nameL.text = @"柠檬小蛋糕";
    [self addSubview:_nameL];
    
    UIButton *showSubject = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W - leftSapce - 25, _nameL.mj_y - 1, 25, 25)];
    [showSubject setBackgroundImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateNormal];
    [showSubject setBackgroundImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateNormal];

    [showSubject addTarget:self action:@selector(showOrHiddenContent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:showSubject];
    
    _subjectL = [[UILabel alloc]initWithFrame:CGRectMake(leftSapce, _nameL.mj_y + _nameL.mj_h + topSpace, SCREEN_W - 2 * leftSapce, 0)];
    _subjectL.textColor = TEXT_GRAYCOLOR;
    _subjectL.font = [UIFont systemFontOfSize:15];
    _subjectL.numberOfLines = 0;
    [self addSubview:_subjectL];
    
    //第二部分
    _courseView = [[UIView alloc]initWithFrame:CGRectMake(0, _subjectL.mj_y + _subjectL.mj_h, SCREEN_W, 200)];
    _courseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_courseView];
    
    UILabel * xuanjiL = [[UILabel alloc]initWithFrame:CGRectMake(leftSapce, 2 * topSpace, 100, 23)];
    xuanjiL.textColor = [UIColor blackColor];
    xuanjiL.font = [UIFont systemFontOfSize:16];
    xuanjiL.text = @"选集";
    [_courseView addSubview:xuanjiL];
    
    _updateL = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - leftSapce - 25 - 140, xuanjiL.mj_y, 140, 23)];
    _updateL.textColor = TEXT_GRAYCOLOR;
    _updateL.font = [UIFont systemFontOfSize:16];
    _updateL.textAlignment = NSTextAlignmentRight;
    _updateL.text = @"更新至32集";
    [_courseView addSubview:_updateL];
    
    UIButton *showCoure = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W - leftSapce - 25, _updateL.mj_y - 1, 25, 25)];
    [showCoure setBackgroundImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateNormal];
    [showCoure setBackgroundImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateHighlighted];
    [showCoure addTarget:self action:@selector(showOrHiddenCourse:) forControlEvents:UIControlEventTouchUpInside];
    
    [_courseView addSubview:showCoure];
    
    //第三部分
    _thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, _courseView.mj_y + _courseView.mj_h, SCREEN_W, 400)];
    _thirdView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_thirdView];
    
    _numOfAdmireL = [[UILabel alloc]initWithFrame:CGRectMake(leftSapce, 3 * topSpace, 180, 23)];
    _numOfAdmireL.textColor = [UIColor blackColor];
    _numOfAdmireL.font = [UIFont systemFontOfSize:16];
    _numOfAdmireL.text = @"24位厨友觉得很赞";
    [_thirdView addSubview:_numOfAdmireL];
    
    UIButton *zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(_numOfAdmireL.mj_x + _numOfAdmireL.mj_w, _numOfAdmireL.mj_y - 3, 25, 25)];
    [zanBtn setBackgroundImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
    [zanBtn setBackgroundImage:[UIImage imageNamed:@"agree"] forState:UIControlStateHighlighted];
    [_thirdView addSubview:zanBtn];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc]init];
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout1.minimumLineSpacing = 0;
    layout1.minimumInteritemSpacing = 0;
    _friendView = [[UICollectionView alloc]initWithFrame:CGRectMake(leftSapce, _numOfAdmireL.mj_y + _numOfAdmireL.mj_h + topSpace, SCREEN_W - 2 * leftSapce, 80) collectionViewLayout:layout1];
    //注册复用的cell
    [_friendView registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellWithReuseIdentifier:@"FriendCell"];
    _friendView.delegate = self;
    _friendView.dataSource = self;
    [_thirdView addSubview:_friendView];
    
    
    UILabel *relateL = [[UILabel alloc]initWithFrame:CGRectMake(leftSapce, _friendView.mj_y + _friendView.mj_h + topSpace, 200, 23)];
    relateL.textColor = [UIColor blackColor];
    relateL.font = [UIFont systemFontOfSize:16];
    relateL.text = @"相关课程";
    [_thirdView addSubview:relateL];
    
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc]init];
    layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout2.minimumInteritemSpacing = 0;
    layout2.minimumLineSpacing = 0;
    _relateCoureView = [[UICollectionView alloc]initWithFrame:CGRectMake(leftSapce, relateL.mj_y + relateL.mj_h + topSpace, SCREEN_W - 2 * leftSapce, 230) collectionViewLayout:layout2];
    
    [_relateCoureView registerNib:[UINib nibWithNibName:@"RelateCourseCell" bundle:nil] forCellWithReuseIdentifier:@"RelateCourseCell"];
    _relateCoureView.delegate = self;
    _relateCoureView.dataSource = self;
    
    [_thirdView addSubview:_relateCoureView];
    
    _friendView.backgroundColor = [UIColor whiteColor];
    _friendView.showsHorizontalScrollIndicator = NO;
    _relateCoureView.backgroundColor = [UIColor whiteColor];
    _relateCoureView.showsHorizontalScrollIndicator = NO;
    
    _numOfCommetL = [[UILabel alloc]initWithFrame:CGRectMake(leftSapce, _relateCoureView.mj_y + _relateCoureView.mj_h + topSpace, SCREEN_W - 2 * leftSapce, 23)];
    _numOfCommetL.textColor = [UIColor blackColor];
    _numOfCommetL.font = [UIFont systemFontOfSize:16];
    _numOfCommetL.text = @"20条发言";
    [_thirdView addSubview:_numOfCommetL];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(leftSapce, _numOfCommetL.mj_y + _numOfCommetL.mj_h + topSpace, SCREEN_W - 2 * leftSapce, 30)];
    label.backgroundColor = [UIColor orangeColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"课  堂  发 言";
    [_thirdView addSubview:label];
    
    _thirdView.mj_h = label.mj_y + label.mj_h;
    self.mj_h = _thirdView.mj_y + _thirdView.mj_h;
}
#pragma mark - 更新各个部分的frame
-(void)updateFrame
{
    if(_isShowContent){
        
        _courseView.mj_y = _subjectL.mj_y + _subjectL.mj_h;
    }else{
        _courseView.mj_y = _subjectL.mj_y;
    }
    //计算第二部分 剧集部分高度的计算
    //line > 2 且 _isShowCourse = NO // 以 2计算
    //line > 3  _isShowCourse = YES //以真实 行数计算
    //line <= 2 _isShowCourse = YES/NO /以真实 行数计算
    NSInteger  line = 0;
    //计算真实行数
    if(self.courseArray.count % 8 == 0){
        line = self.courseArray.count / 8;
    }else{
        line = (self.courseArray.count / 8) + 1;
    }
    
    
    //line > 2 且 _isShowCourse = NO // 以 2计算
    if(line > 2 && !_isShowCourse){
        line = 2;
    }
    // 计算第二部分的显示高度
    CGFloat courseH = _courseView.mj_y + _updateL.mj_h + _updateL.mj_y + topSpace + (line - 1) * space + line * btnW;
    //重设第二部分的高度
    _courseView.mj_h = courseH;
    //移动第三部分的位置
    _thirdView.mj_y = courseH;
    //重设整体的headerView的高度
    self.mj_h = _thirdView.mj_y + _thirdView.mj_h;
    //通知代理对象，更新frame
    [self.delegate updateHeaderView:self];
}

#pragma mark - 显示或隐藏描述
-(void)showOrHiddenContent:(UIButton *)button{
    
    _isShowContent = !_isShowContent;
    [self updateFrame];
    if(_isShowContent){
        [button setBackgroundImage:[UIImage imageNamed:@"expend_up"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"expend_up"] forState:UIControlStateHighlighted];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateHighlighted];
    }
}
-(void)showOrHiddenCourse:(UIButton *)button
{
    _isShowCourse = !_isShowCourse;
    if(_isShowCourse){
        [button setBackgroundImage:[UIImage imageNamed:@"expend_up"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"expend_up"] forState:UIControlStateHighlighted];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateHighlighted];
    }
    [self updateFrame];
}

#pragma mark - 剧集按钮相关

-(void)setCourseArray:(NSArray *)courseArray{
   
    if(_courseArray != courseArray){
        
        _courseArray = courseArray;
    }
    //创建剧集按钮
    [self createCourseBtns];
    self.course = [_courseArray lastObject];
    _updateL.text = [NSString stringWithFormat:@"更新至%ld集",_courseArray.count];
}
-(void)setCourse:(CourseModel *)course{
    if(_course != course){
        _course = course;
        [_dishImage sd_setImageWithURL:[NSURL URLWithString:_course.courseImage]];
        _numOfPlayL.text = [NSString stringWithFormat:@"上课人数:%@",_course.videoWatchcount];
        _subjectL.text = _course.courseSubject;
        //高度自适应
        [_subjectL sizeToFit];
         //需要调整第二部分第三部分的frame
        _nameL.text = _course.courseName;
    }
    //选中新的课程，去网络获取点赞好友和相关课程数据
    [self.delegate headerVeiwDidSelectedCourse:self.selectedIndex];
    
    [self updateFrame];
}
-(void)setFriendArray:(NSArray *)friendArray{
    
    if(_friendArray != friendArray){
        _friendArray = nil;
        _friendArray = friendArray;
        
        _numOfAdmireL.text = [NSString stringWithFormat:@"%ld位厨友觉得很赞",_friendArray.count];
        
        //刷新点赞好友的数据
        [_friendView reloadData];
    }
}
-(void)setRelateArray:(NSArray *)relateArray{
    
    if(_relateArray != relateArray){
        _relateArray = nil;
        _relateArray = relateArray;
        //刷新相关课程的视图
        [_relateCoureView reloadData];
    }
}



-(void)createCourseBtns{
    
    btnW = (SCREEN_W - 7 * space - 2 * leftSapce) / 8.0;
    CGFloat orginY = _updateL.mj_y + _updateL.mj_h + topSpace;
   
    for(NSInteger i = 0; i < self.courseArray.count; i++){
        
        CGFloat btnX = leftSapce + (i % 8) * (btnW + space);
        CGFloat btnY = orginY + (i / 8) * (btnW + space);
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnW)];
        button.backgroundColor = GRAY_COLOR;
        [button setTitle:[NSString stringWithFormat:@"%ld",i + 1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_courseView addSubview:button];
        button.tag = i + 200;
        [button addTarget:self action:@selector(courseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if(i == self.courseArray.count - 1){
            self.selectedIndex = i;
           
        }
    }
    [self updateFrame];

}
//选中选集
-(void)courseBtnClicked:(UIButton *)button{
  
    self.selectedIndex = button.tag - 200;
    
}
-(void)playVideo:(UITapGestureRecognizer *)ges
{
    //让代理对象播放视频
    
    [self.delegate playVideoOfCourseAtIndex:self.selectedIndex];
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    //取出上一次选中的按钮
    UIButton *preBtn = (UIButton *)[self viewWithTag:200 + _selectedIndex];
    [preBtn setTitleColor:[UIColor blackColor   ] forState:UIControlStateNormal];
    preBtn.backgroundColor = GRAY_COLOR;
    //取出当前选中的按钮
    UIButton *button = (UIButton *)[self viewWithTag:200 + selectedIndex];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    _selectedIndex = selectedIndex;
    self.course = self.courseArray[_selectedIndex];
}
#pragma mark - UICollectionView协议方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == _friendView){
        
        return  [self.friendArray count];
    }
    return self.relateArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == _friendView){
        static NSString * cellID = @"FriendCell";
        FriendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        //取出对应的好友模型
        FriendModel *model = self.friendArray[indexPath.item];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"达人.png"]];
        
        return cell;
    }else{
        
        static NSString * cellId = @"RelateCourseCell";
        RelateCourseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        //取出相关课程的对象
        RelateCourseModel *model = self.relateArray[indexPath.item];
        cell.titleL.text = model.relation.dishesTitle;
        
        [cell.dishImage sd_setImageWithURL:[NSURL URLWithString:model.relation.dishesImage]];
        
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(collectionView == _friendView){
        
        return CGSizeMake(80, 80);
    }
    
    return CGSizeMake(180, 230);//CGSizeZero
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if(collectionView == _relateCoureView){
        return 5;
    }
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == _relateCoureView){
        
        //取出相关课程的对象
        RelateCourseModel *model = self.relateArray[indexPath.item];
        AVPlayerItem *item1 = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.relation.materialVideo]];
        AVPlayerItem *item2 = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.relation.processVideo]];
        //让代理对象播放着两个视频
        [self.delegate playRelatePlayItems:@[item1,item2]];
        
    }
}


@end
