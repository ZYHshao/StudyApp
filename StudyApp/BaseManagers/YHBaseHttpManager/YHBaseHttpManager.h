//
//  YHBaseHttpManager.h
//  
//
//  Created by user on 15/8/18.
//
//http网络请求的管理基类

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "YHSingletonProcotol.h"
#import "YHBaseHttpRequestObject.h"
@interface YHBaseHttpManager : NSObject<YHSingletonProcotol>
/**
 *请求数据，用于存储正在进行的请求
 */
__PROPERTY_NO_STRONG__(NSMutableArray *, requestArray);
@end
