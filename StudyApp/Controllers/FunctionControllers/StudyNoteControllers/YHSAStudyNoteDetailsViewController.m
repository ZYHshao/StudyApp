//
//  YHSAStudyNoteDetailsViewController.m
//  
//
//  Created by user on 15/9/6.
//
//

#import "YHSAStudyNoteDetailsViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAUserManager.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSARequestGetDataModel.h"
#import "YHSAGetStudyNotelListModel.h"
@interface YHSAStudyNoteDetailsViewController ()
{
    YHSAGetStudyNotelListModel * _dataModel;
    YHBaseLabel * _contentLabel;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScorllView;

@end

@implementation YHSAStudyNoteDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)YHCreatDate{
    NSDictionary * dic = @{INTERFACE_FIELD_POST_GET_STUDY_NOTES_PHONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_POST_STUDY_NOTES_STATUS:INTERFACE_FIELD_POST_DETAILS_STUDY_NOTES_STATUS,INTERFACE_FIELD_POST_STUDY_NOTES_QUESTION_ID:_requestModel.questionid,INTERFACE_FIELD_POST_STUDY_NOTES_ID:_requestModel.id};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeDetailsStudyNote infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel  alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        __BLOCK__WEAK__SELF__(__self);
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_DETAILS_STUDY_NOTE_SUCCESS intValue]) {
            //包装数据
            _dataModel = [[YHSAGetStudyNotelListModel alloc]init];
            [_dataModel creatModelWithDic:[tmpModel.data firstObject]];
            [__self YHCreatView];
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}

-(void)YHCreatView{
    self.title = STUDY_NOTE_DETAILS_CONTROLLER_TITLE;
    _titleLabel.text = _dataModel.title;
    _dateLabel.text = [NSString stringWithFormat:@"更新时间:%@",_dataModel.date];
    if (_contentLabel==nil) {
         _contentLabel = [[YHBaseLabel alloc]initWithFrame:CGRectMake(0, 0, _contentScorllView.frame.size.width, _contentScorllView.frame.size.height)];
        _contentLabel.numberOfLines=0;
        [_contentScorllView addSubview:_contentLabel];
    }
    _contentLabel.text = _dataModel.content;
    CGSize size = [YHBaseGeometryTools getLabelSize:_contentLabel inConstrainedSize:CGSizeMake(_contentLabel.frame.size.width, MAXFLOAT)];
    _contentLabel.frame=CGRectMake(0, 0, _contentLabel.frame.size.width, size.height);
    _contentScorllView.contentSize = CGSizeMake(0, size.height);
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _titleLabel.backgroundColor=manager.bgColor;
    _titleLabel.textColor = manager.textColor;
    _dateLabel.backgroundColor = manager.bgColor;
    _dateLabel.textColor = manager.textColor;
    _contentLabel.backgroundColor = manager.bgColor;
    _contentLabel.textColor = manager.textColor;
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
