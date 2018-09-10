//
//  HYDBManager.h
//  RJHY
//
//  Created by 王强 on 2018/7/27.
//  Copyright © 2018年 王强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "FMDatabase.h"
#import "HYHomeStockModel.h"

@interface HYDBManager : NSObject{
    
    FMDatabase *_fmdb;
    //锁
    NSLock *_lock;
}

+ (HYDBManager *)shareManager;

//insert one data
- (BOOL)insertDataWithModel:(HYHomeStockModel *)model;

//search data (one)查找一条数据
- (BOOL)searchDataWithModel:(HYHomeStockModel *)model;

//删除
- (BOOL)deleteDataWithModel:(HYHomeStockModel *)model;

//查询全部数据
- (NSArray *)allData;

@end
