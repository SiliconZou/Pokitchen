//
//  CommunityViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CommunityViewController.h"
#import "AttentionView.h"
#import "RecommendView.h"
#import "NewestView.h"
#import "PushViewControllerDelegate.h"
#import "NavTitleView.h"

@interface CommunityViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PushViewControllerDelegate,NavTitleViewDelegate>

@property(nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic, strong) NavTitleView *titleView;
@end

@implementation CommunityViewController

-(UICollectionView *)collectionView{
    
    if(!_collectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册不同的三种cell
        [_collectionView registerClass:[AttentionView class] forCellWithReuseIdentifier:@"AttentionView"];
        [_collectionView registerClass:[RecommendView class] forCellWithReuseIdentifier:@"RecommendView"];
        [_collectionView registerClass:[NewestView class] forCellWithReuseIdentifier:@"NewestView"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        //设置偏移量  显示推荐
        _collectionView.contentOffset = CGPointMake(SCREEN_W, 0);
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createTitleView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView reloadData];
}

-(void)createTitleView{
    
    _titleView = [[NavTitleView alloc]initWithFrame:CGRectMake(80, 20, SCREEN_W - 160, 44) titleArray:@[@"关注",@"最新",@"推荐"]];
    //建立代理关系
    _titleView.delegate = self;
    
    self.navigationItem.titleView = _titleView;
}

#pragma mark - NavTitleViewDelegate 协议方法
-(void)didSelectedTitleAtIndex:(NSInteger)index{
    self.collectionView.contentOffset = CGPointMake(index * SCREEN_W, 0);
}
#pragma mark - UICollectionView的协议方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = nil;
    if(indexPath.item == 0){
        cellID = @"AttentionView";
    }else if(indexPath.item == 1){
        cellID = @"RecommendView";
    }else{
        cellID = @"NewestView";
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if(indexPath.item == 1){
        RecommendView * view = (RecommendView *)cell;
        view.delegate = self;
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREEN_W, SCREEN_H - 64 - 49);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.mj_w;
    self.titleView.selectedIndex = index;
}

#pragma mark - PushViewControllerDelegate 协议方法（共给三个视图使用 AttentionView、RecommendView、NewestVeiw）

-(void)pushViewController:(UIViewController *)destinationViewController
{
    destinationViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:destinationViewController animated:YES];
}





@end
