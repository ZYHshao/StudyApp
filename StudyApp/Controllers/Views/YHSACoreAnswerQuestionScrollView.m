//
//  YHSACoreAnswerQuestionScrollView.m
//  
//
//  Created by user on 15/8/24.
//
//

#import "YHSACoreAnswerQuestionScrollView.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSAHttpManager.h"
#import "YHSAAnswerQuestionModel.h"
#import "YHTopicColorManager.h"
#import "YHSACoreAnswerQuestionView.h"
#import "YHSAAnswerQuestionManager.h"
#import "YHSAAnswerStateModel.h"
#import "YHSAUserManager.h"
#define WIDTH self.frame.size.width
#define HIGHT self.frame.size.height
@interface YHSACoreAnswerQuestionScrollView()<UIScrollViewDelegate>
{
    //创建三个循环使用的视图
    id _leftView;
    id _middleView;
    id _rightView;
    //错题组卷时用户设置的总题目量
    int _wrongCount;
}
@end
@implementation YHSACoreAnswerQuestionScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:YHSAAnswerQuestionManagerNotication object:nil];
}

//加载视图的方法
-(void)reloadView{
    //这里添加上错题组卷
    if (_isWrongReload&&_typecode!=nil) {
        _wrongCount=0;
        for (int i=0; i<_pageDataArray.count; i++) {
            _wrongCount=_wrongCount+[[_pageDataArray[i] objectForKey:@"count"] intValue];
        }
        
        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(answerPagerNotification:) name:YHSAAnswerQuestionManagerNotication object:nil];
        _leftView = [[_viewClass alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HIGHT)];
        _middleView = [[_viewClass alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HIGHT)];
        _rightView  = [[_viewClass alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HIGHT)];
        [self addSubview:_leftView];
        [self addSubview:_middleView];
        [self addSubview:_rightView];
        [self creatData];
        
        return;
    }else if (_isWrongReload&&_typecode==nil){
        return;
    }
    
    
    
    
    if (_dataModel==nil&&!_isNotExam) {
        return;
    }
    if (_isNotExam&&_subDataModel==nil) {
        return;
    }
    //添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(answerPagerNotification:) name:YHSAAnswerQuestionManagerNotication object:nil];
    _leftView = [[_viewClass alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HIGHT)];
    _middleView = [[_viewClass alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HIGHT)];
    _rightView  = [[_viewClass alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HIGHT)];
    [self addSubview:_leftView];
    [self addSubview:_middleView];
    [self addSubview:_rightView];
    [self creatData];
}

-(void)creatData{
    if (_isWrongReload) {
        
         _dataArray = [[NSMutableArray alloc]init];
        self.contentSize = CGSizeMake(_wrongCount*WIDTH, HIGHT);
        
        //进行scrollView的相关属性配置
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.delegate = self;
        self.pagingEnabled = YES;
        [self requestWrongData:1];
        return;
    }
    
    
    
    if (_dataModel==nil&&!_isNotExam) {
        return;
    }
    if (_isNotExam&&_subDataModel==nil) {
        return;
    }
    _dataArray = [[NSMutableArray alloc]init];
    if (_isNotExam) {
         self.contentSize = CGSizeMake([_subDataModel.count intValue]*WIDTH, HIGHT);
    }else{
         self.contentSize = CGSizeMake([_dataModel.questioncount intValue]*WIDTH, HIGHT);
    }
   
    //进行scrollView的相关属性配置
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    self.delegate = self;
    self.pagingEnabled = YES;
    //进行第一题的请求
    if (_isNotExam) {
        [self subRequestData:1];
    }else{
        //进行所有试题的请求
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        __BLOCK__WEAK__SELF__(__self);
        NSDictionary * dic = @{@"examid":_dataModel.examid};
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeAllQuestion infoDic:dic Succsee:^(NSData *data) {
            NSDictionary * temDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
            [tmpModel creatModelWithDic:temDic];
            for (int i=0; i<[(NSArray *)[tmpModel.data objectForKey:@"pageData"] count]; i++) {
                YHSAAnswerQuestionModel * model = [[YHSAAnswerQuestionModel alloc]init];
                [model creatModelWithDic:[[tmpModel.data objectForKey:@"pageData"] objectAtIndex:i]];
                [_dataArray addObject:model];
                //设置数据
                YHSAAnswerStateModel * stateModel =  [[YHSAAnswerQuestionManager sharedTheSingletion].dataArray objectAtIndex:i];
                stateModel.hadLoadDown=YES;
            }
            
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
            //进行数据展示
            [__self showData];

        } andFail:^(YHBaseError *error) {
            [[YHSAActivityIndicatorView  sharedTheSingletion]unShow];
        } isbuffer:NO];
    }
  
}



