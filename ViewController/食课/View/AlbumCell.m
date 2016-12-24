//
//  AlbumCell.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.albumLogo.layer.cornerRadius = 30;
    //从layer层上裁剪边界
    self.albumLogo.layer.masksToBounds = YES;
    
}

@end
