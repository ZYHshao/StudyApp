//
//  YHSAMockExamAnswerQuestionViewController.h
//  
//
//  Created by user on 15/8/24.
//
//

#import "YHBaseViewController.h"
#import "YHSAMockExamDetailsModel.h"
#import "YHSAWrongRecordPostModel.h"
@interface YHSAMockExamAnswerQuestionViewController : YHBaseViewController
/**
 *试卷详情的model
 */
__PROPERTY_NO_STRONG__(YHSAMockExamDetailsModel *, dataModel);


/**
 *试题详情的model 用于错题组卷和查看错题
 */
__PROPERTY_NO_STRONG__(YHSAWrongRecordPostModel  *, subDataModel);

/**
 *这个参数用于确定是否是答卷模式
 */
__PROPERTY_NO_ASSIGN__(BOOL, isNotExam);



__PROPERTY_NO_ASSIGN__(BOOL, isWrongReload);


//错题组卷的pagedata数组
__PROPERTY_NO_STRONG__(NSArray * , pageDataArray);
//科目代码
__PROPERTY_NO_STRONG__(NSString *, typecode);
@end
