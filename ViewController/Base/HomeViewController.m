//
//  HomeViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "HomeViewController.h"
#import "RecipeViewController.h"
#import "LikeViewController.h"
#import "CommunityViewController.h"
#import "DishClassViewController.h"
#import "MineViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
    
}

-(void)createViewControllers
{
    RecipeViewController *recipe = [[RecipeViewController alloc]init];
    
    LikeViewController *like = [[LikeViewController alloc]init];
    
    CommunityViewController *communty = [[CommunityViewController alloc]init];
    
    DishClassViewController * dish = [[DishClassViewController alloc]init];
    
    MineViewController *mine = [[MineViewController alloc]init];
    NSArray *vcArray = @[recipe,like,communty,dish,mine];
    NSArray *titleArray = @[@"食谱",@"喜欢",@"社区",@"食课",@"我的"];
    NSMutableArray *viewControllers = [[NSMutableArray alloc]init];
    NSInteger i = 0;//控制循环
    for(BaseViewController *vc in vcArray){
        //创建导航控制器
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        //取出对应的标题
        NSString *title = titleArray[i];
        
        //非选中效果的图片 并且设置总是显示原色
        UIImage *image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@A",title]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //选中效果的图片 并且设置总是显示原色
        UIImage *imageS = [[UIImage imageNamed:[NSString stringWithFormat:@"%@B",title]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //创建tabBarItem
        UITabBarItem *tabItem = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:imageS];
        //设置图片的位置，注意上和下 应该设置为一对相反数
        tabItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        //设置选中状态的文字颜色
        [tabItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
        //设置普通状体的标题颜色
        [tabItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]} forState:UIControlStateNormal];
        
        //给导航控制器设置tabBarItem
        nav.tabBarItem = tabItem;
        [viewControllers addObject:nav];
        i++;
    }
    
    self.viewControllers = viewControllers;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
