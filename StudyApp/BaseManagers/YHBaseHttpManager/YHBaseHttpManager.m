//
//  YHBaseHttpManager.m
//  
//
//  Created by user on 15/8/18.
//
//

#import "YHBaseHttpManager.h"

@implementation YHBaseHttpManager

+(instancetype)sharedTheSingletion{
    static YHBaseHttpManager * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[YHBaseHttpManager alloc] init];
    });
    return manager;
}
@end
