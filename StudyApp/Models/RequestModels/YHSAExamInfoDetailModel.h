//
//  YHSAExamInfoDetailModel.h
//  
//
//  Created by user on 15/8/26.
//
//

#import "YHSARequestGetDataModel.h"

@interface YHSAExamInfoDetailModel : YHSARequestGetDataModel
__PROPERTY_NO_STRONG__(NSString *, msgid);
__PROPERTY_NO_STRONG__(NSString *, title);
__PROPERTY_NO_STRONG__(NSString *, content);
__PROPERTY_NO_STRONG__(NSString *, date);
@end
