//
//  YHSAWrongExamReloadModel.h
//  StudyApp
//
//  Created by apple on 15/9/13.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseModel.h"

@interface YHSAWrongExamReloadModel : YHBaseModel
__PROPERTY_NO_STRONG__(NSString *, typecode);
__PROPERTY_NO_STRONG__(NSString *, typename);
//这个array中存放submodel的模型字典
__PROPERTY_NO_STRONG__(NSArray *, txlist);
@end

@interface YHSASubWrongExamReloadModel : YHBaseModel
__PROPERTY_NO_STRONG__(NSString *, txcode);
__PROPERTY_NO_STRONG__(NSString *, txname);
__PROPERTY_NO_STRONG__(NSNumber *, count);
@end