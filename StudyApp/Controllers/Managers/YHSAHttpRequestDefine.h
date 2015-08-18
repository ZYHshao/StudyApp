//
//  YHSAHttpRequestDefine.h
//  StudyApp
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#ifndef StudyApp_YHSAHttpRequestDefine_h
#define StudyApp_YHSAHttpRequestDefine_h
#define TEXT
typedef enum {
    YHSARequestTypeRegist
}YHSARequestType;
//=========================测试地址=============================//
#ifdef TEXT

#define YHSA_REGIST_INTERFACE_POST_PATH @"http://app.vipexam.org/interface/UserReg.ashx"

#else
//==========================正式地址============================//
#define YHSA_REGIST_INTERFACE_POST_PATH @"YHAS_REGIST_INTERFACE_POST_PATH"


#endif

//==========================请求id的定义========================//
#define YHSA_REQUEST_TYPE_REGIST  @"1"

#endif
