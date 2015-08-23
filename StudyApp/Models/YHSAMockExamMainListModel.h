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
__PROPERTY_NO_ASSIGN__(NSNumber*, status);


//试卷的字段
__PROPERTY_NO_STRONG__(NSNumber *, pageIndex);
__PROPERTY_NO_STRONG__(NSNumber *, pageSize);
__PROPERTY_NO_STRONG__(NSDictionary *, pageData);
__PROPERTY_NO_STRONG__(NSNumber *, pageCount);

@end

@interface YHSAMockExamMainListDataModel : YHBaseModel
__PROPERTY_NO_STRONG__(NSString *, typecode);
__PROPERTY_NO_STRONG__(NSString *, typename);

__PROPERTY_NO_STRONG__(NSString *, examid);
__PROPERTY_NO_STRONG__(NSString *, examname);
__PROPERTY_NO_STRONG__(NSString *, quescount);
//试卷的字段

@end