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
        case 0:
        {
            [_listView closeList];
        }
            break;
        case 1:
        {
            [_listView closeList];
        }
            break;
        case 2:
        {
            [_listView closeList];
            
        }
            break;
        case 3:
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
        case 6://天加笔记
        {
            
            [_listView closeList];
        }
            break;
        default:
            break;
    }
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
