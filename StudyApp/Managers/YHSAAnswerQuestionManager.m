//
//  YHSAAnswerQuestionManager.m
//  
//
//  Created by user on 15/8/31.
//
//

#import "YHSAAnswerQuestionManager.h"

@implementation YHSAAnswerQuestionManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentTime=0;
    }
    return self;
}

-(void)startTimer{
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
}
-(void)stopTimer{
    [[YHBaseTimerManager sharedTheSingletion] setValid:NO toName:@"YHSAAnswerQuestionManagerTime"];
    [[YHBaseTimerManager sharedTheSingletion]removeActionForName:@"YHSAAnswerQuestionManagerTime"];
}
@end
