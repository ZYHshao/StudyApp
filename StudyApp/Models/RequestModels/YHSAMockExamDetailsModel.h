//
//  YHSAMockExamDetailsModel.h
//  StudyApp
//
//  Created by apple on 15/8/23.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSARequestGetDataModel.h"

@interface YHSAMockExamDetailsModel : YHSARequestGetDataModel
__PROPERTY_NO_STRONG__(NSString *, examname);
__PROPERTY_NO_STRONG__(NSString *, examid);
__PROPERTY_NO_STRONG__(NSNumber *, questioncount);
__PROPERTY_NO_STRONG__(NSString *, examtype);
__PROPERTY_NO_STRONG__(NSString *, examdate);
__PROPERTY_NO_STRONG__(NSNumber *, examscore);
__PROPERTY_NO_STRONG__(NSString *, subject);
__PROPERTY_NO_STRONG__(NSString *, author);
@end
