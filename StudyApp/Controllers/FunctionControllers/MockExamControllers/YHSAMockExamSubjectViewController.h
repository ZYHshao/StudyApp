//
//  YHSAMockExamSubjectViewController.h
//  
//
//  Created by user on 15/8/21.
//
//科目分类的子分类controller

#import "YHBaseViewController.h"
#import "YHSAMockExamMainListModel.h"
@interface YHSAMockExamSubjectViewController : YHBaseViewController
/**
 *数据的model
 */
__PROPERTY_NO_STRONG__(YHSAMockExamMainListDataModel *, dataModel);
__PROPERTY_NO_STRONG__(NSMutableArray *, dataArray);
__PROPERTY_NO_ASSIGN__(int, examCount);
//分类级别的状态
__PROPERTY_NO_ASSIGN__(int, status);

__PROPERTY_NO_ASSIGN__(BOOL, isSearch);
@end