-(void)requestWrongData:(int)index{
     __BLOCK__WEAK__SELF__(__self);
    if (index<=_wrongCount) {
        //拼接字典
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        NSDictionary * dic = @{@"phonecode":[YHSAUserManager sharedTheSingletion].userName,@"typecode":_typecode,@"pageIndex":[NSString stringWithFormat:@"%d",index],@"pageData":_pageDataArray};
        NSArray * tmpArray = @[dic];
        NSString * dicStr = [tmpArray transToJsonString:YHBaseJosnStyleNoneSpace|YHBaseJosnStyleSinglequotationMark|YHBaseJosnStyleNoneWarp];
        NSDictionary * postDic = @{@"jsonData":dicStr};
        NSLog(@"%@",postDic);
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeWrongReload infoDic:postDic Succsee:^(NSData *data) {
            NSDictionary * temDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
            [tmpModel creatModelWithDic:temDic];
            YHSAAnswerQuestionModel * model = [[YHSAAnswerQuestionModel alloc]init];
            [model creatModelWithDic:[[tmpModel.data objectForKey:@"pageData"] firstObject]];
            [_dataArray addObject:model];
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
            //进行数据展示
            [__self showData];
            //设置数据
            YHSAAnswerStateModel * stateModel =  [[YHSAAnswerQuestionManager sharedTheSingletion].dataArray objectAtIndex:index-1];
            stateModel.hadLoadDown=YES;
        } andFail:^(YHBaseError *error) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } isbuffer:NO];
    }

}


-(void)subRequestData:(int)index{
    __BLOCK__WEAK__SELF__(__self);
    if (index<=[_subDataModel.count intValue]) {
        //拼接字典
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        NSDictionary * dic = @{INTERFACE_FIELD_POST_WRONG_RECORD_PHONECODE:_subDataModel.phonecode,INTERFACE_FIELD_POST_WRONG_RECORD_EXAMID:_subDataModel.examid,INTERFACE_FIELD_POST_WRONG_RECORD_TXCODE:_subDataModel.txcode,INTERFACE_FIELD_POST_WRONG_RECODE_PAGEINDEX:[NSString stringWithFormat:@"%d",index]};
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeWrongRecordQuestion infoDic:dic Succsee:^(NSData *data) {
            NSDictionary * temDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
            [tmpModel creatModelWithDic:temDic];
            YHSAAnswerQuestionModel * model = [[YHSAAnswerQuestionModel alloc]init];
            [model creatModelWithDic:[[tmpModel.data objectForKey:@"pageData"] firstObject]];
            [_dataArray addObject:model];
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
            //进行数据展示
            [__self showData];
            //设置数据
            YHSAAnswerStateModel * stateModel =  [[YHSAAnswerQuestionManager sharedTheSingletion].dataArray objectAtIndex:index-1];
            stateModel.hadLoadDown=YES;
        } andFail:^(YHBaseError *error) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } isbuffer:NO];
    }

}

-(void)requestData:(int)index{
    __BLOCK__WEAK__SELF__(__self);
    if (index<=[_dataModel.questioncount intValue]) {
        //拼接字典
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        NSDictionary * dic = @{INTERFACE_FIELD_MOCKEXAM_QUESTION_EXAMID:_dataModel.examid,INTERFACE_FIELD_MOCKEXAM_QUESTION_PAGEINDEX:[NSString stringWithFormat:@"%d",index]};
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamQuestion infoDic:dic Succsee:^(NSData *data) {
            NSDictionary * temDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
            [tmpModel creatModelWithDic:temDic];
            YHSAAnswerQuestionModel * model = [[YHSAAnswerQuestionModel alloc]init];
            [model creatModelWithDic:[[tmpModel.data objectForKey:@"pageData"] firstObject]];
            [_dataArray addObject:model];
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
            //进行数据展示
            [__self showData];
            //设置数据
            YHSAAnswerStateModel * stateModel =  [[YHSAAnswerQuestionManager sharedTheSingletion].dataArray objectAtIndex:index-1];
            stateModel.hadLoadDown=YES;
        } andFail:^(YHBaseError *error) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } isbuffer:NO];
    }
}



//进行数据的展示

