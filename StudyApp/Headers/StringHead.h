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
#define MAIN_TEXT_INFOMATION_TEXT @"考试资讯"
#define MAIN_SYSTEMSET_TEXT @"系统设置"


//================================密码找回界面=====================//
#define REFOUND_CONTROLLER_TITLE @"找回密码"
#define REFOUND_PHONE_TEXT @"您的手机号:"
#define REFOUND_PHONR_TEXT_FIELD_PLACEHOLDER_TEXT @"请输入您的手机号"
#define REFOUND_QUESTION_TEXT @"密码提示问题:"
#define REFOUND_QUESTION_TEXT_FIELD_PLACEHOLDER_TEXT @"请输入您的密码提示问题"
#define REFOUND_ANSWER_TEXT @"提示问题答案:" 
#define REFOUND_ANSWER_TEXT_FIELD_PLACEHOLDER_TEXT @"请输入您的提示问题答案"
#define REFOUND_NEWSECRET_TEXT @"设定您的新密码:"
#define REFOUND_NEWSECRET_TEXT_FIELD_PLACEHOLDER_TEXT @"请输入您的新密码"
#define REFOUND_COMMIT_BUTTON_TITLE @"提 交"



//===============================模拟考试界面======================//
#define MOCK_EXAM_CONTROLLER_TITLE @"考试分类"
#define MOCK_EXAM_SEARCH_BAR_PLACEHOLDER_TEXT @"请输入考试名称"


//===============================试卷详情页面==============//
#define MOCK_EXAM_DETAILS_CONTROLLER_TITLE @"试卷详情"
#define MOCK_EXAM_DETAILS_START_BUTTON_TITLE @"开始答卷"
#define MOCK_EXAM_DETAILS_COLLECT_BUTTON_TITLE @"收藏试卷"
#define MOCK_EXAM_DETAILS_QUESTION_COUNT_LABEL_TEXT @"试卷题数:%d"
#define MOCK_EXAM_DETAILS_TYPE_LABEL_TEXT @"试卷类型:%@"
#define MOCK_EXAM_DETAILS_DATE_LABEL_TEXT @"发布日期:%@"
#define MOCK_EXAM_DETAILS_SOURCE_LABEL_TEXT @"试卷分数:%d"
#define MOCK_EXAM_DETAILS_AUTHOR_LABEL_TEXT @"提供者:%@"
#define MOCK_EXAM_DETAILS_SUBJECT_LABEL_TEXT @"所属科目:%@"


//===============================核心答题界面======================//
#define MOCK_EXAM_ANSWER_QUESTION_CONTROLLER_TITLE @"试卷原题"
#define MOCK_EXAM_ANSWER_QUESTION_TOOLS_LOOK_ANSWER @"查看答案"
#define MOCK_EXAM_ANSWER_QUESTION_TOOLS_HAND_TEST @"交卷"
#define MOCK_EXAM_ANSWER_QUESTION_TOOLS_DRAFT @"草稿纸"
#define MOCK_EXAM_ANSWER_QUESTION_TOOLS_COLLECT @"添加收藏"
#define MOCK_EXAM_ANSWER_QUESTION_TOOLS_ANSWER_PAGER @"答题卡"
#define MOCK_EXAM_ANSWER_QUESTION_TOOLS_NOTE @"添加笔记"
#define MOCK_EXAM_ANSWER_QUESTION_TOOLS_MORE @"更多"

//===============================系统设置界面=====================//
#define SYSTEM_SETTING_CONTROLLER_TITLE @"系统设置"
#define SYSTEM_SETTING_SWITCH_TOPIC @"切换夜间模式"
#define SYSTEM_SETTING_SWITCH_UPDATA @"自动更新题库"
#define SYSTEM_SETTING_RETURN_IDEA @"意见反馈"
#define SYSTEM_SETTING_ABOUT_WE @"关于我们"

//===============================意见反馈界面====================//
#define OPTION_POST_CONTROLLER_TITLE @"意见反馈"
#define OPTION_POST_TEXTVIEW_PLACEHOLDER_TEXT @"您遇到的问题或建议(必填)"
#define OPTION_POST_BUTTON_TITLE @"提交意见"

//===============================关于我们界面=====================//
#define ABOUT_US_CONTROLLER_TITLE @"关于我们"
#define ABOUT_US_WEB @"官方网站: www.VIPExam.com"
#define ABOUT_US_WEIBO @"官方微博: @VIPExam"
#define ABOUT_US_QQ @"用户Q群: 123456789"
#define ABOUT_US_PHONE @"联系电话: 12345677890"
#define ABOUT_US_TEL @"客服电话: 122-232-221"
#define ABOUT_US_ADRESS @"联系地址: 地址地址地址地址"
#define ABOUT_US_ABOUT_US @"    VIPExam考试库专业的手机考试平台，绝对实用的手机考试软件！涵盖工程类、金融类、财会类、资格类、医药类、计算机类、外贸类共7大类100多种考试。"

