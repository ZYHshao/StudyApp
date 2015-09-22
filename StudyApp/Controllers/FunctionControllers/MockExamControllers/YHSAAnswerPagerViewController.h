//
//  YHSAAnswerPagerViewController.h
//  
//
//  Created by user on 15/8/31.
//
//答题卡的视图控制器

#import "YHBaseViewController.h"


@interface YHSAAnswerPagerViewController : YHBaseViewController
__PROPERTY_NO_ASSIGN__(BOOL, isNotExam);
__PROPERTY_NO_ASSIGN__(BOOL, isWrongReload);
__PROPERTY_NO_STRONG__(NSNumber *, allQuestion);
__PROPERTY_NO_STRONG__(NSNumber *, currectQuestion);
__PROPERTY_NO_STRONG__(NSString *, precent);
@end
