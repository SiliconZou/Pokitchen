//
//  NavTitleView.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/2.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "NavTitleView.h"

@interface NavTitleView (){
    
    CGFloat _leftSpace;
    CGFloat _btnW;
    CGFloat _btnH;
    
}
@property(nonatomic,strong) UIView *slider;  //滑动的小滑块

@end

@implementation NavTitleView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray{
    self = [super initWithFrame:frame];
    if (self) {
        _leftSpace = frame.origin.x;
        _btnH = 44;
        [self createBtnWithTitles:titleArray];
    }
    return self;
}

-(void)createBtnWithTitles:(NSArray *)titleArray{
    
    _btnW = (SCREEN_W - 2 * _leftSpace) / titleArray.count;
    NSInteger i = 0;
    for (NSString *title in titleArray) {
        CGFloat orginX = i * _btnW;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(orginX, 15, _btnW, 30)];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        //设置标题
        [button setTitle:title forState:UIControlStateNormal];
        //设置普通状态的标题颜色
        [button setTitleColor:TEXT_GRAYCOLOR forState:UIControlStateNormal];
        //设置选中状态的标题颜色
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(titleDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.tag = 200 + i;
        if(i == 1) {
            button.selected = YES;
            self.selectedIndex = 1;
        }
        i++;
    }
    _slider = [[UIView alloc]initWithFrame:CGRectMake(0, self.mj_h - 2, _btnW, 2)];
    _slider.backgroundColor = [UIColor orangeColor];
    [self addSubview:_slider];
    self.selectedIndex = 1;
}

-(void)titleDidClicked:(UIButton *)button{
    self.selectedIndex = button.tag - 200;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTitleAtIndex:)]) {
        [self.delegate didSelectedTitleAtIndex:self.selectedIndex];
    }
}

//选中某一个按钮 或者滑动到某一个按钮的位置(由外部引起)
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
    [UIView animateWithDuration:0.25 animations:^{
        //取出上一次选中的按钮 状态设置为普通状态
        UIButton *preBtn = (UIButton *)[self viewWithTag:200 + _selectedIndex];
        preBtn.selected = NO;
        
        //取出当前选中的按钮 并将状态设置为选中状态
        UIButton *button = (UIButton *)[self viewWithTag:200 + selectedIndex];
        button.selected = YES;
        _slider.mj_x = selectedIndex * _btnW;
    }];
    
    _selectedIndex = selectedIndex;
}

@end
