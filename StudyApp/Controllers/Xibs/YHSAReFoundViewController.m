//
//  YHSAReFoundViewController.m
//  
//
//  Created by user on 15/8/20.
//
//

#import "YHSAReFoundViewController.h"
#import "YHSAHttpManager.h"
#import "YHSARequestGetDataModel.h"
@interface YHSAReFoundViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet YHBaseLabel *phoneLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *questionLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *answerLabel;
@property (weak, nonatomic) IBOutlet YHBaseLabel *theNewSecret;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewSecretTextFIeld;
@property (weak, nonatomic) IBOutlet YHBaseButton *commitBtn;

@end

@implementation YHSAReFoundViewController


#pragma mark - 构建视图 
-(void)YHCreatView{
    _phoneLabel.text = REFOUND_PHONE_TEXT;
    _phoneTextField.placeholder = REFOUND_PHONR_TEXT_FIELD_PLACEHOLDER_TEXT;
    _questionLabel.text = REFOUND_QUESTION_TEXT;
    _questionTextField.placeholder = REFOUND_QUESTION_TEXT_FIELD_PLACEHOLDER_TEXT;
    _answerLabel.text = REFOUND_ANSWER_TEXT;
    _answerTextField.placeholder = REFOUND_ANSWER_TEXT_FIELD_PLACEHOLDER_TEXT;
    _theNewSecret.text = REFOUND_NEWSECRET_TEXT;
    _theNewSecretTextFIeld.placeholder = REFOUND_NEWSECRET_TEXT_FIELD_PLACEHOLDER_TEXT;
    [_commitBtn setTitle:REFOUND_COMMIT_BUTTON_TITLE forState:UIControlStateNormal];
    [_commitBtn setCornerRaidus:6];
}


-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * model = [YHTopicColorManager sharedTheSingletion];
    [model getTopicModel];
    self.view.backgroundColor = model.bgColor;
    _phoneLabel.textColor = model.textColor;
    _questionLabel.textColor = model.textColor;
    _answerLabel.textColor = model.textColor;
    _theNewSecret.textColor = model.textColor;
    _commitBtn.backgroundColor = model.btnColor;
    [_commitBtn setTitleColor:model.btnTextColor forState:UIControlStateNormal];
}




#pragma mark - 逻辑处理
- (IBAction)commitInfo:(YHBaseButton *)sender {
    //输入的判断
    if (!YHBaseCheckString(YHBaseStringCompareEqual, _phoneTextField.text, 11)) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"请输入正确的手机号码" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    if (_questionTextField.text.length==0||_answerTextField.text.length==0) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"请填写完整的信息" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    if (_theNewSecretTextFIeld.text.length<6) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"密码长度必须大于6位" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    //进行请求
    [self creatRequest];
}

-(void)creatRequest{
    //拼接参数字典
    NSDictionary * dict = @{INTERFACE_FIELD_CHANGE_SECRET_PHONECADE:_phoneTextField.text,INTERFACE_FIELD_CHANGE_SECRET_QUESTION:_questionTextField.text,INTERFACE_FIELD_CHANGE_SECRET_ANSWER:_answerTextField.text,INTERFACE_FIELD_CHANGE_SELECT_NEWPASS:_theNewSecretTextFIeld.text};
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeReFoundSecret infoDic:dict Succsee:^(NSData *data) {
        //解析
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
        [model creatModelWithDic:dataDic];
        //逻辑判断
        __BLOCK__WEAK__SELF__(__self);
        if ([model.resultCode intValue] == [INTERFACE_RETURN_CHANGE_SECRET_SUCCESS intValue]) {
            //修改成功
            [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"恭喜您修改成功" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
            [[__self navigationController] popViewControllerAnimated:YES];
        }else if([model.resultCode intValue] == [INTERFACE_RETURN_CHANGE_SECRET_FAILED intValue]){
             [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"对不起，您输入的信息有误!" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        }
    } andFail:^(YHBaseError *error) {
        
    } isbuffer:NO];
}


#pragma mark - textFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //账号的输入检测
    if (textField==_phoneTextField) {
        if (string.length>0) {
            if (([string characterAtIndex:0]<'0')||([string characterAtIndex:0]>'9')) {
                return NO;
            }
        }
    }
    return YES;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
