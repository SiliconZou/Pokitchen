//
//  DishClassCell.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "DishClassCell.h"

@implementation DishClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //Xib加载完成以后调用的方法，可以在这里进行默认属性的设置
    self.contentView.backgroundColor = GRAY_COLOR;
    //将图片切成圆形
    self.albumLogo.layer.cornerRadius = self.albumLogo.frame.size.height / 2;
    //裁剪边界
    self.albumLogo.clipsToBounds = YES;
    
    self.nameL.font = [UIFont systemFontOfSize:18];
    self.nameL.textColor = [UIColor blackColor];
    
    
    self.updateL.textColor = TEXT_GRAYCOLOR;
    self.numL.textColor = TEXT_GRAYCOLOR;
    self.albumL.textColor = TEXT_GRAYCOLOR;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
