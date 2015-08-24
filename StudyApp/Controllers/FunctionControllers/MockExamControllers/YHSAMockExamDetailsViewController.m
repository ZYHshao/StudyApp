//
//  YHSAMockExamDetailsViewController.m
//  StudyApp
//
//  Created by apple on 15/8/23.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAMockExamDetailsViewController.h"
#import "YHSAMockExamDetailsModel.h"
#import "YHSAHttpManager.h"
#import "YHSAMockExamDetailsModel.h"
#import "YHSAMockExamAnswerQuestionViewController.h"
#import "YHSAActivityIndicatorView.h"
@interface YHSAMockExamDetailsViewController ()
@property (weak, nonatomic) IBOutlet YHBaseLabel *examTitleLabel;
@property (weak, nonatomic) IBOutlet YHBaseButton *startExamButton;
@property (weak, nonatomic) IBOutlet YHBaseButton *collectExamButton;
@property (weak, nonatomic) IBOutlet YHBaseLabel *dividingLine;
@property (weak, nonatomic) IBOutlet YHBaseLabel *examQuestionCountLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *ExamTypeLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *publicDateLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *examSourceLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *providerLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *examSubjectLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *dividingLineBottom;

__PROPERTY_NO_STRONG__(YHSAMockExamDetailsModel *, dataModel);

@end

@implementation YHSAMockExamDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)YHCreatDate{
    //参数字典
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    NSDictionary * dic = @{INTERFACE_FIELD_MOCKEXAM_EXAMID:_examID};
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamDetails infoDic:dic Succsee:^(NSData *data) {
        YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
        NSDictionary * temDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        [model creatModelWithDic:temDic];
        if ([model.resultCode intValue]==[INTERFACE_RETURN_MOCKEXAM__DETAILS_SUCCESS intValue]) {
            //下载成功 处理数据
            _dataModel = [[YHSAMockExamDetailsModel alloc]init];
            [_dataModel creatModelWithDic:[model.data firstObject]];
        }
        [self YHCreatView];
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}


-(void)YHCreatView{
    self.title = MOCK_EXAM_DETAILS_CONTROLLER_TITLE;
    _examTitleLabel.text = _dataModel.examname;
    [_startExamButton setTitle:MOCK_EXAM_DETAILS_START_BUTTON_TITLE forState:UIControlStateNormal];
    [_startExamButton setCornerRaidus:6];
    [_collectExamButton setTitle:MOCK_EXAM_DETAILS_COLLECT_BUTTON_TITLE forState:UIControlStateNormal];
    [_collectExamButton setCornerRaidus:6];
    _examQuestionCountLabel.text = [NSString stringWithFormat:MOCK_EXAM_DETAILS_QUESTION_COUNT_LABEL_TEXT,[_dataModel.questioncount intValue]];
    _ExamTypeLabel.text = [NSString stringWithFormat:MOCK_EXAM_DETAILS_TYPE_LABEL_TEXT,_dataModel.examtype];
    _publicDateLabel.text = [NSString stringWithFormat:MOCK_EXAM_DETAILS_DATE_LABEL_TEXT,_dataModel.examdate];
    _examSourceLabel.text = [NSString stringWithFormat:MOCK_EXAM_DETAILS_SOURCE_LABEL_TEXT,[_dataModel.examscore intValue]];
    _providerLabel.text = [NSString stringWithFormat:MOCK_EXAM_DETAILS_AUTHOR_LABEL_TEXT,_dataModel.author];
    _examSubjectLabel.text = [NSString stringWithFormat:MOCK_EXAM_DETAILS_SUBJECT_LABEL_TEXT,_dataModel.subject];
    
}


-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _examTitleLabel.textColor = manager.textColor;
    _startExamButton.backgroundColor = manager.btnColor;
    [_startExamButton setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
    _collectExamButton.backgroundColor = manager.bgColor;
    [_collectExamButton setTitleColor:manager.textColor forState:UIControlStateNormal];
    [_collectExamButton setBorderWidth:2 andColor:manager.borderLineColor];
    _dividingLine.textColor = manager.borderLineColor;
    _examQuestionCountLabel.textColor = manager.borderLineColor;
    _ExamTypeLabel.textColor = manager.borderLineColor;
    _publicDateLabel.textColor = manager.borderLineColor;
    _examSourceLabel.textColor = manager.borderLineColor;
    _providerLabel.textColor = manager.borderLineColor;
    _examSubjectLabel.textColor = manager.borderLineColor;
    _dividingLineBottom.textColor = manager.borderLineColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickButton:(YHBaseButton *)sender {
    if (sender == _startExamButton) {
        //跳转答题界面
        YHSAMockExamAnswerQuestionViewController * con = [[YHSAMockExamAnswerQuestionViewController alloc]init];
        con.dataModel = _dataModel;
        [self.navigationController pushViewController:con animated:YES];
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
