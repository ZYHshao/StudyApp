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
 *是否已经作答
 */
__PROPERTY_NO_ASSIGN__(BOOL, hadAnswer);
/**
 *是否正确
 */
__PROPERTY_NO_ASSIGN__(BOOL, isCorrect);
/**
 *数据字典 可以根据需求存答题信息
 */
__PROPERTY_NO_STRONG__(NSDictionary *, info);
@end
