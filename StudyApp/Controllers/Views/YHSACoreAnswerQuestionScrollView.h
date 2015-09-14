//
//  YHSACoreAnswerQuestionScrollView.h
//  
//
//  Created by user on 15/8/24.
//
//核心答题视图的复用框架

#import "YHBaseScrollView.h"
#import "YHSAMockExamDetailsModel.h"
#import "YHSAWrongRecordPostModel.h"
//将音频的处理放在外面
@class YHSACoreAnswerQuestionScrollView;
@protocol YHSACoreAnswerQuestionScrollViewDelegate <NSObject>
-(void)YHSACoreAnswerQuestionScrollViewEndScroll;
@end



@interface YHSACoreAnswerQuestionScrollView : YHBaseScrollView
//将视图的类作为对象传进来
__PROPERTY_NO_STRONG__(Class, viewClass);
//数据源数组
__PROPERTY_NO_STRONG__(NSMutableArray *, dataArray);
//当前页数 从0开始
__PROPERTY_NO_ASSIGN__(int, currentPage);
__PROPERTY_NO_WEAK__(id<YHSACoreAnswerQuestionScrollViewDelegate>,dataDelegate);
//考虑到切换主题 在这类想外提供一个设置主题的接口
-(void)setTopic;

//设置字体大小
-(void)setFontSize:(int)size;

//刷新
-(void)updataView;

__PROPERTY_NO_STRONG__(YHSAMockExamDetailsModel *, dataModel);

__PROPERTY_NO_STRONG__(YHSAWrongRecordPostModel *, subDataModel);
__PROPERTY_NO_ASSIGN__(BOOL, isNotExam);


//这里分的逻辑比较混乱 开始接口的设计没有考虑周全

//错题组卷
__PROPERTY_NO_ASSIGN__(BOOL, isWrongReload);
//错题组卷的pagedata数组
__PROPERTY_NO_STRONG__(NSArray * , pageDataArray);
//科目代码
__PROPERTY_NO_STRONG__(NSString *, typecode);
@end