-(void)showData{
    if (_isWrongReload) {
        if ([self.dataDelegate respondsToSelector:@selector(YHSACoreAnswerQuestionScrollViewEndScroll)]) {
            [self.dataDelegate YHSACoreAnswerQuestionScrollViewEndScroll];
        }
        if (_currentPage==0&&_dataArray.count==1) {
            [_leftView setIndex:1];
            [_leftView creatViewWithData:_dataArray[0]];
        }else if (_dataArray.count==2&&_currentPage==1){
            [_leftView setIndex:1];
            [_middleView setIndex:2];
            [_leftView creatViewWithData:_dataArray[0]];
            [_middleView creatViewWithData:_dataArray[1]];
        }else if (_currentPage>=2&&_dataArray.count==_currentPage+1&&_currentPage!=_wrongCount-1){
            [_leftView setIndex:_currentPage];
            [_middleView setIndex:_currentPage+1];
            [_leftView creatViewWithData:_dataArray[_currentPage-1]];
            [_middleView creatViewWithData:_dataArray[_currentPage]];
        }else if (_dataArray.count>=2&&_dataArray.count>_currentPage+1&&_currentPage!=_wrongCount-1){
            [_leftView setIndex:_currentPage];
            [_middleView setIndex:_currentPage+1];
            [_rightView setIndex:_currentPage+2];
            [_leftView creatViewWithData:_dataArray[_currentPage-1]];
            [_middleView creatViewWithData:_dataArray[_currentPage]];
            [_rightView creatViewWithData:_dataArray[_currentPage+1]];
        }else if (_currentPage==_wrongCount-1){
            [_rightView setIndex:_currentPage+1];
            [_rightView creatViewWithData:_dataArray[_currentPage]];
        }
        return;

    }
    
    
    if (_isNotExam) {
        if ([self.dataDelegate respondsToSelector:@selector(YHSACoreAnswerQuestionScrollViewEndScroll)]) {
            [self.dataDelegate YHSACoreAnswerQuestionScrollViewEndScroll];
        }
        if (_currentPage==0&&_dataArray.count==1) {
            [_leftView setIndex:1];
            [_leftView creatViewWithData:_dataArray[0]];
        }else if (_dataArray.count==2&&_currentPage==1){
            [_leftView setIndex:1];
            [_middleView setIndex:2];
            [_leftView creatViewWithData:_dataArray[0]];
            [_middleView creatViewWithData:_dataArray[1]];
        }else if (_currentPage>=2&&_dataArray.count==_currentPage+1&&_currentPage!=[_subDataModel.count intValue]-1){
            [_leftView setIndex:_currentPage];
            [_middleView setIndex:_currentPage+1];
            [_leftView creatViewWithData:_dataArray[_currentPage-1]];
            [_middleView creatViewWithData:_dataArray[_currentPage]];
        }else if (_dataArray.count>=2&&_dataArray.count>_currentPage+1&&_currentPage!=[_subDataModel.count intValue]-1){
            [_leftView setIndex:_currentPage];
            [_middleView setIndex:_currentPage+1];
            [_rightView setIndex:_currentPage+2];
            [_leftView creatViewWithData:_dataArray[_currentPage-1]];
            [_middleView creatViewWithData:_dataArray[_currentPage]];
            [_rightView creatViewWithData:_dataArray[_currentPage+1]];
        }else if (_currentPage==[_subDataModel.count intValue]-1){
            [_rightView setIndex:_currentPage+1];
            [_rightView creatViewWithData:_dataArray[_currentPage]];
        }

    }else{
        if ([self.dataDelegate respondsToSelector:@selector(YHSACoreAnswerQuestionScrollViewEndScroll)]) {
            [self.dataDelegate YHSACoreAnswerQuestionScrollViewEndScroll];
        }
        if (_currentPage==0) {
            [_leftView setIndex:1];
            [_leftView creatViewWithData:_dataArray[0]];
        }else if (_currentPage>0&&_currentPage<[_dataModel.questioncount intValue]-1){
            [_leftView setIndex:_currentPage];
            [_middleView setIndex:_currentPage+1];
            [_rightView setIndex:_currentPage+2];
            [_leftView creatViewWithData:_dataArray[_currentPage-1]];
            [_middleView creatViewWithData:_dataArray[_currentPage]];
            [_rightView creatViewWithData:_dataArray[_currentPage+1]];
        }else{
            [_leftView setIndex:_currentPage-1];
            [_middleView setIndex:_currentPage];
            [_rightView setIndex:_currentPage+1];
            [_leftView creatViewWithData:_dataArray[_currentPage-2]];
            [_middleView creatViewWithData:_dataArray[_currentPage-1]];
            [_rightView creatViewWithData:_dataArray[_currentPage]];
        }

    }
        [self setTopic];
}


-(void)setTopic{
    //做视图主题部分的功能
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.backgroundColor = manager.bgColor;
    [_leftView setTopic];
    [_middleView setTopic];
    [_rightView setTopic];
}

