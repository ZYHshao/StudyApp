//
//  YHSAMockExamAnswerQuestionViewController.m
//  
//
//  Created by user on 15/8/24.
//
//

#import "YHSAMockExamAnswerQuestionViewController.h"
#import "YHSACoreAnswerQuestionScrollView.h"
#import "YHSACoreAnswerQuestionView.h"
#import "YHSAAnswerQuestionModel.h"
#import "YHSAAnswerPagerViewController.h"
#import "YHSAAnswerQuestionManager.h"
#import "YHSAAnswerStateModel.h"
#import "YHSAEditStudyNoteViewController.h"
#import "YHSAUserManager.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSAHttpManager.h"
#import "YHSARecordsModel.h"
#import "YHSARecordsViewController.h"
@interface YHSAMockExamAnswerQuestionViewController ()<YHSACoreAnswerQuestionScrollViewDelegate,YHBaseListViewDelegate>
{
    //核心的滑动视图
    YHSACoreAnswerQuestionScrollView * _coreScrollView;
    YHBaseSelfServiceDrawControlView * _draftView;
    //播放音频的按钮
    UIBarButtonItem * _audioButton;
    UIBarButtonItem * _draftButton;
    //核心音频组件
    YHBaseAVPlayer * _avPlayer;
    //更多功能菜单
    YHBaseListView * _listView;
    NSArray * _toolsTitleArray;
    NSArray * _toolsImageArray;
}
@end

