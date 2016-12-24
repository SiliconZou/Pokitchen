//
//  RecipeViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeModel+NetWork.h"
#import "RecipeCell.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVPlayerViewController.h>
#import <AVKit/AVKit.h>


#import "XTADScrollView.h"//注意使用该类要在工程中导入SDWebImage

@interface RecipeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *categoryArray;//存放分类视图的数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) XTADScrollView *adView;



@end

@implementation RecipeViewController

-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headView;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //注册复用的cell
        [_tableView registerNib:[UINib nibWithNibName:@"RecipeCell" bundle:nil] forCellReuseIdentifier:@"RecipeCell"];
        //使用纯代码编写的cell注册方式
//        [_tableView registerClass:[RecipeCell class] forCellReuseIdentifier:@"RecipeCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(UIView *)headView{
    if(!_headView){
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 300)];
        _headView.backgroundColor = [UIColor whiteColor];
        //添加轮播视图
        [_headView addSubview:self.adView];
    }
    return _headView;
}
-(XTADScrollView *)adView{
    
    if(!_adView){
        _adView = [[XTADScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 120)];
        //是否自动启动轮播
        _adView.infiniteLoop = YES;
        _adView.needPageControl = YES;
        _adView.pageControlPositionType = pageControlPositionTypeRight;
    }
    return _adView;
}
-(NSMutableArray *)categoryArray{
    if(!_categoryArray){
        _categoryArray = [[NSMutableArray alloc]init];
    }
    return _categoryArray;
}
-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //关闭自动留出Bar空间的属性
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadData];
}

-(void)loadData{
    
    [RecipeModel loadReicpeModels:^(NSArray *banner, NSArray *category, NSArray *recipe, NSError *error) {
        //网络数据请求成功
        if(!error){
            //给轮播视图赋轮播图片的地址
            self.adView.imageURLArray = banner;
            //保存分类按钮所对应的模型对象
            [self.categoryArray addObjectsFromArray:category];
            //创建分类按钮
            [self createCategoryBtns];
            //将食谱数据添加到数据源数组中
            [self.dataArray addObjectsFromArray:recipe];
            [self.tableView reloadData];
        }
        
    }];
    
}
//创建分类按钮
-(void)createCategoryBtns{
    CGFloat space = 20;
    //根据屏幕宽度计算按钮的宽度
    CGFloat btnW = (SCREEN_W - 5 * space) / 4;
    NSInteger i = 0;//用于计算btn的位置
    //
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_W, 2 * (btnW + space) + space)];
                                                              
    subView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:subView];
    //重新设置头视图的高度
    self.headView.frame = CGRectMake(0, 0, SCREEN_W, subView.frame.origin.y + subView.frame.size.height);
    for(CategoryModel * model in self.categoryArray){
        
        CGFloat orginX = (i % 4) * (btnW + space) + space;
        CGFloat orginY = (i / 4) * (btnW + space) + space;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(orginX, orginY, btnW, btnW)];
        //设置网络的背景图片
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal];
        [button setTitle:model.text forState:UIControlStateNormal];
        //设置标题的字体
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        //设置标题颜色
        [button setTitleColor:TEXT_GRAYCOLOR forState:UIControlStateNormal];
        //设置标题的偏移量
        button.titleEdgeInsets = UIEdgeInsetsMake(btnW + space, 0, 0, 0);
        
        [subView addSubview:button];
        i++;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView的协议方法
//分组数目
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return  array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"RecipeCell";
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    //取出对应组的数据数组
    NSArray *array = self.dataArray[indexPath.section];
    //取出对应行的食谱模型
    RecipeModel *model = array[indexPath.row];
    
    cell.titleL.text = model.title;
    
    cell.descriptionL.text = model.Description;
    //设置图片
    [cell.dishImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 20)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    NSArray *titleArray = @[@"| 热门推荐  >",@"| 新品推荐  >",@"| 排行榜  >",@"| 主题推荐  >"];
    label.text = titleArray[section];
    return label;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //对应组的数据
    NSArray *array = self.dataArray[indexPath.section];
    //取出对应行的模型
    RecipeModel *model = array[indexPath.row];
    
    //创建播放项目
    AVPlayerItem *item1 = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.video]];
    AVPlayerItem *item2 = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.video1]];
    //创建播放器
    AVQueuePlayer *player = [[AVQueuePlayer alloc]initWithItems:@[item1,item2]];
    AVPlayerViewController *vc = [[AVPlayerViewController alloc]init];
    vc.player = player;
    
    [self presentViewController:vc animated:YES completion:nil];
    
}




@end
