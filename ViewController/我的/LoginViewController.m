//
//  LoginViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistureViewController.h"

#import "NSString+MD5.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userField;

@property (weak, nonatomic) IBOutlet UITextField *passField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackgroundImage.png"]];
}
- (IBAction)backToPreView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registure:(id)sender {
    
    RegistureViewController *regVC = [[RegistureViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
    
}
- (IBAction)loginUser:(id)sender {
    
    //methodName=UserSignin&mobile=18515996749&password=c543bdde17c6bb115b84324ff80aaa70&token=&user_id=&version=4.4
    NSDictionary *para = @{@"methodName":@"UserSignin",@"mobile":self.userField.text,@"password":self.passField.text.MD5String,@"version":@"4.4"};
    
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        if(!error){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *msg = dict[@"msg"];
            if([msg isEqualToString:@"success"]){
                
                UserModel *user = [UserModel shareUser];
                user.isLogin = YES;
                user.userId = dict[@"data"][@"user_id"];
                user.nickname = dict[@"data"][@"nickname"];
                user.token = dict[@"data"][@"token"];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                NSLog(@"登录失败：%@",msg);
            }
            
        }else{
            NSLog(@"请求失败:%@",error.domain);
        }
    }];
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
