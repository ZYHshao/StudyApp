//
//  YHBaseStringTools.h
//  
//
//  Created by user on 15/8/19.
//
//

#import <Foundation/Foundation.h>
/**
 *比较方法的枚举
 */
typedef enum {
    YHBaseStringCompareLonger=1,
    YHBaseStringCompareShorter,
    YHBaseStringCompareEqual
}YHBaseStringCompareType;
@interface YHBaseStringTools : NSObject
//====================================字符串检测函数=========================//
/**
 *检测字符串长度是否符合
 */
BOOL YHBaseCheckString(YHBaseStringCompareType compareType,NSString * str,int length);




@end
