//
//  YHSAHttpManager.m
//  StudyApp
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAHttpManager.h"

@implementation YHSAHttpManager

+(void)YHSARequestGET:(YHSARequestType)reType andDic:(NSDictionary *)dic Succsee:(succseeBlock)succsee andFail:(failBlock)fail isbuffer:(BOOL)buffer{
    //创建请求对象
    YHBaseHttpRequestObject * obj = [[YHBaseHttpRequestObject alloc]init];
    //相关设置
    obj.urlString = [YHSAHttpManager getUrlString:reType];
    obj.requestIdentity = [YHSAHttpManager getRegistID:reType];
    obj.pramaDic = dic;
    [[YHSAHttpManager sharedTheSingletion] YHBaseHttpRequestGETFromRequestObject:obj requestSuccess:^(NSData *data) {
        succsee(data);
    } requestField:^(NSError *error) {
        fail(error);
    } isCeche:buffer toCechePath:YHBaseCecheMain];
}

+(void)YHSARequestPost:(YHSARequestType)reType infoDic:(NSDictionary *)dic Succsee:(succseeBlock)succsee andFail:(failBlock)fail isbuffer:(BOOL)buffer{
    //创建请求对象
    YHBaseHttpRequestObject * obj = [[YHBaseHttpRequestObject alloc]init];
    //相关设置
    obj.urlString = [YHSAHttpManager getUrlString:reType];
    obj.requestIdentity = [YHSAHttpManager getRegistID:reType];
    obj.pramaDic = dic;
    [[YHSAHttpManager sharedTheSingletion]YHBaseHttpRequestPOSTFromRequestObject:obj withParamDictionary:dic requestSuccess:^(NSData *data) {
        succsee(data);
    } requestField:^(NSError *error) {
        fail(error);
    } isCeche:buffer toCechePath:YHBaseCecheMain];
}



+(NSString *)getUrlString:(YHSARequestType)type{
    switch (type) {
        case YHSARequestTypeRegist:
            return YHSA_REGIST_INTERFACE_POST_PATH;
            break;
            
        default:
            break;
    }
}
+(NSString *)getRegistID:(YHSARequestType)type{
    return nil;
}
@end
