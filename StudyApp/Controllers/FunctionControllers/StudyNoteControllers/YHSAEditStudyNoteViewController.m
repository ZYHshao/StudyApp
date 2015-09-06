//
//  YHSAEditStudyNoteViewController.m
//  StudyApp
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAEditStudyNoteViewController.h"
#import "YHSAUserManager.h"
#import "YHSAHttpManager.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSARequestGetDataModel.h"
@interface YHSAEditStudyNoteViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet YHBaseTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@end

@implementation YHSAEditStudyNoteViewController
- (IBAction)clickBtn:(UIButton *)sender {
    //进行内容的检查
    if (_titleTextField.text.length==0||_contentTextView.text.length==0) {
        [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"所填内容不能为空" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
        return;
    }
    //进行添加或者修改的操作
    if (_type==YHSAEditStudyNoteViewControllerTypeNew) {
        NSDictionary * dic = @{INTERFACE_FIELD_POST_GET_STUDY_NOTES_PHONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_POST_STUDY_NOTES_TITLE:_titleTextField.text,INTERFACE_FIELD_POST_STUDY_NOTES_CONTENT:_contentTextView.text,INTERFACE_FIELD_POST_STUDY_NOTES_STATUS:INTERFACE_FIELD_POST_ADD_STUDY_NOTES_STATUS,INTERFACE_FIELD_POST_STUDY_NOTES_QUESTION_ID:_questionid};
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeAddStudyNote infoDic:dic Succsee:^(NSData *data) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
            NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
            [model creatModelWithDic:dataDic];
            if ([model.resultCode intValue]==[INTERFACE_RETURN_ADD_STUDY_NOTE_SUCCESS intValue]) {
                __BLOCK__WEAK__SELF__(__self);
                [YHBaseAlertView showWithStyle:YHBaseAlertViewNormal title:PUBLIC_PART_ALERT_TITLE text:@"添加笔记成功!" cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:PUBLIC_PART_ALERT_SELECT_BTN andSelectFunc:^{
                    [[__self navigationController]popViewControllerAnimated:YES];
                }];
                
            }
        } andFail:^(YHBaseError *error) {
             [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } isbuffer:NO];
    }else if (_type==YHSAEditStudyNoteViewControllerTypeEdit){
        NSDictionary * dic = @{INTERFACE_FIELD_POST_GET_STUDY_NOTES_PHONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_POST_STUDY_NOTES_TITLE:_titleTextField.text,INTERFACE_FIELD_POST_STUDY_NOTES_CONTENT:_contentTextView.text,INTERFACE_FIELD_POST_STUDY_NOTES_STATUS:INTERFACE_FIELD_POST_EDIT_STUDY_NOTES_STATUS,INTERFACE_FIELD_POST_STUDY_NOTES_QUESTION_ID:_dataModel.questionid,INTERFACE_FIELD_POST_STUDY_NOTES_ID:_dataModel.id};
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeEditStudyNote infoDic:dic Succsee:^(NSData *data) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
            NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
            [model creatModelWithDic:dataDic];
            if ([model.resultCode intValue]==[INTERFACE_RETURN_UPDATE_STUDY_NOTE_SUCCESS intValue]) {
                __BLOCK__WEAK__SELF__(__self);
                [YHBaseAlertView showWithStyle:YHBaseAlertViewNormal title:PUBLIC_PART_ALERT_TITLE text:@"修改笔记成功!" cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:PUBLIC_PART_ALERT_SELECT_BTN andSelectFunc:^{
                    [[__self navigationController]popViewControllerAnimated:YES];
                }];
                
            }else if ([model.resultCode intValue]==[INTERFACE_RETURN_UPDATE_STUDY_NOTE_FAILED intValue]){
                [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"更新失败!" cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:nil andSelectFunc:nil];
            }
        } andFail:^(YHBaseError *error) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } isbuffer:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatView{
    _titleTextField.placeholder = STUDY_NOTE_TITLE_TEXT_FIELD_PLACEHOLDER;
    _contentTextView.placeHolder = STUDY_NOTE_CONTENT_TEXT_VIEW_PLACEHOLDER;
    if (_type==YHSAEditStudyNoteViewControllerTypeNew) {
        [_editBtn setTitle:STUDY_NOTE_NEW_BUTTON_TITLE forState:UIControlStateNormal];
    }else if (_type==YHSAEditStudyNoteViewControllerTypeEdit){
        [_editBtn setTitle:STUDY_NOTE_EDIT_BUTTON_TITLE forState:UIControlStateNormal];
    }
    [_contentTextView setBorderWidth:1 andColor:[UIColor grayColor]];
    [_contentTextView setCornerRaidus:6];
    _editBtn.layer.masksToBounds=YES;
    _editBtn.layer.cornerRadius=6;
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _editBtn.backgroundColor=manager.btnColor;
    [_editBtn setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
}


//关于键盘
-(void)textViewDidBeginEditing:(UITextView *)textView{
    __BLOCK__WEAK__SELF__(__self);
    [UIView animateWithDuration:0.3 animations:^{
        [[__self view] setFrame:CGRectMake(0, 0, [__self view].frame.size.width, [__self view].frame.size.height)];
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    __BLOCK__WEAK__SELF__(__self);
    [UIView animateWithDuration:0.3 animations:^{
        [[__self view] setFrame:CGRectMake(0,64, [__self view].frame.size.width, [__self view].frame.size.height)];
    }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [_contentTextView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_titleTextField resignFirstResponder];
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
