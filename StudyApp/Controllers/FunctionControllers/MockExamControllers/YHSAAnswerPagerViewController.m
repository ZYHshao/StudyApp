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
@interface YHSAAnswerPagerViewController ()
{
    //标头视图
    YHBaseView * _headView;
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

-(void)dealloc{
   
}

-(void)YHCreatDate{
    _btnArray = [[NSMutableArray alloc]init];
}


-(void)YHCreatView{
    _headView = [[YHBaseView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [self.view addSubview:_headView];
    
    _bodyView = [[YHBaseScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50)];
    //创建按钮
    [self creatBtn];
    [self.view addSubview:_bodyView];
}

-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
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
