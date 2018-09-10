//
//  HYRequestTool.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYRequestTool.h"
static NSString * BASE_URL;
#define kTimeoutInterval 15
static HYRequestTool *_netWork = nil;
@interface HYRequestTool()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation HYRequestTool

+(id)Network{
    @synchronized(self) {
        if(_netWork == nil) {
            _netWork = [[HYRequestTool alloc] init];
        }
    }
    return _netWork;
    
}
-(instancetype)init{
    if (self=[super init]) {
        [self cheakNetworkStatus];
        [self initializeNetwork];
        [self initializeHUD];
    }
    return self;
}
- (void)initializeNetwork{
    self.manager = [[AFHTTPSessionManager alloc] init];
    self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    self.manager.requestSerializer.timeoutInterval = kTimeoutInterval;
    
    self.manager.securityPolicy.allowInvalidCertificates = YES;;
    self.manager.securityPolicy.validatesDomainName = NO;
}
/**
 post/get host为空使用默认的
 */
- (void)dataWithUrl:(NSString *)url Host:(NSString *)host param:(NSDictionary *)param method:(HYHTTPRequestMethod)method modelClassName:(Class)className onProgress:(void (^)(NSProgress * _Nonnull progress))onProgress isLoading:(BOOL)isLoading onComplete:(void (^)(NSDictionary *data))onComplete onFault:(void (^)(id error))onFault{
    if (url == nil){
        if (onComplete) {
            onComplete(nil);
        }
        if (onFault) {
            onFault(nil);
        }
        return;
    }
    NSString *newUrl = [NSString new];
    if (IS_EMPTY_STRING(host)) {
        newUrl = url;
    }else{
        newUrl  = [host stringByAppendingString:url];
    }
    if (!onComplete) {
        return;
    }
    if (isLoading) {
        [self showLoadingHUD];
    }
    
    
    if (method==HYHttpRequestMethodPost||method==HYHttpRequestMethodGet) {
       
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       
        
    }
    
    _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"Keep-Alive",@"connection", nil];
    
   
    
    NSDictionary *dic = [self configParameterWithDic:param];
    
    if (method== HYHttpRequestMethodPost) {
        [_manager POST:newUrl parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            if(onProgress){
                onProgress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (isLoading) {
                [self closeHUD];
            }
            NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *dic = [self dictionaryWithJsonString:receiveStr];
            DBLog(@"post请求地址%@ 数据%@",newUrl,dic);
            if (onComplete) {
                onComplete(dic);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (isLoading) {
                [self closeHUD];
            }
            if (onFault) {
                onFault(error);
            }
            
        }];
    }else{
        
        [_manager GET:newUrl parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            if(onProgress){
                onProgress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (isLoading) {
                [self closeHUD];
            }
            NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];

            NSDictionary *dic = [self dictionaryWithJsonString:receiveStr];
            DBLog(@"GET请求地址%@ 数据%@",newUrl,dic);
            if (onComplete) {
                onComplete(dic);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (isLoading) {
                [self closeHUD];
            }
            if (onFault) {
                onFault(error);
            }
            
        }];
    }
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

#pragma mark 参数封装
- (NSDictionary *)configParameterWithDic:(NSDictionary *)dic{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    if (dic) {
        [mDic setDictionary:dic];
    }
    //    [mDic setObject:kAPP_VERSION forKey:@"v"];
    
    NSMutableArray * mArr = [[NSMutableArray alloc] initWithArray:mDic.allKeys];
    for (int i = 0; i < mArr.count; i++) {
        for (int j = 0; j < mArr.count - i - 1;j++) {
            NSString *str1 = [mArr objectAtIndex:j];
            NSString *str2 = [mArr objectAtIndex:j+1];
            if ([str1 compare:str2 options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch]==NSOrderedDescending) {
                [mArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    return mDic;
}
#pragma mark HUD
- (void)initializeHUD{
    self.hud = [[MBProgressHUD alloc] init];
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.userInteractionEnabled = NO;
    self.hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:.6];
}
- (void)showLoadingHUD{
    self.hud.mode = MBProgressHUDModeIndeterminate;
    //self.hud.label.font = kNormalFontSize(15);
    self.hud.label.font = [UIFont systemFontOfSize:15];
    self.hud.label.text = @"加载中";
    //    self.hud.square = YES;
    self.hud.margin = 15;
    
    [self.hud showAnimated:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.hud];
    
}
- (void)closeHUD{
    [self.hud showAnimated:YES];
    [self.hud removeFromSuperview];
}

#pragma mark 网络状态
- (void)cheakNetworkStatus{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DBLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DBLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DBLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DBLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }] ;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
