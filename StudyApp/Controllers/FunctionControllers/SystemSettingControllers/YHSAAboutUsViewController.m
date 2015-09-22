//
//  YHAboutUsViewController.m
//  
//
//  Created by user on 15/8/26.
//
//

#import "YHSAAboutUsViewController.h"

@interface YHSAAboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UITextField *textfield3;
@property (weak, nonatomic) IBOutlet UITextField *textfield5;
@property (weak, nonatomic) IBOutlet UITextField *textfield6;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextField *textfield4;
@end

@implementation YHSAAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)YHCreatView{
    self.title = ABOUT_US_CONTROLLER_TITLE;
    _logoImageView.image=[UIImage imageNamed:ABOUT_US_LOGO_IMAGE];
    _textfield1.text = ABOUT_US_WEB;
    _textfield2.text = ABOUT_US_WEIBO;
    _textfield3.text = ABOUT_US_QQ;
    //_textfield4.text = ABOUT_US_PHONE;
    _textfield4.text = ABOUT_US_TEL;
   // _textfield6.text = ABOUT_US_ADRESS;
    _textfield5.hidden=YES;
    _textfield6.hidden=YES;
    _textLabel.text = ABOUT_US_ABOUT_US;
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _textLabel.backgroundColor = manager.bgColor;
    _textLabel.textColor = manager.textColor;
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