//===============================考试资讯界面======================//
#define EXAM_INFO_CONTROLLER_TITLE @"考试资讯"
#define EXAM_INFO_DETAIL_CONTROLLER_TITLE @"资讯详情"


//===============================答题卡界面=======================//
#define EXAM_ANSWER_PAGER_CONTROLLER_TITLE @"答题卡"
#define EXAM_ANSWER_PAGER_CERTAIN_BTN_TEXT @"确定交卷"


//=================================我的笔记=====================//
#define STUDY_NOTE_CONTROLLER_TITLE @"我的笔记"
#define STUDY_NOTE_TITLE_TEXT_FIELD_PLACEHOLDER @"请输入标题"
#define STUDY_NOTE_CONTENT_TEXT_VIEW_PLACEHOLDER @"请输入内容"
#define STUDY_NOTE_NEW_BUTTON_TITLE @"添加"
#define STUDY_NOTE_EDIT_BUTTON_TITLE @"修改"
#define STUDY_NOTE_DETAILS_CONTROLLER_TITLE @"笔记详情"

//=================================我的计划====================//
#define STUDY_PLAN_ADD_CONTROLLER_TITLE @"添加计划"
#define STUDY_PLAN_REVISE_CONTROLLER_TITLE @"修改计划"
#define STUDY_PLAN_DETAILS_CONTROLLER_TITLE @"计划详情"


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

//修改密码
#define INTERFACE_FIELD_CHANGE_SECRET_PHONECADE @"phonecode"
#define INTERFACE_FIELD_CHANGE_SECRET_QUESTION @"question"
#define INTERFACE_FIELD_CHANGE_SECRET_ANSWER @"answer"
#define INTERFACE_FIELD_CHANGE_SELECT_NEWPASS @"password"

//模拟考试一级界面
#define INTERFACE_FIELD_MOCKEXAM_CODE @"Code"
#define INTERFACE_FIELD_MOCKEXAM_PAGEINDEX @"PageIndex"
#define INTERFACE_FIELD_MOCKEXAM_PAGESIZE @"PageSize"

//试卷详情
#define INTERFACE_FIELD_MOCKEXAM_EXAMID @"examid"

//试卷题目
#define INTERFACE_FIELD_MOCKEXAM_QUESTION_EXAMID @"id"
#define INTERFACE_FIELD_MOCKEXAM_QUESTION_PAGEINDEX @"PageIndex"

//意见提交
#define INTERFACE_FIELD_OPTION_POST_PHONECODE @"phonecode"
#define INTERFACE_FIELD_OPTION_POST_CONTENT @"content"

//考试资讯
#define INTERFACE_FIELD_EXAM_INFO_PAGEINDEX @"pageIndex"
#define INTERFACE_FIELD_EXAM_INFO_PAGESIZE @"pagesize"
#define INTERFACE_FIELD_EXAM_INFO_DETAIL_MSGID @"msgid"
//提交试卷
#define INTERFACE_FIELD_POST_EXAM_MAIN @"jsonData"
#define INTERFACE_FIELD_POST_EXAM_PHONECODE @"phonecode"
#define INTERFACE_FIELD_POST_EXAM_EXAM_ID @"examid"
#define INTERFACE_FIELD_POST_EXAM_QUESTION_ID @"questionid"
#define INTERFACE_FIELD_POST_EXAM_ANSWER @"answer"
#define INTERFACE_FIELD_POST_EXAM_SORCE @"score"

//我的笔记
#define INTERFACE_FIELD_POST_GET_STUDY_NOTES_PHONECODE @"phonecode"
#define INTERFACE_FIELD_POST_STUDY_NOTES_STATUS @"status"
#define INTERFACE_FIELD_POST_STUDY_NOTES_TITLE @"title"
#define INTERFACE_FIELD_POST_STUDY_NOTES_CONTENT @"content"
#define INTERFACE_FIELD_POST_STUDY_NOTES_QUESTION_ID @"questionid"
#define INTERFACE_FIELD_POST_STUDY_NOTES_ID @"id"

//我的学习计划
#define INTERFACE_FIELD_POST_STUDY_PLAN_LIST_PLONECODE @"phonecode"
#define INTERFACE_FIELD_POST_STUDY_PLAN_STATUS @"status"
#define INTERFACE_FIELD_POST_STUDY_PLAN_ID @"id"
#define INTERFACE_FIELD_POST_STUDY_PLAN_DATE @"date"
#define INTERFACE_FIELD_POST_STUDY_PLAN_TITLE @"title"
#define INTERFACE_FIELD_POST_STUDY_PLAN_CONTENT @"content"

