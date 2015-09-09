//
//  MianToolsViewController.m
//  
//
//  Created by user on 15/8/18.
//
//

#import "YHSAMainToolsViewController.h"
#import "YHSAUserManager.h"
#import "YHSALoginViewController.h"
#import "YHSAMockExamController.h"
#import "YHSASystemSettingViewController.h"
@interface YHSAMainToolsViewController ()
{
    //循环创建控件，将其引用存在数组中
    NSArray * _imageArray;
    NSArray * _titleTextArray;
    NSMutableArray * _titleLabelArray;
    NSArray * _controllersArray;
}
@end

@implementation YHSAMainToolsViewController

-(void)dealloc{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)YHCreatDate{
    _imageArray = @[MAIN_MYTEXT_IMAGE,MAIN_WRONG_NOTES_IMAGE,MAIN_WRONG_TEXT_IMAGE,
                    MAIN_MY_COLLECT_IMAGE,MAIN_MY_ANALYSE_IMAGE,MAIN_STUDY_PIAN_IMAGE,
                    MAIN_MY_NOTES_IMAGE,MAIN_TEXT_INFOMATION_IMAGE,MAIN_SYSTEMSET_IMAGE];
    
    _titleTextArray = @[MAIN_MYTEXT_TEXT,MAIN_WRONG_NOTES_TEXT,MAIN_WRONG_TEXT_TEXT,
                        MAIN_MY_COLLECT_TEXT,MAIN_MY_ANALYSE_TEXT,MAIN_STUDY_PIAN_TEXT,
                        MAIN_MY_NOTES_TEXT,MAIN_TEXT_INFOMATION_TEXT,MAIN_SYSTEMSET_TEXT];
    _titleLabelArray = [[NSMutableArray alloc]init];
    _controllersArray = @[@"YHSAMockExamController",@"YHSAWrongRecordViewController",@"",@"QuestionCollectViewController",@"YHSAAchievementAnalyseViewController",@"YHSAStudyPlanViewController",@"YHSAStudyNoteViewController",@"YHSAExamInfoViewController",@"YHSASystemSettingViewController"];
}

-(void)YHCreatView{
    self.title = MAIN_CONTROLLER_TITLE;
    float btnWid = (SCREEN_WIDTH-LAYOUT_OFFSET_LEFT-LAYOUT_OFFSET_RIGHT)/3-20;
    __BLOCK__WEAK__SELF__(__self);
    for (int i = 0; i < 9; i++) {
        YHBaseButton * btn = [[YHBaseButton alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT+10+i%3*(btnWid+20), 40+i/3*(btnWid+50), btnWid, btnWid) backgroundImage:[UIImage imageNamed:_imageArray[i]] backgroundColor:nil textColor:nil titleText:nil andClickBlock:^(YHBaseButton *btn) {
            if (i==3) {
                 [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"本功能暂不可用,期待您的支持，我们将继续开发" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
                return ;
            }
            //界面跳转处理
            //判断是否是登陆必须项
            if ( (i>=1)&&(i<=6)&&i!=3) {
                if (![YHSAUserManager sharedTheSingletion].isLogin) {
                    [YHBaseAlertView showWithStyle:YHBaseAlertViewNormal title:PUBLIC_PART_ALERT_TITLE text:@"该功能需要您登陆方可使用" cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:@"登陆" andSelectFunc:^{
                       //跳转登陆
                        [[__self navigationController]pushViewController:[[YHSALoginViewController alloc]init] animated:YES];
                    }];
                    return ;
                }
            }
            //相应功能跳转
            //动态跳转
            Class cls = NSClassFromString(_controllersArray[i]);
            UIViewController * temC = [[cls alloc]init];
            [[__self navigationController]pushViewController:temC animated:YES];
            
            }];
        [self.view addSubview:btn];
        
        //创建label
        YHBaseLabel * label = [[YHBaseLabel alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT+10+i%3*(btnWid+20), 55+btnWid+i/3*(btnWid+50), btnWid, 25) title:_titleTextArray[i] textColor:nil backgroundColor:nil andAlignment:NSTextAlignmentCenter];
        [self.view addSubview:label];
        [_titleLabelArray addObject:label];
    }
}

-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * model = [YHTopicColorManager sharedTheSingletion];
    [model getTopicModel];
    self.view.backgroundColor = model.bgColor;
    for (int i=0; i<_titleLabelArray.count; i++) {
        YHBaseLabel * label = (YHBaseLabel *)[_titleLabelArray objectAtIndex:i];
        label.textColor = model.textColor;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
