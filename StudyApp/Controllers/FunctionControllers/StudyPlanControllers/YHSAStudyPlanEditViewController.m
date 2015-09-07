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
#import "YHSAUserManager.h"
@interface YHSAStudyPlanEditViewController ()<UITextViewDelegate>
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
    if (_style==YHSAStudyPlanEditViewControllerStyleDetails||_style==YHSAStudyPlanEditViewControllerStyleEdit) {
        //取数据
        NSDictionary * dic = @{INTERFACE_FIELD_POST_STUDY_PLAN_STATUS:INTERFACE_FIELD_POST_DETAILS_STUDY_PLAN_STATUS,INTERFACE_FIELD_POST_STUDY_PLAN_ID:_planId};
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeStudyPlanDetails infoDic:dic Succsee:^(NSData *data) {
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
    }else if (_style==YHSAStudyPlanEditViewControllerStyleAdd){
        
    }
}

-(void)YHCreatView{
    _theButton.layer.masksToBounds=YES;
    _theButton.layer.cornerRadius=6;
    _contentTextView.layer.borderWidth=1;
    _contentTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    if (_style==YHSAStudyPlanEditViewControllerStyleDetails) {
        self.title = STUDY_PLAN_DETAILS_CONTROLLER_TITLE;
        _titleTextField.borderStyle = UITextBorderStyleNone;
        _titleTextField.enabled=NO;
        _titleTextField.text=_dataModel.title;
        
        _contentTextView.editable = NO;
        _contentTextView.text = _dataModel.content;
        _theButton.hidden=YES;
    }else if (_style==YHSAStudyPlanEditViewControllerStyleAdd){
        self.title = STUDY_PLAN_ADD_CONTROLLER_TITLE;
        _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        _titleTextField.placeholder=@"请填写标题";
        _titleTextField.enabled=YES;
        _contentTextView.placeHolder = @"请填写计划内容";
        _theButton.hidden=NO;
        [_theButton setTitle:@"添加" forState:UIControlStateNormal];
    }else if (_style==YHSAStudyPlanEditViewControllerStyleEdit){
        self.title = STUDY_PLAN_DETAILS_CONTROLLER_TITLE;
        _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        _titleTextField.text=_dataModel.title;
        _contentTextView.text = _dataModel.content;
        [_theButton setTitle:@"修改" forState:UIControlStateNormal];
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
    if (_style==YHSAStudyPlanEditViewControllerStyleAdd) {
     //判断
        if (_titleTextField.text.length==0||_contentTextView.text.length==0) {
            [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"请完整计划标题和内容" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
            return;
        }else{
            //进行提交数据
            [self postData];
        }
    }else if (_style==YHSAStudyPlanEditViewControllerStyleEdit){
        [self postEdit];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    __BLOCK__WEAK__SELF__(__self);
    [UIView animateWithDuration:0.3 animations:^{
        [[__self view] setFrame:CGRectMake(0, 24, [__self view].frame.size.width, [__self view].frame.size.height)];
    }];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text characterAtIndex:0]=='\n') {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    __BLOCK__WEAK__SELF__(__self);
    [UIView animateWithDuration:0.3 animations:^{
        [[__self view] setFrame:CGRectMake(0, 64, [__self view].frame.size.width, [__self view].frame.size.height)];
    }];
}



//添加计划请求
-(void)postData{
    NSDictionary * dic = @{INTERFACE_FIELD_POST_STUDY_PLAN_LIST_PLONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_POST_STUDY_PLAN_STATUS:INTERFACE_FIELD_POST_ADD_STUDY_NOTES_STATUS,INTERFACE_FIELD_POST_STUDY_PLAN_TITLE:_titleTextField.text,INTERFACE_FIELD_POST_STUDY_PLAN_DATE:_dateStr,INTERFACE_FIELD_POST_STUDY_PLAN_CONTENT:_contentTextView.text};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeStudyPlanAdd infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
        [model creatModelWithDic:dataDic];
        __BLOCK__WEAK__SELF__(__self);
        if ([model.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_ADD_SUCCESS intValue]) {
            [YHBaseAlertView showWithStyle:YHBaseAlertViewNormal title:@"添加成功!" text:PUBLIC_PART_ALERT_TITLE cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:PUBLIC_PART_ALERT_SELECT_BTN andSelectFunc:^{
                [[__self navigationController ]popViewControllerAnimated:YES];
            }];
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}

//修改请求
-(void)postEdit{
    NSDictionary * dic = @{INTERFACE_FIELD_POST_STUDY_PLAN_STATUS:INTERFACE_FIELD_POST_UPDATE_STUDY_PLAN_STATUS,INTERFACE_FIELD_POST_STUDY_PLAN_TITLE:_titleTextField.text,INTERFACE_FIELD_POST_STUDY_PLAN_CONTENT:_contentTextView.text,INTERFACE_FIELD_POST_STUDY_PLAN_ID:_planId};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeStudyPlanAdd infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
        [model creatModelWithDic:dataDic];
        __BLOCK__WEAK__SELF__(__self);
        if ([model.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_ADD_SUCCESS intValue]) {
            [YHBaseAlertView showWithStyle:YHBaseAlertViewNormal title:@"修改成功!" text:PUBLIC_PART_ALERT_TITLE cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:PUBLIC_PART_ALERT_SELECT_BTN andSelectFunc:^{
                [[__self navigationController ]popViewControllerAnimated:YES];
            }];
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
