//
//  RecommendCell.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicCell.h"
#import "TalentCell.h"

@class RecommendCell;
//不希望将数据源传递到RecommendCell中，多次引用数据源，固化视图能够显示的数据模型
@protocol RecommendCellDataSource <NSObject>

-(NSInteger)numberOfItemsAtRow:(NSInteger)row;

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndex:(NSInteger)index atRow:(NSInteger)row;

-(CGSize)sizeForItemAtRow:(NSInteger)row;

@end


@protocol RecommendCellDelegate<NSObject>

//选择cell的标题部分
-(void)didSelectedTitleAtRow:(NSInteger)row;
//选择cell的CollectionView中的cell
-(void)didSelectedItemInRow:(NSInteger)row atIndex:(NSInteger)index;

@end


@interface RecommendCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *nameL;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,weak) id <RecommendCellDataSource>dataSource;
@property(nonatomic,weak) id <RecommendCellDelegate> delegate;
@property(nonatomic,assign) NSInteger row;//记录cell所在的行

@end
