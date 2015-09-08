//
//  YHSAReportCardModel.h
//  
//
//  Created by user on 15/9/8.
//
//

#import "YHBaseModel.h"

@interface YHSAReportCardModel : YHBaseModel
//分项数据数组
__PROPERTY_NO_STRONG__(NSArray *, pageData);
//试卷题目
__PROPERTY_NO_STRONG__(NSString *, examname);
@end
