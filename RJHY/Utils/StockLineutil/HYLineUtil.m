//
//  HYLineUtil.m
//  RJHY
//
//  Created by 王强 on 2018/7/30.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYLineUtil.h"

static HYLineUtil *_netWork = nil;

@implementation HYLineUtil

+(id)Network{
    
    @synchronized(self) {
        if(_netWork == nil) {
            _netWork = [[HYLineUtil alloc] init];
        }
    }
    return _netWork;
    
}

//日分图
-(void)getDayStockLIneInfo:(NSString*)code WithType:(LineType )type Success:(void(^)(NSArray  *listData))success{
    
    NSString *newCode = [code substringFromIndex:2];
    NSString *headCode = [newCode substringWithRange:NSMakeRange(0, 2)];
    
    NSString *stockTag;
    if ([headCode isEqualToString:@"90"]||[headCode isEqualToString:@"60"]) {
        stockTag = @"sse";
    }
    if ([headCode isEqualToString:@"00"]||[headCode isEqualToString:@"20"]||[headCode isEqualToString:@"30"]) {
        stockTag = @"szse";
    }
    NSString *theEndCode = [stockTag stringByAppendingString:newCode];
    
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    NSString *str = [NSString stringWithFormat:@"%li%li%li000000",(long)year,month,day];
    NSDictionary *dic = @{@"code":theEndCode,@"start":str,@"number":@6000};
   
    
    
   
    
    [self.manager GET:@"http://webstock.quote.hermes.hexun.com/a/minute" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *str1 = [receiveStr substringFromIndex:1];
        NSString *str2 = [str1 substringToIndex:str1.length-2];
        
        NSData *jsonData = [str2 dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        success(dic[@"Data"]);//空数组里套一个空数组
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

//K线图数据
-(void)getStockLIneInfo:(NSString*)code WithType:(LineType )type Success:(void(^)(NSArray   *listData))success{
    
    
    //http://192.168.2.200:8080/stock/dsfjk/dayKline/
    NSDictionary *Dic = @{@"stockCode":code};
    NSString *getUrl;
    switch (type) {
        case 0:
            getUrl = @"stock/dsfjk/dayKline";
            break;
        case 1:
            getUrl = @"stock/dsfjk/weekKline";
            break;
        case 2:
            getUrl = @"stock/dsfjk/monthKline";
            break;
            
        default:
            break;
    }
    
   
    NSString *str = [kAppURL stringByAppendingString:getUrl];

    [self.manager GET:str parameters:Dic progress:^(NSProgress * _Nonnull uploadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSData *jsonData = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        success(arr);
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
}
-(void)getStockWholeDetialInfoCode:(NSString*)code Success:(void(^)(NSString *str,NSArray *arr))success{
    NSString *newCode = [code substringFromIndex:2];
    NSString *headCode = [newCode substringWithRange:NSMakeRange(0, 2)];
    
    NSString *stockTag;
    if ([headCode isEqualToString:@"90"]||[headCode isEqualToString:@"60"]) {
        stockTag = @"sh";
    }
    if ([headCode isEqualToString:@"00"]||[headCode isEqualToString:@"20"]||[headCode isEqualToString:@"30"]) {
        stockTag = @"sz";
    }
    if ([headCode isEqualToString:@"sz"]||[headCode isEqualToString:@"sh"]) {
        stockTag = @"";
    }
    NSString *theEndCode = [stockTag stringByAppendingString:newCode];
    
    
    [self.manager GET:[@"http://qt.gtimg.cn/q=" stringByAppendingString:theEndCode] parameters:@{@"stockCode":theEndCode} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = [self replaceNoUtf8:responseObject];
        NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSArray *stockInfoArr ;
        
        if (receiveStr.length>200) {
            stockInfoArr = [receiveStr componentsSeparatedByString:@"~"];
            [self onStockDetialBackInfo:stockInfoArr];
        }
        success([self onStockDetialBackInfo:stockInfoArr],stockInfoArr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)getTimeDataInfoCode:(NSString*)code Success:(void(^)(HYNewStockDetailModel *model))success{
    [self.manager GET:[kAppURL stringByAppendingString:@"stock/getTimeData"] parameters:@{@"stockCode":code} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = [self replaceNoUtf8:responseObject];
        NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSData *jsonData = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        
         HYNewStockDetailModel *stock = [HYNewStockDetailModel mj_objectWithKeyValues:dict[@"stockDetail"]];
        success(stock);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

//获取时间
-(NSString *)onStockDetialBackInfo:(NSArray *)dataArr{
  //wq 时间有时是30个有时是29个。。。。
    NSString *dateStampStr = [dataArr objectAtIndexCheck:30];
    if (dateStampStr.length<10) {
        dateStampStr = [dataArr objectAtIndexCheck:29];
    }else if (dateStampStr.length>100) {
        dateStampStr = [dataArr objectAtIndexCheck:28];
    }
    
    NSString *yearStr =  [dateStampStr substringWithRange:NSMakeRange(0,4)];
    NSString *monthStr = [dateStampStr substringWithRange:NSMakeRange(4,2)];
    NSString *dayStr = [dateStampStr substringWithRange:NSMakeRange(6,2)];
    NSString *hourStr = [dateStampStr substringWithRange:NSMakeRange(8,2)];
    NSString *minuteStr = [dateStampStr substringWithRange:NSMakeRange(10,2)];
    NSString *secondStr = [dateStampStr substringWithRange:NSMakeRange(12,2)];
    //
    NSString *dateTimeStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",yearStr,monthStr,dayStr,hourStr,minuteStr,secondStr];
    return dateTimeStr;
   
    
}
//Data转UTF-8
- (NSData *)replaceNoUtf8:(NSData *)data
{
    char aa[] = {'A','A','A','A','A','A'};                      //utf8最多6个字符，当前方法未使用
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length])
    {
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0)
        {
            loc++;
            continue;
        }
        else if((buffer & 0xE0) == 0xC0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                continue;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else if((buffer & 0xF0) == 0xE0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80)
                {
                    loc++;
                    continue;
                }
                loc--;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else
        {
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
    }
    return md;
}

-(AFHTTPSessionManager *)manager{
    if (_manager==nil) {
        _manager = [[AFHTTPSessionManager alloc] init];
        _manager.requestSerializer=[AFJSONRequestSerializer serializer];
        
        _manager.securityPolicy.allowInvalidCertificates = YES;;
        _manager.securityPolicy.validatesDomainName = NO;
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"Keep-Alive",@"connection", nil];
        
        
    }
    return _manager;
}
@end
