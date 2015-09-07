//
//  YHSAAnswerPagerViewController.m
//  
//
//  Created by user on 15/8/31.
//
//

#import "YHSAAnswerPagerViewController.h"
#import "YHSAAnswerQuestionManager.h"
#import "YHSAAnswerStateModel.h"
#import "YHSAUserManager.h"
#import "YHSALoginViewController.h"
#import "YHSAHttpManager.h"
#import "YHSARecordsModel.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSARecordsViewController.h"
@interface YHSAAnswerPagerViewController ()
{
    //标头视图
    YHBaseView * _headView1;//未交卷
    YHBaseView * _headView2;//已经交卷
    
    YHBaseLabel * _headView1InfoLabel;
    YHBaseLabel * _headView2InfoLabel;
    
    //主体视图
    YHBaseScrollView * _bodyView;
    //存放按钮的数组
    NSMutableArray * _btnArray;
}
@end

@implementation YHSAAnswerPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //添加一个更新时间的动作
    [[YHBaseTimerManager sharedTheSingletion]registerAction:^{
        _headView1InfoLabel.text = [NSString stringWithFormat:@"已答%d题，用时%d分%d秒",[[YHSAAnswerQuestionManager sharedTheSingletion] hadAnswerCount],[YHSAAnswerQuestionManager sharedTheSingletion].currentTime/60,[YHSAAnswerQuestionManager sharedTheSingletion].currentTime%60];
    } timer:1 andName:@"update"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[YHBaseTimerManager sharedTheSingletion]removeActionForName:@"update"];
}

-(void)dealloc{
   
   
}

-(void)YHCreatDate{
    _btnArray = [[NSMutableArray alloc]init];
}


