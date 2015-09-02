//
//  YHSAAnswerQuestionManager.m
//  
//
//  Created by user on 15/8/31.
//
//

#import "YHSAAnswerQuestionManager.h"
#import "YHSAAnswerStateModel.h"
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
        int  * t=&_currentTime;
        __BLOCK__WEAK__SELF__(__self);
        [[YHBaseTimerManager sharedTheSingletion]registerAction:^{
            if (_testTime>0&&*t>=_testTime) {
                [__self stopTimer];
                if ([self.delegate respondsToSelector:@selector(YHSAAnswerQuestionManagerTimeOut)]) {
                    [self.delegate YHSAAnswerQuestionManagerTimeOut];
                }
            }
            *t=*t+1;
        } timer:1 andName:@"YHSAAnswerQuestionManagerTime"];
        [[YHBaseTimerManager sharedTheSingletion]setValid:NO toName:@"YHSAAnswerQuestionManagerTime"];
        _currentTime=0;
        _currentIndex=0;
        
    }
    return self;
}

-(void)startTimer{
     [[YHBaseTimerManager sharedTheSingletion]setValid:YES toName:@"YHSAAnswerQuestionManagerTime"];
}
-(void)stopTimer{
    [[YHBaseTimerManager sharedTheSingletion] setValid:NO toName:@"YHSAAnswerQuestionManagerTime"];
}


-(int)hadAnswerCount{
    int count =0;
    for (YHSAAnswerStateModel * model in _dataArray) {
        if (model.hadAnswer) {
            count++;
        }
    }
    return count;
}


-(void)clearData{
    _currentIndex=0;
    _currentTime=0;
    _testTime=0;
    _delegate=nil;
    _hadHeanIn=NO;
    _examID=nil;
    [_dataArray removeAllObjects];
}

@end
