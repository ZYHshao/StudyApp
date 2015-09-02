//
//  YHSAHttpRequestDefine.h
//  StudyApp
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#ifndef StudyApp_YHSAHttpRequestDefine_h
#define StudyApp_YHSAHttpRequestDefine_h

typedef enum {
    YHSARequestTypeRegist,
    YHSARequestTypelogin,
    YHSARequestTypeReFoundSecret,
    YHSARequestTypeMockExamListFirst,
    YHSARequestTypeMockExamDetails,
    YHSARequestTypeMockExamQuestion,
    YHSARequestTypeOptionsPost,
    YHSARequestTypeExamInfo,
    YHSARequestTypeExamInfoDetail,
    YHSARequestTypeExamPost
}YHSARequestType;
//=========================测试地址=============================//
#ifdef TEXT

#define YHSA_REGIST_INTERFACE_POST_PATH @"http://app.vipexam.org/reg.htm"
#define YHSA_LOGIN_INTERFACE_POST_PATH @"http://app.vipexam.org/login.htm"

#else
//==========================正式地址============================//
#define YHSA_REGIST_INTERFACE_POST_PATH @"http://app.vipexam.org/interface/UserReg.ashx"
#define YHSA_LOGIN_INTERFACE_POST_PATH @"http://app.vipexam.org/interface/login.ashx"
#define YHSA_REFOUND_SECRET_INTERFACE_POST_PATH @"http://app.vipexam.org/interface/modify.ashx"
#define YHSA_MOCKEXAM_LIST_FIRST_POST_PATH @"http://app.vipexam.org/interface/Typelist.ashx"
#define YHSA_MOCKEXAM_DETAILS_POST_PATH @"http://app.vipexam.org/interface/Examinfo.ashx"
#define YHSA_MOCKEXAM_QUESTION_POST_PATH @"http://app.vipexam.org/interface/Examlist.ashx"
#define YHSA_OPTIONS_POST_PATH @"http://app.vipexam.org/interface/Advice.ashx"
#define YHSA_EXAM_INFO_LIST_POST_PATH @"http://app.vipexam.org/interface/message.ashx"
#define YHSA_EXAM_INFO_DETAIL_POST_PATH @"http://app.vipexam.org/interface/message.ashx"
#define YHSA_EXAM_POST_PATH @"http://app.vipexam.org/interface/submitExam.ashx"
#endif

//==========================请求id的定义========================//
#define YHSA_REQUEST_TYPE_REGIST  @"1"
#define YHSA_REQUEST_TYPE_LOGIN @"2"
#define YHSA_REQUEST_TYPE_REFOUNDSECRET @"3"
#define YHSA_REQUEST_TYPE_MOCKEXAM @"4"
#define YHSA_REQUEST_TYPE_MOCKEXAM_DETAILS @"5"
#define YHSA_REQUEST_TYPE_MOCKEXAM_QUESTION @"6"
#define YHSA_REQUEST_TYPE_OPTIONS_POST @"7"
#define YHSA_REQUEST_TYPE_EXAM_INFO @"8"
#define YHSA_REQUEST_TYPE_EXAM_INFO_DETAIL @"9"
#define YHSA_REQUEST_TYPE_EXAM_POST @"10"
#endif
