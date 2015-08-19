//
//  YHSAUserManager.m
//  StudyApp
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAUserManager.h"

@implementation YHSAUserManager
+(instancetype)sharedTheSingletion{
    static YHSAUserManager * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
@end
