//
//  HYMyController.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYMyController.h"
#import "HYLoginUtil.h"

@interface HYMyController ()


@end

@implementation HYMyController{
    NSMutableArray *_myList;
    NSMutableArray *_imageArr;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self configData];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.myTb];
}

-(void)configData{
    
    _myList = [NSMutableArray arrayWithObjects:@"用户名",@"身份认证",@"我的资产",@"订单管理",@"安全中心",@"关于我们",@"退出登录", nil];
    _imageArr = [NSMutableArray arrayWithObjects:@"account_default_big_logo",
                 @"account_user_center_image",
                 @"account_balance_image",//我的资产
                 @"account_order_manager_image",//订单管理
                 @"account_security_center_image",
                 @"account_about_image",//关于我们
                 @"account_about_image", nil];
    
    
    if ([HYUserInfoManager sharedUserInfo].userid.length>0) {
        [_myList replaceObjectAtIndex:0 withObject:[HYUserInfoManager sharedUserInfo].nickName];
    }else{
        [_myList removeLastObject];
        [_imageArr removeLastObject];
        
    }
    [self.myTb reloadData];
}
#pragma mark====delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _myList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYBaseCell *cell;
    if (indexPath.row ==0) {
        cell = [[HYBaseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ceed"];
        cell.textLabel.font = [UIFont systemFontOfSize:30];
        cell.detailTextLabel.text = @"欢迎来到国臣在线";
        
    }else{
         cell = [[HYBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ceed"];
    }
    
    if (cell==nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ceed"];
    }
    cell.imageView.image = imgStr(_imageArr[indexPath.row]);
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _myList[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 100;
    }else
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DBLog(@"点解了%li",(long)indexPath.row);
    if ([HYUserInfoManager sharedUserInfo].nickName.length>0) {
        if (indexPath.row==_myList.count-1) {
            //TodoLoginOut
            [[HYUserInfoManager sharedUserInfo] logout];
            [self configData];
            
        }
    }else{
        if (indexPath.row==0) {
            //GOTOLoginView
            HYLoginController *vc = [HYLoginController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self presentViewController:vc animated:YES completion:nil];
            //[self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark===lazy
-(HYBaseTableView *)myTb{
    if (_myTb==nil) {
        _myTb = [[HYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, self.view.height) style:UITableViewStyleGrouped];
        _myTb.delegate = self;
        _myTb.dataSource = self;
        
        [self.view addSubview:_myTb];
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:_myTb.frame];
        [backImageView setImage:[UIImage imageNamed:@"account_bg_image"]];
        _myTb.backgroundView=backImageView;
    }
    return _myTb;
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
