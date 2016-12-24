//
//  NewUserViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "NewUserViewController.h"
#import "NSString+MD5.h"//MD5编码

@interface NewUserViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passField;

@property (weak, nonatomic) IBOutlet UITextField *passAginField;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;

@end

@implementation NewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackgroundImage.png"]];
}
- (IBAction)backToPreVewi:(id)sender {
   
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)newUserClicked:(id)sender {
    
    // methodName=UserPwd&nickname=%E5%A4%A9%E5%A4%A9&password=9f23c3eda1dc8b997f9e5bfb161ef505&token=A2C6B6BE68EB24428D598B299FD15DAC&user_id=1601836&version=4.4
    NSDictionary *para = @{@"methodName":@"UserPwd",@"nickname":self.userNameField.text,@"password":self.passField.text.MD5String,@"token":self.token,@"user_id":self.userId,@"version":@"4.4"};
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        if(!error){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSString *msg = dict[@"msg"];
            if([msg isEqualToString:@"success"]){
                //设置用户名和密码成功
                NSString *showMsg = dict[@"data"][@"scalar"];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:showMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击确定后返回登录界面
                    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
                }];
                [alert addAction:action];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //显示alertt
                    [self presentViewController:alert animated:YES completion:nil];
                    
                });
                
            }else
            {
                NSLog(@"msg:%@",msg);
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
