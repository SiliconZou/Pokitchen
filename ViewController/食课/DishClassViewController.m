//
//  DishClassViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "DishClassViewController.h"
#import "DishClassModel+NetWork.h"
#import "DishClassCell.h"
#import "AlbumCell.h"
#import "QFNormalHeader.h"
#import "CourseViewController.h"


@interface DishClassViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger page;//控制显示的页码
@property (nonatomic, strong) UICollectionView *albumView;//显示顶端图标的CollectionView
@property (nonatomic, strong) NSMutableArray *albumArray;

@end

@implementation DishClassViewController

-(NSMutableArray *)albumArray{
    if(!_albumArray){
        _albumArray = [[NSMutableArray alloc]init];
    }
    return _albumArray;
}
-(UICollectionView *)albumView{
    if(!_albumView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //设置滚动方向为横向滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;
        _albumView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, 80) collectionViewLayout:layout];
        _albumView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:0.7];
        _albumView.showsHorizontalScrollIndicator = NO;
        [_albumView registerNib:[UINib nibWithNibName:@"AlbumCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumCell"];
        _albumView.delegate = self;
        _albumView.dataSource = self;
        
        [self.view addSubview:_albumView];
    }
    return _albumView;
}
-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_W,SCREEN_H - (64 + 49)) style:UITableViewStylePlain];
        //隐藏竖直方向的滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"DishClassCell" bundle:nil] forCellReuseIdentifier:@"DishClassCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //留出顶端一排图标的高度
        _tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
        //下拉刷新
        _tableView.header = [QFNormalHeader headerWithRefreshingBlock:^{
            
            self.page = 1;
            [self loadDishListData];
        }];
        
        
        //上拉加载更多
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.page ++;
            [self loadDishListData];
        }];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.page = 1;
    [self loadDishListData];
    
    [self loadAlbumData];
    
    
}
//获取顶端图标
-(void)loadAlbumData{
    
    [HDManager startLoading];//开始网络请求，显示加载指示器
    [AlbumModel loadAlbumData:^(NSArray *array, NSError *error) {
        if(!error){
            [self.albumArray addObjectsFromArray:array];
            [self.albumView reloadData];
            //将试图放到最外层
            [self.view bringSubviewToFront:self.albumView];
        }
        [HDManager stopLoading];
    }];
    
}

//获取食课列表数据
-(void)loadDishListData{
    
    [HDManager startLoading];//开始加载数据，显示加载指示器
    [DishClassModel loadDishClassListWithPage:self.page callBack:^(NSArray *array, NSError *error) {
        
        if(!error){
            
            if (self.page == 1) {
                
                [self.dataArray removeAllObjects];
            }
            //添加数据源
            [self.dataArray addObjectsFromArray:array];
            //刷新TableView
            [self.tableView reloadData];
            //结束上拉加载更多
            [self.tableView.footer endRefreshing];
            [self.tableView.header endRefreshing];
            //将tableView放到最底层
            [self.view sendSubviewToBack:self.tableView];
        }
        [HDManager stopLoading];//结束加载，隐藏加载指示器
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"DishClassCell";
    //这个方法处理创建新的cell 和cell 复用
    DishClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    //取出对应行的模型对象
    DishClassModel *model = self.dataArray[indexPath.row];
    [cell.dishImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    [cell.albumLogo sd_setImageWithURL:[NSURL URLWithString:model.albumLogo]];
    NSArray *array = [model.seriesName componentsSeparatedByString:@"#"];
    cell.nameL.text = [array lastObject];
    cell.updateL.text = [NSString stringWithFormat:@"更新至%@集",model.episode];
    cell.numL.text = [NSString stringWithFormat:@"上课人数:%@",model.play];
    cell.albumL.text = model.album;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先取出对应行的模型对象
    DishClassModel *model = self.dataArray[indexPath.row];
    CourseViewController *course = [[CourseViewController alloc]init];
    course.relateId = model.seriesId;
    course.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:course animated:YES];
}

#pragma mark - UICollectionView协议方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.albumArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"AlbumCell";
    AlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //取出模型
    AlbumModel *model = self.albumArray[indexPath.item];
    [cell.albumLogo sd_setImageWithURL:[NSURL URLWithString:model.albumLogo]];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 80);
}





@end
