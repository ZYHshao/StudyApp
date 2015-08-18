//
//  YHSALoginViewController.m
//  
//
//  Created by user on 15/8/17.
//
//

#import "YHSALoginViewController.h"

@interface YHSALoginViewController ()
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
    _userSecretTestField.placeholder = LOGIN_SECRET_TEXTFIELD_PLACEHOLDER_TEXT;
    _userSecretTestField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_userSecretTestField];
    
    _shouldAutoLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shouldAutoLoginBtn.layer.borderWidth = 1;
    _shouldAutoLoginBtn.layer.borderColor = [[UIColor grayColor]CGColor];
    _shouldAutoLoginBtn.frame=CGRectMake(LAYOUT_OFFSET_LEFT, 237, 15, 15);
    [self.view addSubview:_shouldAutoLoginBtn];
    
    _shouldAutoLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(LAYOUT_OFFSET_LEFT+25, 230, 80, 30)];
    _shouldAutoLoginLabel.text = LOGIN_SHOULD_AUTO_MEMORY_TEXT;
    [self.view addSubview:_shouldAutoLoginLabel];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake(LAYOUT_OFFSET_LEFT, 280, SCREEN_WIDTH-LAYOUT_OFFSET_LEFT-LAYOUT_OFFSET_RIGHT, 40);
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 8;
    [_loginBtn setTitle:LOGIN_BTN_TEXT forState:UIControlStateNormal];
    [self.view addSubview:_loginBtn];
    
    _registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _registBtn.frame = CGRectMake(SCREEN_WIDTH-LAYOUT_OFFSET_RIGHT-70-20-70, 340, 70, 20);
    [_registBtn setTitle:LOGIN_REGIST_BTN_TEXT forState:UIControlStateNormal];
    [self.view addSubview:_registBtn];
    
    _refindSecretBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _refindSecretBtn.frame = CGRectMake(SCREEN_WIDTH-LAYOUT_OFFSET_RIGHT-70, 340,70, 20);
    [_refindSecretBtn setTitle:LOGIN_REFIND_SECERT_TEXT forState:UIControlStateNormal];
    [self.view addSubview:_refindSecretBtn];
   
}

//主题部分设置
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorModel * model = [YHTopicColorModel sharedTheSingletion];
    //获取主题
    [model getTopicModel];
    _userNameLabel.textColor = model.textColor;
    _userSecretLabel.textColor = model.textColor;
    _shouldAutoLoginLabel.textColor = model.textColor;
    [_loginBtn setBackgroundColor:model.btnColor];
    [_loginBtn setTitleColor:model.btnTextColor forState:UIControlStateNormal];
    [_registBtn setTitleColor:model.textColor forState:UIControlStateNormal];
    [_refindSecretBtn setTitleColor:model.textColor forState:UIControlStateNormal];
    self.view.backgroundColor = model.bgColor;
    
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
