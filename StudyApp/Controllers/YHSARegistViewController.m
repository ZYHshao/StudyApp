//
//  YHASRegistViewController.m
//  
//
//  Created by user on 15/8/17.
//
//

#import "YHSARegistViewController.h"
#import "YHSAHttpManager.h"
#import "YHSARegustGetDataModel.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSALoginViewController.h"

@interface YHSARegistViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *secertLabel;
@property (weak, nonatomic) IBOutlet UITextField *secretTextFIeld;
@property (weak, nonatomic) IBOutlet UILabel *reWriteSecretLabel;
@property (weak, nonatomic) IBOutlet UITextField *reWeiteSecretTextField;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *questionTestField;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;


@end

@implementation YHSARegistViewController
- (IBAction)toRegist:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:YHTopicChangeTopicNotication object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}
#pragma mark - 视图搭建部分
-(void)YHCreatView{
    self.title = REGIST_CONTROLLER_TITLE;
    _schoolLabel.text = REGIST_SCHOOL_TEXT;
    _schoolTextField.placeholder = REGIST_SCHOOL_FIELD_PLACEHOLDER_TEXT;
    _phoneLabel.text = REGIST_PHONE_TEXT;
    _phoneTextField.placeholder = REGIST_PHONE_FIELD_PLACEHOLDER_TEXT;
    _secertLabel.text = REGIST_SECERT_TEXT;
    _secretTextFIeld.placeholder = REGIST_SECERT_REWRITE_FIELD_PLACEHOLDER_TEXT;
    _reWriteSecretLabel.text = REGIST_SECERT_TEXT;
    _reWeiteSecretTextField.placeholder = REGIST_SECERT_REWRITE_FIELD_PLACEHOLDER_TEXT;
    _questionLabel.text = REGIST_QUESTION_TEXT;
    _questionTestField.placeholder = REGIST_ANSWER_FIELD_PLACEHOLDER_TEXT;
    [_registBtn setTitle:REGIST_BUTTON_TEXT forState:UIControlStateNormal];
    _registBtn.layer.masksToBounds=YES;
    _registBtn.layer.cornerRadius=6;
    [_registBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    //适配不同屏幕大小与滚动视图相关设置
    _scrollView.contentSize = CGSizeMake(0, 480);
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * model = [YHTopicColorManager sharedTheSingletion];
    [model getTopicModel];
    self.view.backgroundColor = model.bgColor;
    _schoolLabel.textColor = model.textColor;
    _phoneLabel.textColor = model.textColor;
    _secertLabel.textColor = model.textColor;
    _reWriteSecretLabel.textColor = model.textColor;
    _questionLabel.textColor = model.textColor;
    _answerLabel.textColor = model.textColor;
    _registBtn.backgroundColor = model.btnColor;
    [_registBtn setTitleColor:model.btnTextColor forState:UIControlStateNormal];
    
}


#pragma mark - 逻辑功能部分

-(void)regist{
    //进行本地检测
    //手机号检测
    if (!YHBaseCheckString(YHBaseStringCompareEqual, _phoneTextField.text, 11)) {
        //弹出警告
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"您输入的手机号码有误,请重新输入" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    //院校检测,密保问题和答案检测
    if ([self isUnableString:_schoolTextField.text]&&[self isUnableString:_questionTestField.text]&&[self isUnableString:_answerTextField.text]) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"请您输入正确的信息(不超过20的字符)" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    if (YHBaseCheckString(YHBaseStringCompareShorter, _secretTextFIeld.text, 6)) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"密码长度需不小于6位,请重新输入" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    if (![_secretTextFIeld.text isEqualToString:_reWeiteSecretTextField.text]) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"两次输入的密码不同,请您重新输入" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    //发起注册请求
    [self creatRegistRequest];
    [self resignFirstKB];
}

-(void)creatRegistRequest{
    //拼接字段
    NSDictionary * dic = @{INTERFACE_FIELD_REGIST_COLLEAGE:_schoolTextField.text,INTERFACE_FIELD_REGIST_PHONECODE :_phoneTextField.text,INTERFACE_FIELD_REGIST_PASSWORD:_secretTextFIeld.text,INTERFACE_FIELD_REGIST_QUESTION:_questionTestField.text,INTERFACE_FIELD_REGIST_ANSWER:_answerTextField.text};
    //添加等待界面
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeRegist infoDic:dic Succsee:^(NSData *data) {
       //解析数据
        NSDictionary * dataDic = [NSDictionary dictionaryWithDictionary:[YHBaseJOSNAnalytical dictionaryWithJSData:data]];
        YHSARegustGetDataModel * model = [[YHSARegustGetDataModel alloc]init];
        [model creatModelWithDic:dataDic];
        if ([model.resultCode intValue]==[INTERFACE_RETURN_REGIST_SUCCESS intValue]) {
            //跳转登陆界面
            __BLOCK__WEAK__SELF__(__self);
            [YHBaseAlertView showWithStyle:YHBaseAlertViewNormal title:PUBLIC_PART_ALERT_TITLE text:@"恭喜您注册成功!" cancleBtn:@"返回" selectBtn:@"立即登陆" andSelectFunc:^{
                [[__self navigationController] pushViewController:[[YHSALoginViewController alloc]init] animated:YES];
            }];
            
        }else if ([model.resultCode intValue] ==[INTERFACE_RETURN_REGIST_FAILED intValue]){
            [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"注册失败:用户名已经存在" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        }
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } andFail:^(YHBaseError *error) {
          [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        //处理个性，总体会在异常中心处理
    } isbuffer:NO];
    
}

//位数检测

-(BOOL)isUnableString:(NSString *)str {
    if (YHBaseCheckString(YHBaseStringCompareShorter, str, 20)&&str.length!=0) {
        return NO;
    }
    return YES;
}





#pragma mark - 优化部分
//为了不被挡住视图，做如下操作
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag>302&&textField.tag<305) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=CGRectMake(0, -100, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }else if (textField.tag>=305){
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=CGRectMake(0, -200, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstKB];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)resignFirstKB{
    [_schoolTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_secretTextFIeld resignFirstResponder];
    [_reWeiteSecretTextField resignFirstResponder];
    [_questionTestField resignFirstResponder];
    [_answerTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}


//手机号码检测
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length==0) {
        return YES;
    }
    if (textField==_phoneTextField) {
        if (([string characterAtIndex:0]<'0')||([string characterAtIndex:0]>'9')) {
            return NO;
        }
    }
    return YES;
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
