//
//  YHSAAnswerPagerViewController.h
//  
//
//  Created by user on 15/8/31.
//
//答题卡的视图控制器

#import "YHBaseViewController.h"
@class YHSAAnswerQuestionManager;

@interface YHSAAnswerPagerViewController : YHBaseViewController
//试卷答题的管理
__PROPERTY_NO_STRONG__(YHSAAnswerQuestionManager *, answerManager);

@end
