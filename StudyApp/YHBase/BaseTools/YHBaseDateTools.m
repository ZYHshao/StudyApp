//
//  YHBaseDateTools.m
//  StudyApp
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseDateTools.h"

@implementation YHBaseDateTools
+(NSString *)getCurrentTime{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * time = [formatter stringFromDate:[NSDate date]];
    return time;
}
@end