#pragma mark - scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //进行View和数据的重构
    CGFloat  offset = scrollView.contentOffset.x;
    _currentPage = offset/WIDTH;
    
    
    if (_isWrongReload) {
        if (offset==0) {
            //回到第一页，不需要做任何重构
            _currentPage=0;
        }else if(offset==(_wrongCount-1)*WIDTH){
            //到达最后一页，不需要做任何重构
            _currentPage=_wrongCount-1;
            if (_currentPage+1>_dataArray.count&&_currentPage+1<=_wrongCount) {
                [self requestWrongData:_currentPage+1 ];
            }else{
                
                [self showData];
                
            }
            
        }else{
            //不是起始与结束页  进行重构
            [self reloadViewData];
        }
        
        scrollView.userInteractionEnabled = YES;
        //数据处理
        [YHSAAnswerQuestionManager sharedTheSingletion].currentIndex=_currentPage;
        return;

    }
    
    if (_isNotExam) {
        if (offset==0) {
            //回到第一页，不需要做任何重构
            _currentPage=0;
        }else if(offset==([_subDataModel.count intValue]-1)*WIDTH){
            //到达最后一页，不需要做任何重构
            _currentPage=[_subDataModel.count intValue]-1;
            if (_currentPage+1>_dataArray.count&&_currentPage+1<=[_subDataModel.count intValue]) {
                [self subRequestData:_currentPage+1 ];
            }else{
                
                [self showData];
                
            }

        }else{
            //不是起始与结束页  进行重构
            [self reloadViewData];
        }

    }else{
        if (offset==0) {
            //回到第一页，不需要做任何重构
            _currentPage=0;
        }else if(offset==([_dataModel.questioncount intValue]-1)*WIDTH){
            //到达最后一页，不需要做任何重构
            _currentPage=[_dataModel.questioncount intValue]-1;
            if (_currentPage+1>_dataArray.count&&_currentPage+1<=[_dataModel.questioncount intValue]) {
                [self requestData:_currentPage+1 ];
            }else{
                
                [self showData];
                
            }
        }else{
            //不是起始与结束页  进行重构
            [self reloadViewData];
        }

    }
       scrollView.userInteractionEnabled = YES;
   //数据处理
    [YHSAAnswerQuestionManager sharedTheSingletion].currentIndex=_currentPage;
}

//为了防止连续滑动产生的bug，这里做一个处理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.userInteractionEnabled = NO;
}

#pragma mark - 逻辑部分
//视图与数据重构方法
-(void)reloadViewData{
    //位置重构
    [_leftView setFrame:CGRectMake((_currentPage-1)*WIDTH,0, WIDTH, HIGHT)];
    [_middleView setFrame:CGRectMake(_currentPage*WIDTH,0 , WIDTH, HIGHT)];
    [_rightView setFrame:CGRectMake((_currentPage+1)*WIDTH, 0, WIDTH, HIGHT)];
    //数据重构
    [_leftView clearData];
    [_middleView clearData];
    [_rightView clearData];
    //如果数组中数据不够，进行下载 注意page是从0开始 参数是从1开始
    if (_isWrongReload) {
        if (_currentPage+1>_dataArray.count) {
            [self requestWrongData:_currentPage+1 ];
        }else{
            
            [self showData];
        }
        return;
    }
    
    
    if (!_isNotExam) {
        if (_currentPage+1>_dataArray.count) {
            [self requestData:_currentPage+1 ];
        }else{
            
            [self showData];
        }
    }else{
        if (_currentPage+1>_dataArray.count) {
            [self subRequestData:_currentPage+1 ];
        }else{
            
            [self showData];
        }
    }
    
}
-(void)updataView{
//都是tableView
    [_leftView updataView];
    [_middleView updataView];
    [_rightView updataView];
}

//通过答题卡切换题目
-(void)answerPagerNotification:(NSNotification *)noti{
    NSDictionary * info = noti.userInfo;
    int index = [[info objectForKey:@"index"] intValue];
    //设置scrollView的偏移量
    //这里处理了 首尾两种特殊情况
    if (index==0) {
        self.contentOffset = CGPointMake((index+1)*self.frame.size.width, 0);
        [self scrollViewDidEndDecelerating:self];
    }
    //
    if (index==[_dataModel.questioncount intValue]-1) {
        self.contentOffset = CGPointMake((index-1)*self.frame.size.width, 0);
        [self scrollViewDidEndDecelerating:self];
    }
    self.contentOffset = CGPointMake(index*self.frame.size.width, 0);
    [self scrollViewDidEndDecelerating:self];
}

-(void)setFontSize:(int)size{
    [(YHSACoreAnswerQuestionView*)_leftView setFontSize:size];
    [(YHSACoreAnswerQuestionView*)_middleView setFontSize:size];
    [(YHSACoreAnswerQuestionView*)_rightView setFontSize:size];
    
}

@end
