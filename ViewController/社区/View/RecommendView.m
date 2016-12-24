//
//  RecommendView.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "RecommendView.h"
#import "TalentModel+NetWork.h"
#import "RecommendCell.h"

#import "TalentListViewController.h"//达人列表
#import "TalentViewController.h"//达人详情


@interface RecommendView ()<RecommendCellDataSource,RecommendCellDelegate>

@end

@implementation RecommendView

-(NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(XTADScrollView *)adView{
    
    if(!_adView){
        _adView = [[XTADScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 150)];
        _adView.infiniteLoop = YES;
        _adView.pageControlPositionType = pageControlPositionTypeRight;
    }
    return _adView;
}
-(UITableView *)tableView{
    
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64 -49) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.adView;
        [_tableView registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellReuseIdentifier:@"RecommendCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.contentView.backgroundColor = [UIColor yellowColor];
        [self loadData];
    }
    return self;
}
/**获取网络数据*/
-(void)loadData{
    [HDManager startLoading];
    [TalentModel loadRecommendData:^(NSArray *banner, NSArray *array, NSError *error) {
        
        if(!error){
            
            self.adView.imageURLArray = banner;
            [self.dataArray addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        [HDManager stopLoading];
    }];
}
#pragma mark - UITableView协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"RecommendCell";
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.row = indexPath.row;
    cell.dataSource = self;
    cell.delegate = self;
    [cell.collectionView reloadData];
    switch (indexPath.row) {
        case 0:
            cell.nameL.text = @"掌厨达人";
            cell.icon.image = [UIImage imageNamed:@"达人"];
            break;
        case 1:
            cell.nameL.text = @"精选作品";
            cell.icon.image = [UIImage imageNamed:@"精品"];
            break;
        default:
        {
            //专题
            //取专题模型对象
            TopicModel *model = self.dataArray[indexPath.row];
            cell.nameL.text = model.topicName;
            cell.icon.image = [UIImage imageNamed:@"标签"];
        }
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark - RecommendCell 的协议方法

-(NSInteger)numberOfItemsAtRow:(NSInteger)row{
    
    switch (row) {
        case 0:
        case 1:
            //精选作品
        {
            NSArray *array = self.dataArray[row];
            return  array.count;
        }
            break;
        default:
            //专题
        {
            //取出专题对象
            TopicModel *topic = self.dataArray[row];
            return topic.data.count;
        }
            break;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndex:(NSInteger)index atRow:(NSInteger)row{
    NSString *cellID = nil;
    if(row == 0){
        cellID = @"TalentCell";
        //取出达人数组
        NSArray *array = self.dataArray[row];
        //取出达人模型对象
        TalentModel *talent = array[index];
        //创建、复用cell
        TalentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        //设置头像
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:talent.headImg] placeholderImage:[UIImage imageNamed:@"达人"]];
        cell.nickL.text = talent.nick;
        cell.fansL.text = [NSString stringWithFormat:@"粉丝:%@",talent.tongjiBeFollow];
        cell.fansL.textColor = TEXT_GRAYCOLOR;
        return cell;
        
    }else{
        cellID = @"TopicCell";
        TopicCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        if(row == 1){
          //精选作品
            NSArray *array = self.dataArray[row];
            MarrowModel *model = array[index];
            [cell.dishImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
        }else{
          //专题
            TopicModel *model = self.dataArray[row];
            //取出专题Data小模型
            TopicDataModel *data = model.data[index];
            //设置对应的图片
            [cell.dishImage sd_setImageWithURL:[NSURL URLWithString:data.image]];
        }
        return cell;
    }
}

-(CGSize)sizeForItemAtRow:(NSInteger)row{
    if(row == 0){
        
        return CGSizeMake(120, 140);
        
    }else{
        
        return CGSizeMake(150, 150);
    }
}

-(void)didSelectedTitleAtRow:(NSInteger)row{
    
    NSLog(@"点击 %ld 行的 标题部分",row);
    UIViewController *destinationViewController = nil;
    switch (row) {
        case 0:
            //达人列表
        {
            destinationViewController = [[TalentViewController alloc]init];
        }
            break;
            case 1://精选作品
        {
//           destinationViewController = [自己创建精选作品的VeiwController对象]
        }
            
            break;
        default:
            //所有专题
        {
            //           destinationViewController = [自己创建专题作品的VeiwController对象]
        }
        break;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(pushViewController:)]){
        [self.delegate pushViewController:destinationViewController];
    }
}
-(void)didSelectedItemInRow:(NSInteger)row atIndex:(NSInteger)index{
    
    NSLog(@"点击 %ld 行的 第 %ld 个item",row,index);
    UIViewController *destinationViewController = nil;
    switch (row) {
        case 0:
        {
            TalentViewController *desVC = [[TalentViewController alloc]init];
            //取出模型
            NSArray *array = self.dataArray[row];
            TalentModel *talent = array[index];
            desVC.nick = talent.nick;
            desVC.userId = talent.userId;//用去请求达人详情
            //用一个父类指针指向子类对象
            destinationViewController = desVC;
        }
            break;
        case 1:{
            //取精选作品的数据 给相应的 目标ViewController的必要属性赋值
        }
            break;
            
        default:
            //取专题相关的模型数据 给 目标viewController的必要属性赋值
            break;
    }
    if(self.delegate &&  [self.delegate respondsToSelector:@selector(pushViewController:)]){
        [self.delegate pushViewController:destinationViewController];
    }

}




@end