//参数类型
//笔记
#define INTERFACE_FIELD_POST_GET_STUDY_NOTES_STATUS @"list"
#define INTERFACE_FIELD_POST_ADD_STUDY_NOTES_STATUS @"add"
#define INTERFACE_FIELD_POST_EDIT_STUDY_NOTES_STATUS @"update"
#define INTERFACE_FIELD_POST_DELETE_STUDY_NOTES_STATUS @"delete"
#define INTERFACE_FIELD_POST_DETAILS_STUDY_NOTES_STATUS @"query"
//计划
#define INTERFACE_FIELD_POST_GET_STUDY_PLAN_STATUS @"list"
#define INTERFACE_FIELD_POST_DETAILS_STUDY_PLAN_STATUS @"query"
#define INTERFACE_FIELD_POST_ADD_STUDY_PLAN_STATUS @"add"
#define INTERFACE_FIELD_POST_DELETE_STUDY_PLAN_STATUS @"delete"
#define INTERFACE_FIELD_POST_UPDATE_STUDY_PLAN_STATUS @"update"
//============================接口返回字段========================//

#define INTERFACE_RETURN_REGIST_SUCCESS @"8"
#define INTERFACE_RETURN_REGIST_FAILED @"2"

#define INTERFACE_RETURN_LOGIN_SUCCESS @"8"
#define INTERFACE_RETURN_LOGIN_FAILED @"2"


#define INTERFACE_RETURN_CHANGE_SECRET_SUCCESS @"8"
#define INTERFACE_RETURN_CHANGE_SECRET_FAILED @"2"

#define INTERFACE_RETURN_MOCKEXAM_SUCCESS @"8"
#define INTERFACE_RETURN_MOCKEXAM_FAILED @"2"

#define INTERFACE_RETURN_MOCKEXAM__QUESTION_SUCCESS @"8"
#define INTERFACE_RETURN_MOCKEXAM__QUESTION_FAILED @"2"

#define INTERFACE_RETURN_MOCKEXAM__DETAILS_SUCCESS @"8"
#define INTERFACE_RETURN_MOCKEXAM__DETAILE_FAILED @"2"

#define INTERFACE_RETURN_OPTION_POST_SUCCESS @"8"
#define INTERFACE_RETURN_OPTION_POST_FAILED @"2"

#define INTERFACE_RETURN_EXAM_INFO_SUCCESS @"8"
#define INTERFACE_RETURN_EXAM_INFO_FAILED @"2"

#define INTERFACE_RETURN_GET_STUDY_NOTE_LIST_SUCCESS @"8"
#define INTERFACE_RETURN_GET_STUDY_NOTE_LIST_FAILED @"2"

#define INTERFACE_RETURN_ADD_STUDY_NOTE_SUCCESS @"8"
#define INTERFACE_RETURN_ADD_STUDY_NOTE_FAILED @"2"

#define INTERFACE_RETURN_UPDATE_STUDY_NOTE_SUCCESS @"8"
#define INTERFACE_RETURN_UPDATE_STUDY_NOTE_FAILED @"2"

#define INTERFACE_RETURN_DELETE_STUDY_NOTE_SUCCESS @"8"
#define INTERFACE_RETURN_DELETE_STUDY_NOTE_FAILED @"2"

#define INTERFACE_RETURN_DETAILS_STUDY_NOTE_SUCCESS @"8"
#define INTERFACE_RETURN_DETAILS_STUDY_NOTE_FAILED @"2"


#define INTERFACE_RETURN_POST_RECORD_SUCCESS @"8"
#define INTERFACE_RETURN_POST_RECORD_FAILED @"2"

#define INTERFACE_RETURN_POST_STUDY_PLAN_LIST_SUCCESS @"8"
#define INTERFACE_RETURN_POST_STUDY_PLAN_LIST_FAILED @"2"

#define INTERFACE_RETURN_POST_STUDY_PLAN_DETAILS_SUCCESS @"8"
#define INTERFACE_RETURN_POST_STUDY_PLAN_DETAILS_FAILED @"2"

#define INTERFACE_RETURN_POST_STUDY_PLAN_ADD_SUCCESS @"8"
#define INTERFACE_RETURN_POST_STUDY_PLAN_ADD_FAILED @"2"
//============================tableViewCell ID================//
#define TABLEVIEW_CELL_ID_MOCK_EXAM_FIRST @"moceExamFirst"
#define TABLEVIEW_CELL_ID_SYSTEM_SETTING @"systemSetting"
#define TABLEVIEW_CELL_ID_ANSWER_QUESTION  @"answerQuestion"
#define TABLEVIEW_CELL_ID_EXAM_INFO @"enamInfo"
#define TABLEVIEW_CELL_ID_STUDY_NOTE_LIST @"YHSAStudyNoteListTableViewCell"
#endif
