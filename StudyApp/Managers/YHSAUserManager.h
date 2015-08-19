//
//  YHSAUserManager.h
//  StudyApp
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//用户的信息单例 存放登陆信息

#import "YHBaseManager.h"

@interface YHSAUserManager : YHBaseManager
__PROPERTY_NO_STRONG__(NSString *, userName);
__PROPERTY_NO_STRONG__(NSString *, userSecret);
/**
 *登陆状态
 */
__PROPERTY_NO_ASSIGN__(BOOL, isLogin);
@end
