//
//  MineViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UIImageView *headView;

@property (nonatomic, strong) UILabel *nickL;

@end

@implementation MineViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Mine" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        [_dataArray addObjectsFromArray:array];
    }
    return  _dataArray;
}
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.headView;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return  _tableView;
}
-(UIView *)headView
{
    if (!_headView){
        _headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 240)];
        _headView.image = [UIImage imageNamed:@"mine2.jpg"];
        _headView.userInteractionEnabled = YES;
        
        UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W - 50, 35, 30, 30)];
        [setBtn setImage:[UIImage imageNamed:@"configure"] forState:UIControlStateNormal];
        [setBtn setImage:[UIImage imageNamed:@"configure"] forState:UIControlStateHighlighted];
        [setBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_headView addSubview:setBtn];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, _headView.frame.size.height - 100, SCREEN_W, 100)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        CGFloat imageH = 70;
        
        [_headView addSubview:backView];
        
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, backView.frame.origin.y - imageH / 2, imageH, imageH)];
        _headImage.image = [UIImage imageNamed:@"userHeadImage"];
        [_headView addSubview:_headImage];
        _nickL = [[UILabel alloc]initWithFrame:CGRectMake(imageH / 2, imageH + self.headImage.mj_y + 10, SCREEN_W - imageH, 30)];
        _nickL.textColor = [UIColor whiteColor];
        _nickL.text = @"每个吃货都是有头脸的，登录";
        _nickL.font = [UIFont systemFontOfSize:15];
        [_headView addSubview:_nickL];
    }
    return _headView;
}
-(void)buttonClicked:(UIButton *)button{
    
    LoginViewController *login = [[LoginViewController alloc]init];
    login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:login animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UserModel *user = [UserModel shareUser];
    if(user.isLogin){
        self.nickL.text = user.nickname;
    }else{
        self.nickL.text = @"每个吃货都是有头脸的，登录";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tableView.tableHeaderView = self.headView;
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableView 协议方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = self.dataArray[section];
    return  array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *array = self.dataArray[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    if(indexPath.section == 1 && indexPath.row == 1){
     UIImageView *hotImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W - 100, 0, 75, 50)];
        hotImage.image = [UIImage imageNamed:@"hotpack.jpg"];
        [cell.contentView addSubview:hotImage];
    }
    if (indexPath.section == 2&& indexPath.row == 0){
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = @"登录后可查看视频";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 1)];
    view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 5)];
    view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    return view;
}
@end
