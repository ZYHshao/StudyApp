//
//  YHSAErrorCenter.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHSAErrorCenter.h"

@implementation YHSAErrorCenter

//重写处理异常的方法
-(void)handleToError:(YHBaseError *)error{
    switch (error.errorType) {
        case YHBaseErrorRequestFromHost:
        {
            //统一做服务器异常的处理
        }
            break;
        case YHBaseErrorRequestLocal:
        {
            //统一做本地网络异常的处理
        }
            break;
        default:
            break;
    }
}

@end
