//
//  YHBaseHeader.h
//  StudyApp
//
//  Created by user on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#ifndef StudyApp_YHBaseHeader_h
#define StudyApp_YHBaseHeader_h
//=============================快捷定义宏=========================//
#define __PROPERTY_NO_COPY__(type,object) @property(nonatomic,copy)type object
#define __PROPERTY_AT_COPY__(type,object) @property(atomic,copy)type object
#define __PROPERTY_NO_STRONG__(type,object) @property(nonatomic,strong)type object
#define __PROPERTY_AT_STRONG__(type,object) @property(nonatomic,strong)type object

#define __PROPERTY_NO_ASSIGN__(type,object) @property(nonatomic,assign)type object
#define __PROPERTY_AT_ASSIGN__(type,object) @property(atomic,assign)type object
#define __PROPERTY_NO_WEAK__(type,object) @property(nonatomic,weak)type object
#define __PROPERTY_AT_WEAK__(type,object) @property(nonatomic,weak)type object

#define __PROPERTY_NO_STRONG__READLY__(type,object) @property(nonatomic,strong,readonly)type object
#define __PROPERTY_NO_ASSIGN__READLY__(type,object) @property(nonatomic,assign,readonly)type object
#endif