@implementation YHSAMockExamAnswerQuestionViewController
-(void)dealloc{
    [[YHSAAnswerQuestionManager sharedTheSingletion]clearData];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:YHBASE_ERROR_CENTER_NOTICATION object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [_coreScrollView updataView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)YHCreatDate{
    //创建播放器
    _avPlayer = [[YHBaseAVPlayer alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePlayer:) name:YHBASE_AVFOUNDATION_PLAYER_STATE object:nil];
    _toolsTitleArray = @[MOCK_EXAM_ANSWER_QUESTION_TOOLS_LOOK_ANSWER,
                        MOCK_EXAM_ANSWER_QUESTION_TOOLS_HAND_TEST,
                        MOCK_EXAM_ANSWER_QUESTION_TOOLS_COLLECT,
                        MOCK_EXAM_ANSWER_QUESTION_TOOLS_ANSWER_PAGER,
                        MOCK_EXAM_ANSWER_QUESTION_TOOLS_DRAFT,
                         MOCK_EXAM_ANSWER_QUESTION_TOOLS_NOTE,
                        MOCK_EXAM_ANSWER_QUESTION_TOOLS_MORE];
    _toolsImageArray = @[MOCK_EXAM_MORE_TOOLS_LOOK_ANSWER_IMAGE,
                         MOCK_EXAM_MORE_TOOLS_HAND_TEST_IMAGE,
                         MOCK_EXAM_MORE_TOOLS_COLLECT_IMAGE,
                         MOCK_EXAM_MORE_TOOLS_ANSWER_PAGER_IMAGE,
                         MOCK_EXAM_MORE_TOOLS_DRAFT_IMAGE,
                         MOCK_EXAM_MORE_TOOLS_NOTE_IMAGE,
                         MOCK_EXAM_MORE_TOOLS_SETTING];
    YHSAAnswerQuestionManager * manager = [YHSAAnswerQuestionManager sharedTheSingletion];
    //进行初始化 所有题都是未答题状态
    [manager clearData];
    manager.examID = _dataModel.examid;
    for (int i=0; i<[_dataModel.questioncount intValue]; i++) {
        YHSAAnswerStateModel * model = [[YHSAAnswerStateModel alloc]init];
        model.hadAnswer=NO;
        [manager.dataArray addObject:model];
    }
    manager.testTime=3600;
    [manager startTimer];
}
-(void)YHCreatView{
    self.title = MOCK_EXAM_ANSWER_QUESTION_CONTROLLER_TITLE;
    _coreScrollView = [[YHSACoreAnswerQuestionScrollView alloc]initWithFrame:self.view.frame];
    _coreScrollView.dataDelegate=self;
    _coreScrollView.viewClass = [YHSACoreAnswerQuestionView class];
    _coreScrollView.dataModel=_dataModel;
    [_coreScrollView reloadView];
    [self.view addSubview:_coreScrollView];
    //创建导航按钮
    [self creatBarButton];
    
    //创建菜单视图
    _listView = [[YHBaseListView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-140, 20, 120, 100)];
    _listView.delegate =self;
    //创建按钮
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i=0; i<7; i++) {
        YHBaseListViewItem * item = [[YHBaseListViewItem alloc]initWithTitle:_toolsTitleArray[i] titleImage:_toolsImageArray[i]];
        [array addObject:item];
    }
    _listView.itemsArray = array;
    [self.view addSubview:_listView];
    
    _draftView = [[YHBaseSelfServiceDrawControlView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [_draftView setDrawSettingOfWidth:3 andColor:[UIColor redColor]];
    [_draftView setDrawSize:CGSizeMake(1000, 1000)];
    _draftView.backgroundColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:0.3];
    [_draftView setDrawViewBackgroundColor:[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:0.3]];
    _draftView.alpha=0;
    [self.view addSubview:_draftView];
}


-(void)creatBarButton{
     _draftButton= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:MOCK_EXAM_MORE_TOOLS_IMAGE] style:UIBarButtonItemStylePlain target:self action:@selector(moreTools)];
    _audioButton = [[UIBarButtonItem alloc]init];
    _audioButton.target=self;
    _audioButton.action = @selector(playAudio);
    _audioButton.image = [[UIImage imageNamed:MOCK_EXAM_PREPARE_IMAGE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}








#pragma mark - more tools
-(void)moreTools{
    if (_listView.isShow) {
        [_listView closeList];
    }else{
        [_listView openList];
    }
}




-(void)draft{
    [_draftView open];
}
-(void)useYHTopicToCreatViewWithModel{
    [_coreScrollView setTopic];
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _listView.backgroundColor = manager.listBgColor;
    for (YHBaseListViewItem * item in _listView.itemsArray) {
        item.titleLabel.textColor = manager.btnTextColor;
    }
    
}
#pragma mark - coreScroll Deleagte
-(void)YHSACoreAnswerQuestionScrollViewEndScroll{
    YHSAAnswerQuestionModel * model = [_coreScrollView.dataArray objectAtIndex:_coreScrollView.currentPage];
    [_avPlayer stop];
     _audioButton.image = [[UIImage imageNamed:MOCK_EXAM_PREPARE_IMAGE]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //判断是否显示播放音频的按钮
    if ([[model listionUrl] length]>0) {
        self.navigationItem.rightBarButtonItems = @[_draftButton,_audioButton];
    }else{
        self.navigationItem.rightBarButtonItems = @[_draftButton];
    }
    
}

-(void)playAudio{
    YHSAAnswerQuestionModel * model = [_coreScrollView.dataArray objectAtIndex:_coreScrollView.currentPage];
    //进行判断
    if (_avPlayer.state==YHBaseAVPlayerStateStop) {
        //进行播放
        [_avPlayer preparePlayWithUrl:model.listionUrl];
        [_avPlayer play];
    }else if(_avPlayer.state==YHBaseAVPlayerStateLoading){
        [_avPlayer pause];
    }else if (_avPlayer.state==YHBaseAVPlayerStatePlaying){
        [_avPlayer pause];
    }else if (_avPlayer.state==YHBaseAVPlayerStatePause){
        [_avPlayer play];
    }
}

-(void)changePlayer:(NSNotification *)notice{
    NSDictionary * info = notice.userInfo;
    YHBaseAVPlayerState state = [[info objectForKey:@"state"] intValue];
    //进行按钮图片的更改
    switch (state) {
        case YHBaseAVPlayerStatePlaying:
        {
            _audioButton.image = [[UIImage imageNamed:MOCK_EXAM_PLAYING_IMAGE]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case YHBaseAVPlayerStateStop:
        {
            _audioButton.image = [[UIImage imageNamed:MOCK_EXAM_PREPARE_IMAGE]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case YHBaseAVPlayerStateLoading:
        {
            _audioButton.image = [[UIImage imageNamed:MOCK_EXAM_LOADING_IMAGE]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        case YHBaseAVPlayerStatePause:
        {
            _audioButton.image = [[UIImage imageNamed:MOCK_EXAM_PREPARE_IMAGE]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
            break;
        default:
            break;
    }
}
#pragma mark - listView delegate
-(void)YHBaseListViewClickAtIndex:(int)index{
    NSLog(@"%d",index);
    switch (index) {
        case 0://查看答案
        {
            [_listView closeList];
            [[[YHSAAnswerQuestionManager sharedTheSingletion].dataArray objectAtIndex:_coreScrollView.currentPage] setHadLookAnswer:YES];
            [_coreScrollView updataView];
        }
            break;
        case 1://交卷
        {
            //
            
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
            
            [_listView closeList];
        }
            break;
        case 2://进行添加收藏
        {
            [_listView closeList];
            [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"本功能暂不可用,期待您的支持，我们将继续开发" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
            
        }
            break;
        case 3://答题卡
        {
            [_listView closeList];
            YHSAAnswerPagerViewController * con = [[YHSAAnswerPagerViewController alloc]init];
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 4://稿纸
        {
            [self draft];
            [_listView closeList];
        }
            break;
        case 5://天加笔记
        {
            //判断登陆
            if (![YHSAUserManager sharedTheSingletion].isLogin) {
                [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"本功能必须登录才能使用!" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
            }else{
                YHSAEditStudyNoteViewController * con = [[YHSAEditStudyNoteViewController alloc]init];
                con.questionid = [_coreScrollView.dataArray[_coreScrollView.currentPage] id];
                [self.navigationController pushViewController:con animated:YES];
            }
            [_listView closeList];
        }
            break;
        case 6://更多设置
        {
            
            [_listView closeList];
        }
            break;
        default:
            break;
    }
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
            [__self presentViewController:con animated:YES completion:nil];
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
