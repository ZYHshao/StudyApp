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
        case YHSARequestTypeOptionsPost:
        {
            return YHSA_OPTIONS_POST_PATH;
        }
            break;
        case YHSARequestTypeExamInfo:
        {
            return YHSA_EXAM_INFO_LIST_POST_PATH;
        }
            break;
        case YHSARequestTypeExamInfoDetail:
        {
            return YHSA_EXAM_INFO_DETAIL_POST_PATH;
        }
            break;
        case YHSARequestTypeExamPost:
        {
            return YHSA_EXAM_POST_PATH;
        }
            break;
        case YHSARequestTypeGetStudyNote:
        {
            return YHSA_GET_STUDY_NOTE_POST_PATH;
        }
            break;
        case YHSARequestTypeAddStudyNote:
        {
            return YHSA_ADD_STUDT_NOTE_POST_PATH;
        }
            break;
        case YHSARequestTypeEditStudyNote:
        {
            return YHSA_EDIT_STUDT_NOTE_POST_PATH;
        }
            break;
        case YHSARequestTypeDeleteStudyNote:
        {
            return YHSA_DELETE_STUDT_NOTE_POST_PATH;
        }
            break;
        case YHSARequestTypeDetailsStudyNote:
        {
            return YHSA_DETAILS_STUDT_NOTE_POST_PATH;
        }
            break;
        case YHSARequestTypeStudyPlanList:
        {
            return YHSA_STUDY_PLAN_LIST_POST_PATH;
        }
            break;
        case YHSARequestTypeStudyPlanDetails:
        {
            return YHSA_STUDY_PLAN_DETAILS_POST_PATH;
        }
            break;
        case YHSARequestTypeStudyPlanAdd:
        {
            return YHSA_STUDY_PLAN_ADD_POST_PATH;
        }
            break;
        case YHSARequestTypeAchievementAnalyse:
        {
            return YHSA_Achievement_ANALYSE_POST_PATH;
        }
            break;
        case YHSARequestTypeReportCard:
        {
            return YHSA_REPORT_CARD_POST_PATH;
        }
            break;
        case YHSARequestTypeWrongRecord:
        {
            return YHSA_WRONG_RECORD_POST_PATH;
        }
            break;
        case YHSARequestTypeWrongRecordQuestion:
        {
            return YHSA_WRONG_RECORD_QUESTION_POST_PATH;
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
        case YHSARequestTypeOptionsPost:
        {
            return YHSA_REQUEST_TYPE_OPTIONS_POST;
        }
            break;
        case YHSARequestTypeExamInfo:
        {
            return YHSA_REQUEST_TYPE_EXAM_INFO;
        }
            break;
        case YHSARequestTypeExamInfoDetail:
        {
            return YHSA_REQUEST_TYPE_EXAM_INFO_DETAIL;
        }
            break;
        case YHSARequestTypeExamPost:
        {
            return YHSA_REQUEST_TYPE_EXAM_POST;
        }
            break;
        case YHSARequestTypeGetStudyNote:
        {
            return YHSA_REQUEST_TYPE_GET_STUDY_NOTE_POST;
        }
            break;
        case YHSARequestTypeAddStudyNote:
        {
            return YHSA_REQUEST_TYPE_ADD_STUDY_NOTE_POST;
        }
            break;
        case YHSARequestTypeEditStudyNote:
        {
            return YHSA_REQUEST_TYPE_EDIT_STUDY_NOTE_POST;
        }
            break;
        case YHSARequestTypeDeleteStudyNote:
        {
            return YHSA_REQUEST_TYPE_DELETE_STUDY_NOTE_POST;
        }
            break;
        case YHSARequestTypeDetailsStudyNote:
        {
            return YHSA_REQUEST_TYPE_DETAILS_STUDY_NOTE_POST;
        }
            break;
        case YHSARequestTypeStudyPlanList:
        {
            return YHSA_REQUEST_TYPE_STUDY_PLAN_LIST;
        }
            break;
        case YHSARequestTypeStudyPlanDetails:
        {
            return YHSA_REQUEST_TYPE_STUDY_PLAN_DETAILS;
        }
            break;
        case YHSARequestTypeStudyPlanAdd:
        {
            return YHSA_REQUEST_TYPE_STUDY_PLAN_ADD;
        }
            break;
        case YHSARequestTypeAchievementAnalyse:
        {
            return YHSA_REQUEST_TYPE_ACHIEVEMENT_ANALYSE;
        }
            break;
        case YHSARequestTypeReportCard:
        {
            return YHSA_REQUEST_TYPE_REPORT_CARD;
        }
            break;
        case YHSARequestTypeWrongRecord:
        {
            return YHSA_REQUEST_TYPE_WRONG_RECORD;
        }
            break;
        case YHSARequestTypeWrongRecordQuestion:
        {
            return YHSA_REQUEST_TYPE_WRONG_RECORD_QUESTION;
        }
            break;
        default:
            return @"";
            break;
    }
}


@end
