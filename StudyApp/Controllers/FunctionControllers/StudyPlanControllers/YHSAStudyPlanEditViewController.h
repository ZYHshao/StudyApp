//
//  YHSAStudyPlanEditViewController.h
//  
//
//  Created by user on 15/9/7.
//
//

#import "YHBaseViewController.h"
//这个枚举确定创建的类型
typedef enum {
    YHSAStudyPlanEditViewControllerStyleDetails,//查看
    YHSAStudyPlanEditViewControllerStyleEdit,//修改
    YHSAStudyPlanEditViewControllerStyleAdd//添加
}YHSAStudyPlanEditViewControllerStyle;
@interface YHSAStudyPlanEditViewController : YHBaseViewController
/**
 *1900-01-01 格式的时间字符串
 */
__PROPERTY_NO_STRONG__(NSString * , dateStr);

__PROPERTY_NO_ASSIGN__(YHSAStudyPlanEditViewControllerStyle, style);
//学习计划编号
__PROPERTY_NO_STRONG__(NSString *, planId);
@end
