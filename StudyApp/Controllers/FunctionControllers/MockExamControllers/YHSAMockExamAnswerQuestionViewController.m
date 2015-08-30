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
@interface YHSAMockExamAnswerQuestionViewController ()<YHSACoreAnswerQuestionScrollViewDelegate>
{
    //核心的滑动视图
    YHSACoreAnswerQuestionScrollView * _coreScrollView;
    YHBaseSelfServiceDrawControlView * _draftView;
    BOOL _draftIsOpen;
    //播放音频的按钮
    UIBarButtonItem * _audioButton;
    UIBarButtonItem * _draftButton;
    //核心音频组件
    YHBaseAVPlayer * _avPlayer;
}
@end

@implementation YHSAMockExamAnswerQuestionViewController
-(void)dealloc{
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
}
-(void)YHCreatView{
    _coreScrollView = [[YHSACoreAnswerQuestionScrollView alloc]initWithFrame:self.view.frame];
    _coreScrollView.dataDelegate=self;
    _coreScrollView.viewClass = [YHSACoreAnswerQuestionView class];
    _coreScrollView.dataModel=_dataModel;
    [_coreScrollView reloadView];
    [self.view addSubview:_coreScrollView];
    //创建导航按钮
    [self creatBarButton];
    _draftView = [[YHBaseSelfServiceDrawControlView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [_draftView setDrawSettingOfWidth:3 andColor:[UIColor redColor]];
    [_draftView setDrawSize:CGSizeMake(1000, 1000)];
    _draftView.backgroundColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:0.3];
    [_draftView setDrawViewBackgroundColor:[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:0.3]];
    _draftView.alpha=0;
    [self.view addSubview:_draftView];
}


-(void)creatBarButton{
     _draftButton= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:MOCK_EXAM_DRAFT_IMAGE] style:UIBarButtonItemStylePlain target:self action:@selector(draft)];
    _audioButton = [[UIBarButtonItem alloc]init];
    _audioButton.target=self;
    _audioButton.action = @selector(playAudio);
    _audioButton.image = [[UIImage imageNamed:MOCK_EXAM_PREPARE_IMAGE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
-(void)draft{
    if (_draftIsOpen) {
        [UIView animateWithDuration:0.3 animations:^{
            _draftView.alpha=0;
        }];
        _draftIsOpen=NO;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _draftView.alpha=1;
        }];
        _draftIsOpen=YES;
    }
}
-(void)useYHTopicToCreatViewWithModel{
    [_coreScrollView setTopic];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
