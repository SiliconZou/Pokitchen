//
//  RegistureViewController.m
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "RegistureViewController.h"
#import "NewUserViewController.h"

@interface RegistureViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *identifyField;
@property (weak, nonatomic) IBOutlet UIButton *identifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *PhoneCodeFied;
@property(nonatomic, copy) NSString * sessId;//获取图片验证码时的sessionId


@end

@implementation RegistureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackgroundImage.png"]];
    
    //获取图片验证码
    [self  updateIdentify:nil];

}
//获取图片验证码
- (IBAction)updateIdentify:(UIButton *)sender {
    
    //methodName=UserVerify&token=&user_id=&version=4.4
    NSDictionary *para = @{@"methodName":@"UserVerify",@"version":@"4.4"};
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        
        if(!error){
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *msg = dict[@"msg"];
            if([msg isEqualToString:@"success"]){
                //获取验证码成功
                NSString *urlStr = dict[@"data"][@"image"];
                //url中有 {  } 需要进行Unicode编码
                NSString * url = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
                [self.identifyBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
                self.sessId = dict[@"data"][@"sessid"];//保存供发送短信验证码接口使用
            }
        }
        
    }];

    
    
}
//发送短信验证码
- (IBAction)sendPhoneCode:(id)sender {
    
    //methodName=UserLogin&mobile=18515996749&sessid=%7B01f1b9bc-e990-c1b5-e201-1eed6909f821%7D&token=&user_id=&verify=Yxua&version=4.4
    NSDictionary *para = @{@"methodName":@"UserLogin",@"mobile":self.phoneField.text,@"sessid":self.sessId,@"verify":self.identifyField.text,@"version":@"4.4"};
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        if(!error){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *msg = dict[@"msg"];
            if([msg isEqualToString:@"success"]){
                
                NSString *showMsg = dict[@"data"][@"scalar"];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:showMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
                    
                }];
                [alert addAction:action];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }
            
        }
        
    }];
    
    
    
    
    
}

- (IBAction)backToPreView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nexStop:(id)sender {
    
    //code=197354&device_id=0819b83fb99&methodName=UserAuth&mobile=18515996749&token=&user_id=&version=4.4
    NSDictionary *para = @{@"code":self.PhoneCodeFied.text,@"methodName":@"UserAuth",@"mobile":self.phoneField.text,@"version":@"4.4"};
    [BaseRequest postWithURL:HOME_URL para:para callBack:^(NSData *data, NSError *error) {
        if(!error){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *msg = dict[@"msg"];
            NSLog(@"%@",dict);
            if([msg isEqualToString:@"success"]){
                
                NewUserViewController *userVC = [[NewUserViewController alloc]init];
                userVC.userId = dict[@"data"][@"user_id"];
                userVC.token = dict[@"data"][@"token"];
                NSNumber * exist = dict[@"data"][@"pwd_exist"];
                if([exist boolValue]){
                    NSLog(@"用户已经存在，不要在注册了");
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"注册成功，进入下一个界面设置密码和用户名");
                        [self.navigationController pushViewController:userVC animated:YES];
                    });
                }
            }else{
                NSLog(@"msg:%@",msg);
            }
        }else{
            NSLog(@"注册失败:%@",error.domain);
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
