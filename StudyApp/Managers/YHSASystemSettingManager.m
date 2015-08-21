//
//  YHSASystemSettingManager.m
//  StudyApp
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSASystemSettingManager.h"
#import "YHSASystemManagerHeader.h"
@implementation YHSASystemSettingManager
+(instancetype)sharedTheSingletion{
    static YHSASystemSettingManager * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

-(void)setIsMemorizePasswd:(BOOL)isMemorizePasswd{
    
    [[NSUserDefaults standardUserDefaults]setBool:isMemorizePasswd forKey:YHSA_SYSTEM_SETTING_IS_MEMORIZE];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(BOOL)isMemorizePasswd{
    return [[NSUserDefaults standardUserDefaults]boolForKey:YHSA_SYSTEM_SETTING_IS_MEMORIZE];
}
-(void)setDefaultUserName:(NSString *)defaultUserName{
    [[NSUserDefaults standardUserDefaults]setObject:defaultUserName forKey:YHSA_SYSTEM_SETTING_DEFAULT_USERNAME];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)defaultUserName{
   return  [[NSUserDefaults standardUserDefaults]objectForKey:YHSA_SYSTEM_SETTING_DEFAULT_USERNAME];
}
-(void)setDefaultUserSecret:(NSString *)defaultUserSecret{
    [[NSUserDefaults standardUserDefaults]setObject:defaultUserSecret forKey:YHSA_SYSTEM_SETTING_DEFAULT_USERSECRET];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)defaultUserSecret{
    return [[NSUserDefaults standardUserDefaults]objectForKey:YHSA_SYSTEM_SETTING_DEFAULT_USERSECRET];
}
-(void)setTopic:(int)topic{
    [[NSUserDefaults standardUserDefaults]setInteger:topic forKey:YHSA_SYSTEM_SETTING_TOPIC];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(int)topic{
    return (int)[[NSUserDefaults standardUserDefaults]integerForKey:YHSA_SYSTEM_SETTING_TOPIC];
}

-(void)setAutoUpdataExamBank:(BOOL)autoUpdataExamBank{
    [[NSUserDefaults standardUserDefaults]setBool:autoUpdataExamBank forKey:YHSA_SYSTEM_SETTING_AUTOUPDA_EXAMBANK];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(BOOL)autoUpdataExamBank{
    return [[NSUserDefaults standardUserDefaults]boolForKey:YHSA_SYSTEM_SETTING_AUTOUPDA_EXAMBANK];
}

@end
