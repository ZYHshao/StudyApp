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
    } requestField:^(YHBaseError *error) {
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
    } requestField:^(YHBaseError *error) {
        fail(error);
    } isCeche:buffer toCechePath:YHBaseCecheMain];
}

+(float)getCacheSize{
    return [[YHBaseCecheCenter sharedTheSingletion] getSizeFromCachePath:YHBaseCecheMain];
}
+(void)removeCache{
    [[YHBaseCecheCenter sharedTheSingletion] removeCacheFromPath:YHBaseCecheMain];
}

+(NSString *)getUrlString:(YHSARequestType)type{
    switch (type) {
        case YHSARequestTypeRegist:
        {
            return YHSA_REGIST_INTERFACE_POST_PATH;
        }
            break;
        case YHSARequestTypelogin:
        {
            return YHSA_LOGIN_INTERFACE_POST_PATH;
        }
            break;
        case YHSARequestTypeReFoundSecret:
        {
            return YHSA_REFOUND_SECRET_INTERFACE_POST_PATH;
        }
            break;
        case YHSARequestTypeMockExamListFirst:
        {
            return YHSA_MOCKEXAM_LIST_FIRST_POST_PATH;
        }
            break;
        case YHSARequestTypeMockExamDetails:
        {
            return YHSA_MOCKEXAM_DETAILS_POST_PATH;
        }
            break;
        case YHSARequestTypeMockExamQuestion:
        {
            return YHSA_MOCKEXAM_QUESTION_POST_PATH;
        }
            break;
        default:
            return @"";
            break;
    }
}
+(NSString *)getRegistID:(YHSARequestType)type{
    switch (type) {
        case YHSARequestTypeRegist:
        {
            return YHSA_REQUEST_TYPE_REGIST;
        }
            break;
        case YHSARequestTypelogin:
        {
            return YHSA_REQUEST_TYPE_LOGIN;
        }
            break;
        case YHSARequestTypeReFoundSecret:
        {
            return YHSA_REQUEST_TYPE_REFOUNDSECRET;
        }
            break;
        case YHSARequestTypeMockExamListFirst:
        {
            return YHSA_REQUEST_TYPE_MOCKEXAM;
        }
            break;
        case YHSARequestTypeMockExamDetails:
        {
            return YHSA_REQUEST_TYPE_MOCKEXAM_DETAILS;
        }
            break;
        case YHSARequestTypeMockExamQuestion:
        {
            return YHSA_REQUEST_TYPE_MOCKEXAM_QUESTION;
        }
            break;
        default:
            return @"";
            break;
    }
}


@end
