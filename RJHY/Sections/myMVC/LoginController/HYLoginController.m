//
//  HYLoginController.m
//  RJHY
//
//  Created by 王强 on 2018/7/27.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYLoginController.h"
#import "HYMyController.h"

@interface HYLoginController ()
@property(nonatomic,strong)UITextField *usernameTf;
@property(nonatomic,strong)UITextField *passWordTf;

@end

@implementation HYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createUI{
    _usernameTf = [[UITextField alloc] init];
    [self.view addSubview:_usernameTf];
    [_usernameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.offset(50);
    }];
    _usernameTf.placeholder = @"请输入账号";
    
    _passWordTf = [[UITextField alloc] init];
    [self.view addSubview:_passWordTf];
    [_passWordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTf.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.offset(50);
    }];
    _passWordTf.placeholder = @"请输入密码";
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.usernameTf);
        make.top.equalTo(self.passWordTf.mas_bottom).offset(10);
    }];
    label.text = @"保持在线 180分钟";
    
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.usernameTf);
        make.top.equalTo(label.mas_bottom).offset(10);
        make.height.offset(50);
    }];
    [btn setBackgroundColor:kGreen_Color];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setTitleColor:kWhite_Color forState:UIControlStateNormal];
    
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (self.usernameTf.text.length==0) {
            [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"请输入账户"];
            return;
        }if (self.passWordTf.text.length==0) {
            [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionCenten title:@"请输入密码"];
            return;
        }
        
        NSDictionary *dic =@{@"username":self.usernameTf.text,@"password":self.passWordTf.text};
        [[HYLoginUtil new] LoginWithUserInfo:dic Success:^(NSDictionary *listData) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                HYMyController *vc = [HYMyController new];
                
                [MBProgressHUD showCustomView:[[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                       toView:vc.view
                                        title:@"登录成功"];
               
                
            }];
           
        } Fail:^(id err) {
            
        }];
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
