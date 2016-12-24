//
//  QFNormalHeader.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "QFNormalHeader.h"

@implementation QFNormalHeader

-(void)placeSubviews{
    
    [super placeSubviews];
    self.mj_y = - self.mj_h - self.ignoredScrollViewContentInsetTop - 80;

}

@end
