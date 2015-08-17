//
//  YHASRegistViewController.m
//  
//
//  Created by user on 15/8/17.
//
//

#import "YHASRegistViewController.h"
@interface YHASRegistViewController ()<UITextFieldDelegate>
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

@implementation YHASRegistViewController
- (IBAction)toRegist:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:YHTopicChangeTopicNotication object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}
-(void)YHCreatView{
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
    //适配不同屏幕大小与滚动视图相关设置
    _scrollView.contentSize = CGSizeMake(0, 480);
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
}

-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorModel * model = [YHTopicColorModel sharedTheSingletion];
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
    NSLog(@"监听到通知");
    
}
//为了不被挡住视图，做如下操作
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag>302&&textField.tag<305) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=CGRectMake(0, -140, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }else if (textField.tag>=305){
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=CGRectMake(0, -240, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
    
}
//收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_schoolTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_secretTextFIeld resignFirstResponder];
    [_reWeiteSecretTextField resignFirstResponder];
    [_questionTestField resignFirstResponder];
    [_answerTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_schoolTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_secretTextFIeld resignFirstResponder];
    [_reWeiteSecretTextField resignFirstResponder];
    [_questionTestField resignFirstResponder];
    [_answerTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    return YES;
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
