//
//  YHSAAnswerQuestionManager.m
//  
//
//  Created by user on 15/8/31.
//
//

#import "YHSAAnswerQuestionManager.h"

@implementation YHSAAnswerQuestionManager

+(instancetype)sharedTheSingletion{
    static YHSAAnswerQuestionManager * manager = nil;
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
        _dataArray = [[NSMutableArray alloc]init];
        __block int t=_currentTime;
        __BLOCK__WEAK__SELF__(__self);
        [[YHBaseTimerManager sharedTheSingletion]registerAction:^{
            if (t>=_testTime) {
                [__self stop];
                if ([self.delegate respondsToSelector:@selector(YHSAAnswerQuestionManagerTimeOut)]) {
                    [self.delegate YHSAAnswerQuestionManagerTimeOut];
                }
            }
            t++;
        } timer:1 andName:@"YHSAAnswerQuestionManagerTime"];
        [[YHBaseTimerManager sharedTheSingletion]setValid:NO toName:@"YHSAAnswerQuestionManagerTime"];
        _currentTime=0;
        
    }
    return self;
}

-(void)startTimer{
     [[YHBaseTimerManager sharedTheSingletion]setValid:YES toName:@"YHSAAnswerQuestionManagerTime"];
}
-(void)stopTimer{
    [[YHBaseTimerManager sharedTheSingletion] setValid:NO toName:@"YHSAAnswerQuestionManagerTime"];
}

-(void)clearData{
    _currentTime=0;
    _testTime=0;
    _delegate=nil;
    [_dataArray removeAllObjects];
}

@end
