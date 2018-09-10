//
//  HYDBManager.m
//  RJHY
//
//  Created by 王强 on 2018/7/27.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYDBManager.h"

@implementation HYDBManager

+ (HYDBManager *)shareManager{
    
    static HYDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[HYDBManager alloc] init];
        }
    });
    return manager;
}

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/myApp.db"];
        //找到sqlist在本地的路径
        NSLog(@"%@",path);
        
        _fmdb = [[FMDatabase alloc] initWithPath:path];
        if ([_fmdb open]) {
            
            NSString *sql = @"create table if not exists limmit(applicationId varchar(32),name varchar(128),iconUrl varchar(1024))";
            
            //            NSString *sql1 = @"create table if not exists limmita(applicationId varchar(32),name varchar(128),iconUrl varchar(1024))";
            //            [_fmdb executeUpdate:sql1];
            
            if ([_fmdb executeUpdate:sql]) {
                
                NSLog(@"create table success");
                
            }
            
            
            NSLog(@"fmdb open success");
            
        }else{
            
            NSLog(@"fmdb open fail");
            
        }
        
        
    }
    return self;
}

#pragma mark - insert one data
- (BOOL)insertDataWithModel:(HYHomeStockModel *)model{
    
    [_lock lock];
    //insert into limmit (applicationId,name,iconUrl) values (?,?,?)
    
    NSString *sql = @"insert into limmit (applicationId,name,iconUrl) values (?,?,?)";
    NSLog(@"%@",model.name);
    BOOL isSuccess = [_fmdb executeUpdate:sql,model.symbol,model.high,model.low];
    NSLog(@"插入%@",model.name);
    [_lock unlock];
    
    return isSuccess;
}

- (BOOL)searchDataWithModel:(HYHomeStockModel *)model{
    
    //select applicationId from limmit where applicationId = ?
    NSString *sql = @"select applicationId from limmit where applicationId = ?";
    FMResultSet *set = [_fmdb executeQuery:sql,model.symbol];
    
    while ([set next]) {
        return YES;
    }
    
    return NO;
    
}

- (BOOL)deleteDataWithModel:(HYHomeStockModel *)model{
    
    [_lock lock];
    //delete from limmit where applicationId = ?
    NSString *sql = @"delete from limmit where applicationId = ?";
    BOOL isSuccess = [_fmdb executeUpdate:sql,model.symbol];
    [_lock unlock];
    
    return isSuccess;
}

//查询全部数据
- (NSArray *)allData{
    
    //select * from limmit
    NSString *sql = @"select * from limmit";
    FMResultSet *set = [_fmdb executeQuery:sql];
    //  [1,2,3,4,5,6,7,8,9]
    
    NSMutableArray *array = [NSMutableArray array];
    
    while ([set next]) {
        
        NSDictionary *dic = [set resultDictionary];
        
        HYHomeStockModel *model = [[HYHomeStockModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
    
}


@end
