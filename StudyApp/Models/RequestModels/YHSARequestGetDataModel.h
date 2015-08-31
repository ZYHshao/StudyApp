//
//  YHSARegustGetDataModel.h
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHBaseModel.h"

@interface YHSARequestGetDataModel : YHBaseModel
__PROPERTY_NO_STRONG__(id, data);
__PROPERTY_NO_STRONG__(NSString *, msg);
__PROPERTY_NO_STRONG__(NSNumber *, resultCode);
__PROPERTY_NO_STRONG__(NSString *, resultMsg);
@end
