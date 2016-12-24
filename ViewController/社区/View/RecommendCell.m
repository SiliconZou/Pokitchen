//
//  RecommendCell.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "RecommendCell.h"


@implementation RecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = GRAY_COLOR;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellWithReuseIdentifier:@"TopicCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TalentCell" bundle:nil] forCellWithReuseIdentifier:@"TalentCell"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //给cell的标题部分添加点击手势
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClicked:)];
    
    [self.icon.superview addGestureRecognizer:gesture];
    
}
-(void)titleClicked:(UITapGestureRecognizer *)gesture
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTitleAtRow:)]){
        
        [self.delegate didSelectedTitleAtRow:self.row];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}


#pragma mark- UICollectionView 协议方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(!self.dataSource){
        return 0;
    }
    return [self.dataSource numberOfItemsAtRow:self.row];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.dataSource){
        return [[UICollectionViewCell alloc]init];
    }
    return [self.dataSource collectionView:self.collectionView cellForItemAtIndex:indexPath.item atRow:self.row];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.dataSource == nil){
        return CGSizeZero;
    }
    return [self.dataSource sizeForItemAtRow:self.row];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedItemInRow:atIndex:)]){
        [self.delegate didSelectedItemInRow:self.row atIndex:indexPath.item];
    }
}



@end
