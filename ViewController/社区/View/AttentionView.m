//
//  AttentionView.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "AttentionView.h"

@implementation AttentionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.contentView.backgroundColor = [UIColor cyanColor];
    }
    return self;
}
@end
