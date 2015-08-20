//
//  YHSALoginViewController.m
//  
//
//  Created by user on 15/8/17.
//
//

#import "YHSALoginViewController.h"
#import "YHSARegistViewController.h"
#import "YHSAHttpManager.h"
#import "YHSARegustGetDataModel.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSAUserManager.h"
#import "YHSASystemSettingManager.h"
#import "YHSAReFoundViewController.h"
@interface YHSALoginViewController ()<UITextFieldDelegate>
{
    UIImageView * _userNameImageView;
    UILabel     * _userNameLabel;
    UIImageView * _userSecretImageView;
    UILabel     * _userSecretLabel;
    UITextField * _userNameTestField;
    UITextField * _userSecretTestField;
    UIButton    * _shouldAutoLoginBtn;
    UILabel     * _shouldAutoLoginLabel;
    UIButton    * _loginBtn;
    UIButton    * _registBtn;
    UIButton    * _refindSecretBtn;
}
@end

@implementation YHSALoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)YHCreatView{
    self.title=LOGIN_CONTROLLER_TITLE;
    _userNameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT, 40,20, 20)];
    _userNameImageView.image = [UIImage imageNamed:LOGININ_USER_NAME_IMAGE];
    [self.view addSubview:_userNameImageView];
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT+25, 40, 60, 20)];
    _userNameLabel.font = [UIFont systemFontOfSize:TEXT_FONT_SIZE_NORMAL];
    _userNameLabel.text = LOGIN_USERNAME_LABEL;
    _userNameLabel.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_userNameLabel];
    
    _userNameTestField = [[UITextField alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT, 75, SCREEN_WIDTH-LAYOUT_OFFSET_LEFT-LAYOUT_OFFSET_RIGHT, 40)];
    _userNameTestField.placeholder = LOGIN_USERNAME_TEXTFIELD_PlACEHOLDER_TEXT;
    _userNameTestField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTestField.keyboardType = UIKeyboardTypePhonePad;
    //获取最近登陆的用户名
    _userNameTestField.text = [YHSASystemSettingManager sharedTheSingletion].defaultUserName;
    [self.view addSubview:_userNameTestField];
    
    _userSecretImageView = [[UIImageView alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT, 130, 20, 20)];
    _userSecretImageView.image = [UIImage imageNamed:LOGININ_USER_SECRET_IMAGE];
    [self.view addSubview:_userSecretImageView];
    
    _userSecretLabel = [[UILabel alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT+25, 130, 60, 20)];
    _userSecretLabel.font = [UIFont systemFontOfSize:TEXT_FONT_SIZE_NORMAL];
    _userSecretLabel.text = LOGIN_SECERT_LABEL;
    _userSecretLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_userSecretLabel];
    
    _userSecretTestField = [[UITextField alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT, 165, SCREEN_WIDTH-LAYOUT_OFFSET_LEFT-LAYOUT_OFFSET_RIGHT, 40)];
    _userSecretTestField.secureTextEntry=YES;
    _userSecretTestField.placeholder = LOGIN_SECRET_TEXTFIELD_PLACEHOLDER_TEXT;
    _userSecretTestField.borderStyle = UITextBorderStyleRoundedRect;
    //是否记录密码
    if ([YHSASystemSettingManager sharedTheSingletion].isMemorizePasswd) {
        _userSecretTestField.text = [YHSASystemSettingManager sharedTheSingletion].defaultUserSecret;
    }
    [self.view addSubview:_userSecretTestField];
    
    _shouldAutoLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shouldAutoLoginBtn.layer.borderWidth = 1;
    _shouldAutoLoginBtn.layer.borderColor = [[UIColor grayColor]CGColor];
    _shouldAutoLoginBtn.frame=CGRectMake(LAYOUT_OFFSET_LEFT, 237, 15, 15);
    //是否开启
    if ([YHSASystemSettingManager sharedTheSingletion].isMemorizePasswd) {
        _shouldAutoLoginBtn.selected = YES;
        _shouldAutoLoginBtn.backgroundColor = [UIColor redColor];
    }
    [_shouldAutoLoginBtn addTarget:self action:@selector(changeAuto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shouldAutoLoginBtn];
    
    _shouldAutoLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT+25, 230, 80, 30)];
    _shouldAutoLoginLabel.text = LOGIN_SHOULD_AUTO_MEMORY_TEXT;
    [self.view addSubview:_shouldAutoLoginLabel];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake(LAYOUT_OFFSET_LEFT, 280, SCREEN_WIDTH-LAYOUT_OFFSET_LEFT-LAYOUT_OFFSET_RIGHT, 40);
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 8;
    [_loginBtn setTitle:LOGIN_BTN_TEXT forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _registBtn.frame = CGRectMake(SCREEN_WIDTH-LAYOUT_OFFSET_RIGHT-70-20-70, 340, 70, 20);
    [_registBtn setTitle:LOGIN_REGIST_BTN_TEXT forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
    
    _refindSecretBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _refindSecretBtn.frame = CGRectMake(SCREEN_WIDTH-LAYOUT_OFFSET_RIGHT-70, 340,70, 20);
    [_refindSecretBtn setTitle:LOGIN_REFIND_SECERT_TEXT forState:UIControlStateNormal];
    [_refindSecretBtn addTarget:self action:@selector(reFoundSecret) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refindSecretBtn];
   
}

//主题部分设置
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * model = [YHTopicColorManager sharedTheSingletion];
    //获取主题
    [model getTopicModel];
    _userNameLabel.textColor = model.textColor;
    _userSecretLabel.textColor = model.textColor;
    _shouldAutoLoginLabel.textColor = model.textColor;
    [_loginBtn setBackgroundColor:model.btnColor];
    [_loginBtn setTitleColor:model.btnTextColor forState:UIControlStateNormal];
    [_registBtn setTitleColor:model.textColor forState:UIControlStateNormal];
    [_refindSecretBtn setTitleColor:model.textColor forState:UIControlStateSelected];
    self.view.backgroundColor = model.bgColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击逻辑
-(void)registClick{
    [self.navigationController pushViewController:[[YHSARegistViewController alloc]init] animated:YES];
}

-(void)reFoundSecret{
    [self.navigationController pushViewController:[[YHSAReFoundViewController alloc]init] animated:YES];
}
-(void)changeAuto:(UIButton *)btn{
    if (btn.selected) {
        btn.selected=NO;
        [YHSASystemSettingManager sharedTheSingletion].isMemorizePasswd=NO;
        btn.backgroundColor=[UIColor whiteColor];
    }else{
        btn.selected=YES;
        [YHSASystemSettingManager sharedTheSingletion].isMemorizePasswd=YES;
        btn.backgroundColor=[UIColor redColor];
    }
   
}
-(void)loginClick{
    //先做账号密码检测
    if ([self isUnableOfUserSecret]) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"您输入的密码长度超限!" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    //检测账号是否正确
    if (!YHBaseCheckString(YHBaseStringCompareEqual, _userNameTestField.text, 11)) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"请输入正确的通行证号!" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    //进行登陆请求
    [self creatRequest];
    
}
-(BOOL)isUnableOfUserSecret{
    return YHBaseCheckString(YHBaseStringCompareLonger, _userSecretTestField.text, 20);
}

-(void)creatRequest{
    //拼接字段
    NSDictionary * dic = @{INTERFACE_FIELD_LOGIN_PHONECODE:_userNameTestField.text,INTERFACE_FIELD_LOGIN_PASSWORD:_userSecretTestField.text};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypelogin infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        NSDictionary * dataDic = [NSDictionary dictionaryWithDictionary:[YHBaseJOSNAnalytical dictionaryWithJSData:data]];
        YHSARegustGetDataModel * model = [[YHSARegustGetDataModel alloc]init];
        [model creatModelWithDic:dataDic];
        if ([model.resultCode intValue]==[INTERFACE_RETURN_LOGIN_SUCCESS intValue]) {
            //存信息
            [YHSASystemSettingManager sharedTheSingletion].defaultUserName = _userNameTestField.text;
            [YHSASystemSettingManager sharedTheSingletion].defaultUserSecret = _userSecretTestField.text;
            
            //跳转登陆界面
            __BLOCK__WEAK__SELF__(__self);
            [YHBaseAlertView showWithStyle:YHBaseAlertViewNormal title:PUBLIC_PART_ALERT_TITLE text:@"恭喜您登陆成功!" cancleBtn:@"切换账号" selectBtn:@"立即登陆" andSelectFunc:^{
                //登陆状态的切换
                YHSAUserManager * userManager =  [YHSAUserManager sharedTheSingletion];
                userManager.userName = _userNameTestField.text;
                userManager.userSecret = _userSecretTestField.text;
                userManager.isLogin = YES;
                
                [[__self navigationController] popToRootViewControllerAnimated:YES];
            }];
            
        }else if ([model.resultCode intValue] ==[INTERFACE_RETURN_LOGIN_FAILED intValue]){
            [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"登陆失败:账号或密码错误" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}



#pragma mark - 优化部分
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstRes];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self resignFirstRes];
}

//收键盘
-(void)resignFirstRes{
    [_userNameTestField resignFirstResponder];
    [_userSecretTestField resignFirstResponder];
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
