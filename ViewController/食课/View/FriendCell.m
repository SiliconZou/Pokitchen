//
//  FriendCell.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/30.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImage.layer.cornerRadius = 30;
    self.headImage.clipsToBounds = YES;
}

@end
