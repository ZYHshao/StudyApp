//
//  BaseHead.h
//  StudyApp
//
//  Created by user on 15/8/17.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#ifndef StudyApp_BaseHead_h
#define StudyApp_BaseHead_h

#import <Foundation/Foundation.h>
//===================================系统通知=================================//
//主题改变时发送的通知
#define YHTopicChangeTopicNotication @"YHTopicChangeTopicNotication"



//
////===================================系统配置字符串===========================//
////主题风格
#define TOPIC @"topic"




//===================================常用常量宏================================//

//屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//左右上下布局边距
#define LAYOUT_OFFSET_TOP 20
#define LAYOUT_OFFSET_BOTTOM 20
#define LAYOUT_OFFSET_LEFT 20
#define LAYOUT_OFFSET_RIGHT 20

//字体大小
#define TEXT_FONT_SIZE_NORMAL 17
#define TEXT_FONT_SIZE_BIG_TITLE 24

#endif
