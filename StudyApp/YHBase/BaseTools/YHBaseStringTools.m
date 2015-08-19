//
//  YHBaseStringTools.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHBaseStringTools.h"

@implementation YHBaseStringTools


BOOL YHBaseCheckString(YHBaseStringCompareType compareType,NSString * str,int length){
    switch (compareType) {
        case YHBaseStringCompareEqual:
        {
            if (str.length!=length) {
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case YHBaseStringCompareLonger:
        {
            if (str.length>length) {
                return YES;
            }else{
                return NO;
            }
        }
            break; case YHBaseStringCompareShorter:
        {
            if (str.length<length) {
                return YES;
            }else{
                return NO;
            }
        }
            break;
        default:
            break;
    }
}

@end
