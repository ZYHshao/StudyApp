//
//  YHSACoreAnswerQuestionView.h
//  
//
//  Created by user on 15/8/24.
//
//核心的答题视图

#import "YHBaseView.h"


@interface YHSACoreAnswerQuestionView : YHBaseView
//主题部分
-(void)setTopic;
//从1开始
__PROPERTY_NO_ASSIGN__(int, index);
//清空数据
-(void)clearData;
//刷新
-(void)updataView;
@end
