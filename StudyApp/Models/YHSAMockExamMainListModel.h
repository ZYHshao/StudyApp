//
//  YHSAMockExamMainListModel.h
//  
//
//  Created by user on 15/8/20.
//
//

#import "YHSARequestGetDataModel.h"

@interface YHSAMockExamMainListModel : YHSARequestGetDataModel
//这个数组中存放的是YHSAMockExamMainListDataModel对象的字典
__PROPERTY_NO_STRONG__(NSArray *, data);
__PROPERTY_NO_ASSIGN__(NSNumber*, status);

@end

@interface YHSAMockExamMainListDataModel : YHBaseModel
__PROPERTY_NO_STRONG__(NSString *, typecode);
__PROPERTY_NO_STRONG__(NSString *, typename);

@end