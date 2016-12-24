//
//  CourseViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CourseViewController.h"
#import "CommentModel+NetWork.h"
#import "CommentCell.h"
#import "CourseModel+NetWork.h"
#import "CourseHeaderView.h"
#import <AVKit/AVPlayerViewController.h>


@interface CourseViewController ()<UITableViewDelegate,UITableViewDataSource,CourseHeaderViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;//存放评论模型的数组
@property (nonatomic, strong) CourseHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray * courseArray;
@end

@implementation CourseViewController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)courseArray{
    
    if(!_courseArray){
        _courseArray = [[NSMutableArray alloc]init];
    }
    return _courseArray;
}

-(CourseHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[CourseHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 400)];
        //指定代理关系
        _headerView.delegate = self;
    }
    return _headerView;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.estimatedRowHeight = 44;
        _tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadCommentData];
    
    [self loadCourseData];
    
}
#pragma mark - 网络数据请求
//获取一系列时课的剧集
-(void)loadCourseData{
    [HDManager startLoading];
    [CourseModel loadCourseDataWithId:self.relateId callBack:^(NSArray *array, NSError *error) {
        
        if(!error){
            [self.courseArray addObjectsFromArray:array];
            self.headerView.courseArray = array;
        }
        [HDManager stopLoading];
    }];
}
//获取点赞好友数据
-(void)loadFriendsData:(NSString *)courseId{

    [HDManager startLoading];
   [FriendModel loadFriendWithCourseId:courseId callBack:^(NSArray *array, NSError *error) {
       if(!error){
           
           self.headerView.friendArray = array;
       }
       [HDManager stopLoading];
   }];
}
//获取相关课程数据
-(void)loadRelateCourseData:(NSString *)courseId{
    
    [HDManager startLoading];
    [RelateCourseModel loadRelateCourseDataWithCourseId:courseId callBack:^(NSArray *array, NSError *error) {
       
        if(!error){
            self.headerView.relateArray = array;
        }
        [HDManager stopLoading];
    }];
    
}

//获取评论数据
-(void)loadCommentData{
  
    [HDManager startLoading];
   [CommentModel loadCommentsWithRelateId:self.relateId callBack:^(NSArray *array, NSError *errror) {
       
       if(!errror){
           
           [self.dataArray addObjectsFromArray:array];
           //修改总的发言数目
           self.headerView.numOfCommetL.text = [NSString stringWithFormat:@"%ld条发言",self.dataArray.count];
           
           [self.tableView reloadData];
       }
       [HDManager stopLoading];
       
   }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CourseHeaderView的协议方法

-(void)updateHeaderView:(CourseHeaderView *)headerView{
    //重色tableView的tableHeaderView，刷新高度
    self.tableView.tableHeaderView = headerView;
    
}
-(void)headerVeiwDidSelectedCourse:(NSInteger)index{
    
    //取出被选中的课程
    CourseModel *course = self.courseArray[index];
    [self loadFriendsData:course.courseId];
    [self loadRelateCourseData:course.courseId];
}

-(void)playVideoOfCourseAtIndex:(NSInteger)index{
   
    //取出对应的剧集对象
    CourseModel *course = self.courseArray[index];
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:course.courseVideo]];
    AVPlayer * player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc]init];
    playerVC.player = player;
    [self presentViewController:playerVC animated:YES completion:nil];
}
//播放相关课程的视频
-(void)playRelatePlayItems:(NSArray *)items{
    //创建播放多个连续视频的播放器
    AVQueuePlayer *player = [[AVQueuePlayer alloc]initWithItems:items];
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc]init];
    playerVC.player = player;
    [self presentViewController:playerVC animated:YES completion:nil];

}

#pragma mark - UITableView的协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    //取出评论模型
    CommentModel *model = self.dataArray[indexPath.row];
    //设置头像
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"达人.png"]];
    cell.nickL.text = model.nick;
    cell.timeL.text = model.createTime;
       cell.contentL.attributedText = [model attibuteString];
    [cell.contentL sizeToFit];//自动调整高度
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}


@end
