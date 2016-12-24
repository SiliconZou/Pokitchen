//
//  TalentCell.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "TalentCell.h"

@implementation TalentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImage.layer.cornerRadius = 30;
    self.headImage.clipsToBounds = YES;
}

@end
