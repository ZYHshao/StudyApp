//
//  MianToolsViewController.m
//  
//
//  Created by user on 15/8/18.
//
//

#import "YHSAMainToolsViewController.h"

@interface YHSAMainToolsViewController ()
{
    //循环创建控件，将其引用存在数组中
    NSArray * _imageArray;
    NSArray * _titleTextArray;
    NSMutableArray * _titleLabelArray;
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
}

-(void)YHCreatView{
    self.title = MAIN_CONTROLLER_TITLE;
    float btnWid = (SCREEN_WIDTH-LAYOUT_OFFSET_LEFT-LAYOUT_OFFSET_RIGHT)/3-20;
    for (int i = 0; i < 9; i++) {
        YHBaseButton * btn = [[YHBaseButton alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT+10+i%3*(btnWid+20), 40+i/3*(btnWid+50), btnWid, btnWid) backgroundImage:[UIImage imageNamed:_imageArray[i]] backgroundColor:nil textColor:nil titleText:nil andClickBlock:^(YHBaseButton *btn) {
            //界面跳转处理
            }];
        [self.view addSubview:btn];
        
        //创建label
        YHBaseLabel * label = [[YHBaseLabel alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT+10+i%3*(btnWid+20), 55+btnWid+i/3*(btnWid+50), btnWid, 25) title:_titleTextArray[i] textColor:nil backgroundColor:nil andAlignment:NSTextAlignmentCenter];
        [self.view addSubview:label];
        [_titleLabelArray addObject:label];
    }
}

-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorModel * model = [YHTopicColorModel sharedTheSingletion];
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
