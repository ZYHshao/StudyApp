//
//  YHSAAnswerQuestionManager.h
//  
//
//  Created by user on 15/8/31.
//
//答题的管理中心 用于处理答题的状态 考试计时等
//注意每次结束后 要将数据清空

#import "YHBaseManager.h"
@class YHSAAnswerQuestionManager;
@protocol YHSAAnswerQuestionManagerDelegate <NSObject>
//时间到时执行的回调
-(void)YHSAAnswerQuestionManagerTimeOut;
@end
@interface YHSAAnswerQuestionManager : YHBaseManager
//答题状态对象
__PROPERTY_NO_STRONG__(NSMutableArray * , dataArray);
//总时间 为0则为不计时 /s
__PROPERTY_NO_ASSIGN__(int, testTime);
//当前进行的时间 /s
__PROPERTY_NO_ASSIGN__(int, currentTime);

__PROPERTY_NO_WEAK__(id<YHSAAnswerQuestionManagerDelegate>, delegate);

//开始进行计时
-(void)startTimer;
//停止计时
-(void)stopTimer;


//重置数据
-(void)clearData;






@end
