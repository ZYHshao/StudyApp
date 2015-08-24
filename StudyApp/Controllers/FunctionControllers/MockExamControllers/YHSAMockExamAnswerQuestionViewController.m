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
