//
//  StringHead.h
//  StudyApp
//
//  Created by user on 15/8/17.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#ifndef StudyApp_StringHead_h
#define StudyApp_StringHead_h

//=============================公用组件=========================//
//alertView
#define PUBLIC_PART_ALERT_TITLE @"温馨提示"
#define PUBLIC_PART_ALERT_CANCLE_BTN @"取消"
#define PUBLIC_PART_ALERT_SELECT_BTN @"确定"


//=============================引导界面=========================//
#define LOADER_REGIST_BUTTON_TEXT @"免费注册"
#define LOADER_NEXT_BUTTON_TEXT @"跳过"
#define LOADER_LOGIN_BUTTON_TEXT @"已有账号，立即登录"

//=============================登陆界面=========================//
#define LOGIN_CONTROLLER_TITLE @"登陆"
#define LOGIN_USERNAME_LABEL @"通行证:"
#define LOGIN_USERNAME_TEXTFIELD_PlACEHOLDER_TEXT @"请输入您的通行证:"
#define LOGIN_SECERT_LABEL @"密码:"
#define LOGIN_SECRET_TEXTFIELD_PLACEHOLDER_TEXT @"请输入您的密码:"
#define LOGIN_SHOULD_AUTO_MEMORY_TEXT @"记住密码"
#define LOGIN_BTN_TEXT @"登陆"
#define LOGIN_REGIST_BTN_TEXT @"立即注册"
#define LOGIN_REFIND_SECERT_TEXT @"找回密码"
//==============================注册界面========================//
#define REGIST_CONTROLLER_TITLE @"注册"
#define REGIST_SCHOOL_TEXT @"所在院校:"
#define REGIST_SCHOOL_FIELD_PLACEHOLDER_TEXT @"请选择您的所在院校"
#define REGIST_PHONE_TEXT @"手机号码:"
#define REGIST_PHONE_FIELD_PLACEHOLDER_TEXT @"请输入您的手机号码"
#define REGIST_SECERT_TEXT @"设定密码:"
#define REGIST_SRCERT_FIELD_PLACEHOLDER_TEXT @"请输入您的密码"
#define REGIST_SECERT_REWRITE_TEXT @"重复密码:"
#define REGIST_SECERT_REWRITE_FIELD_PLACEHOLDER_TEXT @"请再次输入您的密码"
#define REGIST_QUESTION_TEXT @"密码提示问题:"
#define REGIST_QUESTION_FIELD_PLACEHOLDER_TEXT @"请选择您的提示问题"
#define REGIST_ANSWER_TEXT @"提示问题答案:"
#define REGIST_ANSWER_FIELD_PLACEHOLDER_TEXT @"请输入您的提示问题答案"
#define REGIST_BUTTON_TEXT @"注册"
//===============================主工具界面=======================//
#define MAIN_CONTROLLER_TITLE @"VIPExam考试库"
#define MAIN_MYTEXT_TEXT @"模拟自测"
#define MAIN_WRONG_NOTES_TEXT @"错题记录"
#define MAIN_WRONG_TEXT_TEXT @"错题组卷"
#define MAIN_MY_COLLECT_TEXT @"我的收藏"
#define MAIN_MY_ANALYSE_TEXT @"成绩分析"
#define MAIN_STUDY_PIAN_TEXT @"学习计划"
#define MAIN_MY_NOTES_TEXT @"我的笔记"
#define MAIN_TEXT_INFOMATION_TEXT @"开始咨询"
#define MAIN_SYSTEMSET_TEXT @"系统设置"

//=============================接口字段==========================//
//注册
#define INTERFACE_FIELD_REGIST_COLLEAGE @"college"
#define INTERFACE_FIELD_REGIST_PHONECODE @"phonecode"
#define INTERFACE_FIELD_REGIST_PASSWORD @"password"
#define INTERFACE_FIELD_REGIST_QUESTION @"question"
#define INTERFACE_FIELD_REGIST_ANSWER @"answer"

//登陆
#define INTERFACE_FIELD_LOGIN_PHONECODE @"phonecode"
#define INTERFACE_FIELD_LOGIN_PASSWORD @"password"
//============================接口返回字段========================//

#define INTERFACE_RETURN_REGIST_SUCCESS @"8"
#define INTERFACE_RETURN_REGIST_FAILED @"2"

#define INTERFACE_RETURN_LOGIN_SUCCESS @"8"
#define INTERFACE_RETURN_LOGIN_FAILED @"2"




#endif
