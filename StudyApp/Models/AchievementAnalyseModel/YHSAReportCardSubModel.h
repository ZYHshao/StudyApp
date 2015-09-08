//
//  YHSAReportCardSubModel.h
//  
//
//  Created by user on 15/9/8.
//
//

#import "YHBaseModel.h"

@interface YHSAReportCardSubModel : YHBaseModel
__PROPERTY_NO_STRONG__(NSNumber *, correct);
__PROPERTY_NO_STRONG__(NSString *, txname);
__PROPERTY_NO_STRONG__(NSNumber *, total);
__PROPERTY_NO_STRONG__(NSString *, percent);
@end
