//
//  YHSAStudyPlanEditViewController.m
//  
//
//  Created by user on 15/9/7.
//
//

#import "YHSAStudyPlanEditViewController.h"
#import "YHSAHttpManager.h"
#import "YHSARequestGetDataModel.h"
#import "YHSAStudyPlanDetailsModel.h"
#import "YHSAActivityIndicatorView.h"
@interface YHSAStudyPlanEditViewController ()
{
    YHSAStudyPlanDetailsModel * _dataModel;
}
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet YHBaseTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *theButton;

@end

@implementation YHSAStudyPlanEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)YHCreatDate{
    if (_style==YHSAStudyPlanEditViewControllerStyleDetails) {
        //取数据
        NSDictionary * dic = @{INTERFACE_FIELD_POST_STUDY_PLAN_STATUS:INTERFACE_FIELD_POST_DETAILS_STUDY_PLAN_STATUS,INTERFACE_FIELD_POST_STUDY_PLAN_ID:_planId};
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeStudyPlanList infoDic:dic Succsee:^(NSData *data) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
            NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
            [tmpModel creatModelWithDic:dataDic];
            if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_DETAILS_SUCCESS intValue]) {
                _dataModel = [[YHSAStudyPlanDetailsModel alloc]init];
                [_dataModel creatModelWithDic:[tmpModel.data objectAtIndex:0]];
                [self YHCreatView];
            }else if([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_DETAILS_FAILED intValue]){
                
            }
        } andFail:^(YHBaseError *error) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } isbuffer:NO];
    }
}

-(void)YHCreatView{
    _theButton.layer.masksToBounds=YES;
    _theButton.layer.cornerRadius=6;
    _contentTextView.layer.borderWidth=1;
    _contentTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    if (_style==YHSAStudyPlanEditViewControllerStyleDetails) {
        _titleTextField.borderStyle = UITextBorderStyleNone;
        _titleTextField.enabled=NO;
        _titleTextField.text=_dataModel.title;
        
        _contentTextView.editable = NO;
        _contentTextView.text = _dataModel.content;
        _theButton.hidden=YES;
    }
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _titleTextField.backgroundColor = manager.bgColor;
    _titleTextField.textColor = manager.textColor;
    _contentTextView.backgroundColor = manager.bgColor;
    _contentTextView.textColor = manager.textColor;
    _theButton.backgroundColor = manager.btnColor;
    [_theButton setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
}
- (IBAction)btnCick:(UIButton *)sender {
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
