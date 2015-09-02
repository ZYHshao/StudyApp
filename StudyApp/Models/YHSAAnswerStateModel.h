//
//  YHSAAnswerStateModel.h
//  
//
//  Created by user on 15/8/31.
//
//答题状态的数据模型

#import "YHBaseModel.h"

@interface YHSAAnswerStateModel : YHBaseModel
/**
 *标志这道题是否已经下载完成
 */
__PROPERTY_NO_ASSIGN__(BOOL, hadLoadDown);
/**
 *是否已经作答
 */
__PROPERTY_NO_ASSIGN__(BOOL, hadAnswer);
/**
 *是否正确
 */
__PROPERTY_NO_ASSIGN__(BOOL, isCorrect);
/**
 *题目的编号
 */
__PROPERTY_NO_STRONG__(NSString *, questionID);
/**
 *题目的分值
 */
__PROPERTY_NO_STRONG__(NSNumber *, sccore);
/**
 *数据字典 可以根据需求存答题信息 
 *字典按照如下数据结构
 * type 对应题目类型 1234
 * ans 对应ABCD或者文字 ABCD可多选
 */
__PROPERTY_NO_STRONG__(NSDictionary *, info);
@end