-(void)YHCreatView{
    self.title=EXAM_ANSWER_PAGER_CONTROLLER_TITLE;
    _headView1 = [[YHBaseView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    _headView2 = [[YHBaseView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    //创建两个视图
    [self creatHeadView];
    if ([YHSAAnswerQuestionManager sharedTheSingletion].hadHeanIn) {
        [self.view addSubview:_headView2];
    }else{
        [self.view addSubview:_headView1];
    }
   
    
    _bodyView = [[YHBaseScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50)];
    //创建按钮
    [self creatBtn];
    [self.view addSubview:_bodyView];
    //创建确定交卷的
    UIBarButtonItem * cetttainItem = [[UIBarButtonItem alloc]init];
    cetttainItem.title = EXAM_ANSWER_PAGER_CERTAIN_BTN_TEXT;
    [cetttainItem setTarget:self];
    [cetttainItem setAction:@selector(certainClick)];
    self.navigationItem.rightBarButtonItem = cetttainItem;
}


-(void)creatHeadView{
    _headView1InfoLabel = [[YHBaseLabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 5, 200, 40)];
    _headView1InfoLabel.textAlignment = NSTextAlignmentCenter;
    [_headView1 addSubview:_headView1InfoLabel];
    
    _headView2InfoLabel = [[YHBaseLabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 5, 200, 40)];
    _headView2InfoLabel.text = [NSString stringWithFormat:@"您的用时:%d分%d秒", [YHSAAnswerQuestionManager sharedTheSingletion].currentTime/60, [YHSAAnswerQuestionManager sharedTheSingletion].currentTime%60];
    _headView1InfoLabel.textAlignment = NSTextAlignmentCenter;
    [_headView2 addSubview:_headView2InfoLabel];
   
    
    
}




-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _headView1.backgroundColor=manager.bgColor;
    _headView2.backgroundColor=manager.bgColor;
    _headView1InfoLabel.backgroundColor=manager.bgColor;
    _headView1InfoLabel.textColor=manager.textColor;
    _headView2InfoLabel.backgroundColor=manager.bgColor;
    _headView2InfoLabel.textColor=manager.textColor;
}


-(void)creatBtn{
    YHSAAnswerQuestionManager * answerManager = [YHSAAnswerQuestionManager sharedTheSingletion];
    
    for (int i=0; i<answerManager.dataArray.count; i++) {
        YHSAAnswerStateModel * model = answerManager.dataArray[i];
        YHBaseButton * btn = [YHBaseButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(10+((self.view.frame.size.width-20)/5)*(i%5)+((self.view.frame.size.width-20)/5)/2-25,5+60*(i/5), 50, 50);
        [btn setCornerRaidus:25];
        [btn setBorderWidth:1 andColor:[UIColor grayColor]];
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        if (model.hadAnswer) {
            [btn setBackgroundColor:[UIColor cyanColor]];
        }else{
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
        if (answerManager.currentIndex==i) {
            [btn setBackgroundColor:[UIColor blueColor]];
        }
        btn.index=i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_bodyView addSubview:btn];
        [_btnArray addObject:btn];
    }
    _bodyView.contentSize=CGSizeMake(_bodyView.frame.size.width, 5+60*(answerManager.dataArray.count/5)+50);
    [self reloadBtnColor];
}

-(void)click:(YHBaseButton *)btn{
    if (![[[YHSAAnswerQuestionManager sharedTheSingletion].dataArray objectAtIndex:btn.index] hadLoadDown]) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"您只能查看您已经预览过的题目" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    NSDictionary * info = @{@"index":[NSString stringWithFormat:@"%d",btn.index]};
    NSNotification * noti = [[NSNotification alloc]initWithName:YHSAAnswerQuestionManagerNotication object:nil userInfo:info];
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    //调整按钮颜色
    [self reloadBtnColor];
}
-(void)reloadBtnColor{
    YHSAAnswerQuestionManager * answerManager = [YHSAAnswerQuestionManager sharedTheSingletion];
    if (!answerManager.hadHeanIn) {
        for (int i=0; i<_btnArray.count; i++) {
            YHSAAnswerStateModel * model = answerManager.dataArray[i];
            YHBaseButton * btn = (YHBaseButton*)_btnArray[i];
            if (model.hadAnswer) {
                [btn setBackgroundColor:[UIColor cyanColor]];
            }else{
                [btn setBackgroundColor:[UIColor whiteColor]];
            }
            if (answerManager.currentIndex==i) {
                [btn setBackgroundColor:[UIColor blueColor]];
            }
            
        }
    }else{//已经交卷
        for (int i=0; i<_btnArray.count; i++) {
            YHSAAnswerStateModel * model = answerManager.dataArray[i];
            YHBaseButton * btn = (YHBaseButton*)_btnArray[i];
            if (model.isCorrect) {
                [btn setBackgroundColor:[UIColor greenColor]];
            }else{
                [btn setBackgroundColor:[UIColor redColor]];
            }
            if (answerManager.currentIndex==i) {
                [btn setBackgroundColor:[UIColor blueColor]];
            }
            
        }
    }
    
}

-(void)reloadHeadView{
    if ([YHSAAnswerQuestionManager sharedTheSingletion].hadHeanIn) {
        if ([_headView1.superview isKindOfClass:[self class]]) {
            [_headView1 removeFromSuperview];
        }
        [self.view addSubview:_headView2];
    }else{
        if ([_headView2.superview isKindOfClass:[self class]]) {
            [_headView2 removeFromSuperview];
        }
        [self.view addSubview:_headView1];
    }
}

#pragma mark - 提交试卷
-(void)certainClick{
    if (![YHSAUserManager sharedTheSingletion].isLogin) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"该功能需要您登陆方可使用" cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:nil andSelectFunc:nil];
        return ;
        
    }
    
    
    YHSAAnswerQuestionManager * manager = [YHSAAnswerQuestionManager sharedTheSingletion];
    __BLOCK__WEAK__SELF__(__self);
    [YHBaseAlertView  showWithStyle:YHBaseAlertViewNormal title:PUBLIC_PART_ALERT_TITLE text:@"是否确定提交试卷" cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:PUBLIC_PART_ALERT_SELECT_BTN andSelectFunc:^{
        //提交试卷
        for (int i=0; i<manager.dataArray.count; i++) {
            YHSAAnswerStateModel * model = manager.dataArray[i];
            if (model.hadAnswer==NO) {
                [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"请您答完所有的题目后再提交哦" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
                return ;
            }
        }
        //进行数据的提交
        [__self postExam];
        //关计时
        [[YHSAAnswerQuestionManager sharedTheSingletion]stopTimer];
        
    }];
}
-(void)postExam{
    //进行遍历取数据
    YHSAAnswerQuestionManager * manager = [YHSAAnswerQuestionManager sharedTheSingletion];
    NSArray * dataArray = manager.dataArray;
    NSMutableArray * postArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<dataArray.count; i++) {
        YHSAAnswerStateModel * model = (YHSAAnswerStateModel *)dataArray[i];
        NSString * answerStr;
        if ([[model.info objectForKey:@"type"]intValue]==2) {
            answerStr=YHBaseInsertCharater(@",", [model.info objectForKey:@"ans"]);
        }else{
            answerStr= [model.info objectForKey:@"ans"];
        }
        NSDictionary * dic = @{INTERFACE_FIELD_POST_EXAM_PHONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_POST_EXAM_EXAM_ID:manager.examID,INTERFACE_FIELD_POST_EXAM_QUESTION_ID:model.questionID,INTERFACE_FIELD_POST_EXAM_ANSWER:answerStr,INTERFACE_FIELD_POST_EXAM_SORCE:model.sccore};
        [postArray addObject:dic];
    }
    NSDictionary * dic = @{INTERFACE_FIELD_POST_EXAM_MAIN:[postArray transToJsonString:YHBaseJosnStyleNoneSpace|YHBaseJosnStyleNoneWarp|YHBaseJosnStyleSinglequotationMark|YHBaseJosnStyleNoneKeyMark]};
    
    //进行提交网络请求
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    __BLOCK__WEAK__SELF__(__self);
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeExamPost infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        NSDictionary * info = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARecordsModel * model = [[YHSARecordsModel alloc]init];
        [model creatModelWithDic:info];
        if ([model.resultCode intValue] == [INTERFACE_RETURN_POST_RECORD_SUCCESS intValue]) {
            //提交成功
            //创建成绩单
            YHSARecordsViewController * con = [[YHSARecordsViewController alloc]init];
            con.time = [YHSAAnswerQuestionManager sharedTheSingletion].currentTime;
            con.sorce = [model.score intValue];
            [YHSAAnswerQuestionManager sharedTheSingletion].hadHeanIn=YES;
            [__self presentViewController:con animated:YES completion:^{
                //进行界面的重构等操作
                [__self reloadBtnColor];
                [__self reloadHeadView];
            }];
        }else if ([model.resultCode intValue]==[INTERFACE_RETURN_POST_RECORD_FAILED intValue]){
            [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"抱歉，提交失败" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
