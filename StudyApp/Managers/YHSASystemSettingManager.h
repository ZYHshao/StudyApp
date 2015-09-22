//
//  YHSASystemSettingManager.h
//  StudyApp
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//系统设置信息的单例 存放系统相关设置 会做本地存储

#import "YHBaseManager.h"

@interface YHSASystemSettingManager : YHBaseManager


//登录信息记录等可以在这里扩展
__PROPERTY_NO_ASSIGN__(BOOL, isMemorizePasswd);
__PROPERTY_NO_STRONG__(NSString *, defaultUserName);
__PROPERTY_NO_STRONG__(NSString *, defaultUserSecret);
__PROPERTY_NO_ASSIGN__(int, topic);
__PROPERTY_NO_ASSIGN__(BOOL, autoUpdataExamBank);

@end
