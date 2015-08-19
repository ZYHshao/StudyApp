//
//  YHSAHttpManager.h
//  StudyApp
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//继承与请求基类，直接进行扩展做上层封装，不用关心其内部的缓存和保护逻辑

#import "YHBaseHttpManager.h"
#import "YHSAHttpRequestDefine.h"
typedef void (^succseeBlock)(NSData * data);
typedef void (^failBlock) (YHBaseError * error);
@interface YHSAHttpManager : YHBaseHttpManager
/**
 *进行GET请求
 */
+(void)YHSARequestGET:(YHSARequestType)urlStr andDic:(NSDictionary *)dic Succsee:(succseeBlock)succsee  andFail:(failBlock)fail isbuffer:(BOOL)buffer;
/**
 *进行POST请求
 */
+(void)YHSARequestPost:(YHSARequestType)reType infoDic:(NSDictionary *)dic Succsee:(succseeBlock)succsee  andFail:(failBlock)fail isbuffer:(BOOL)buffer;
/**
 *获取缓存大小
 */
+(float)getCacheSize;
/**
 *清除缓存
 */
+(void)removeCache;
@end
