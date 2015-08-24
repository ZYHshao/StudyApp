//
//  YHSACoreAnswerQuestionScrollView.h
//  
//
//  Created by user on 15/8/24.
//
//核心答题视图的复用框架

#import "YHBaseScrollView.h"
#import "YHSAMockExamDetailsModel.h"
@interface YHSACoreAnswerQuestionScrollView : YHBaseScrollView
//将视图的类作为对象传进来
__PROPERTY_NO_STRONG__(Class, viewClass);
//数据源数组
__PROPERTY_NO_STRONG__(NSMutableArray *, dataArray);
//当前页数 从0开始
__PROPERTY_NO_ASSIGN__(int, currentPage);

//考虑到切换主题 在这类想外提供一个设置主题的接口
-(void)setTopic;


__PROPERTY_NO_STRONG__(YHSAMockExamDetailsModel *, dataModel);

@end
