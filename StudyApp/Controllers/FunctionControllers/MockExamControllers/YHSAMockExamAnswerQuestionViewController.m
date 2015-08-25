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
@interface YHSAMockExamAnswerQuestionViewController ()
{
    //核心的滑动视图
    YHSACoreAnswerQuestionScrollView * _coreScrollView;
    YHBaseSelfServiceDrawControlView * _draftView;
    BOOL _draftIsOpen;
}
@end

@implementation YHSAMockExamAnswerQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)YHCreatDate{
    
}
-(void)YHCreatView{
    _coreScrollView = [[YHSACoreAnswerQuestionScrollView alloc]initWithFrame:self.view.frame];
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
    UIBarButtonItem * draft = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:MOCK_EXAM_DRAFT_IMAGE] style:UIBarButtonItemStylePlain target:self action:@selector(draft)];
    self.navigationItem.rightBarButtonItem = draft;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
