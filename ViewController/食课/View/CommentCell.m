//
//  CommentCell.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImage.layer.cornerRadius = 30;
    self.headImage.clipsToBounds = YES;
    
    self.timeL.textColor = TEXT_GRAYCOLOR;
    self.contentL.textColor = TEXT_GRAYCOLOR;
    self.nickL.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
