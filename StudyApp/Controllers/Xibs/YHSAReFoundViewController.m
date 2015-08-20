//
//  YHSAReFoundViewController.m
//  
//
//  Created by user on 15/8/20.
//
//

#import "YHSAReFoundViewController.h"

@interface YHSAReFoundViewController ()
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
- (IBAction)commitInfo:(YHBaseButton *)sender {
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
