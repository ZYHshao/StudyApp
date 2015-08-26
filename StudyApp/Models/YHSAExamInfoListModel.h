//
//  YHSAExamInfoListModel.h
//  
//
//  Created by user on 15/8/26.
//
//

#import "YHSARequestGetDataModel.h"

@interface YHSAExamInfoListModel : YHSARequestGetDataModel
__PROPERTY_NO_STRONG__(NSNumber *, pageCount);
__PROPERTY_NO_STRONG__(NSArray *, pageData);
@end


@interface YHSAExamInfoListDataModel : YHBaseModel
__PROPERTY_NO_STRONG__(NSString *, msgid);
__PROPERTY_NO_STRONG__(NSString *, title);
__PROPERTY_NO_STRONG__(NSString *, date);
@end