//
//  YHSAOptionsViewController.m
//  
//
//  Created by user on 15/8/26.
//
//

#import "YHSAOptionsViewController.h"
#import "YHSAUserManager.h"
#import "YHSAHttpManager.h"
#import "YHSARequestGetDataModel.h"
@interface YHSAOptionsViewController ()
@property (weak, nonatomic) IBOutlet YHBaseTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;

@end

@implementation YHSAOptionsViewController
- (IBAction)postOption:(UIButton *)sender {
    //提交意见
    if (_textView.text.length==0) {
        [[[YHBaseAlertView alloc]initWithTitle:PUBLIC_PART_ALERT_TITLE message:@"请填写提交的建议" delegate:self cancelButtonTitle:PUBLIC_PART_ALERT_SELECT_BTN otherButtonTitles:nil, nil] show];
        return;
    }
    //进行提交
    NSDictionary * dic = @{INTERFACE_FIELD_OPTION_POST_PHONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_OPTION_POST_CONTENT:_textView.text};
    [[YHBaseActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeOptionsPost infoDic:dic Succsee:^(NSData *data) {
        [[YHBaseActivityIndicatorView sharedTheSingletion]unShow];
        //进行判断处理
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
        [model creatModelWithDic:dataDic];
        if ([model.resultCode intValue]==[INTERFACE_RETURN_OPTION_POST_SUCCESS intValue]) {
            [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:model.resultMsg cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([model.resultCode intValue]==[INTERFACE_RETURN_REGIST_FAILED intValue]){
             [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:model.resultMsg cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } andFail:^(YHBaseError *error) {
        [[YHBaseActivityIndicatorView sharedTheSingletion]unShow];
        [self.navigationController popViewControllerAnimated:YES];
    } isbuffer:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}




-(void)YHCreatView{
    self.title=OPTION_POST_CONTROLLER_TITLE;
    _textView.placeHolder = OPTION_POST_TEXTVIEW_PLACEHOLDER_TEXT;
    [_postBtn setTitle:OPTION_POST_BUTTON_TITLE forState:UIControlStateNormal];
    [_textView setCornerRaidus:6];
    _postBtn.layer.cornerRadius=6;
    _postBtn.layer.masksToBounds=YES;
}

-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [[YHTopicColorManager alloc]init];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    [_textView setBorderWidth:2 andColor:manager.greyBgColor];
    _textView.backgroundColor = manager.bgColor;
    _textView.textColor=manager.textColor;
    [_postBtn setBackgroundColor:manager.btnColor];
    [_postBtn setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
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
