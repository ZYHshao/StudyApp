//
//  YHSAExamInfoDetailViewController.m
//  
//
//  Created by user on 15/8/26.
//
//

#import "YHSAExamInfoDetailViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAExamInfoDetailModel.h"
#import "YHSAActivityIndicatorView.h"
@interface YHSAExamInfoDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
__PROPERTY_NO_STRONG__(YHSAExamInfoDetailModel *, dataModel);
@end

@implementation YHSAExamInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)YHCreatDate{
    NSDictionary * dic = @{INTERFACE_FIELD_EXAM_INFO_DETAIL_MSGID:_infoid};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeExamInfoDetail infoDic:dic Succsee:^(NSData *data) {
        NSDictionary * tmpDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * model = [[YHSARequestGetDataModel  alloc]init];
        [model creatModelWithDic:tmpDic];
        if ([model.resultCode integerValue]==[INTERFACE_RETURN_MOCKEXAM__DETAILS_SUCCESS intValue]) {
            //包装数据
            _dataModel = [[YHSAExamInfoDetailModel alloc]init];
            [_dataModel creatModelWithDic:[model.data firstObject]];
            [self YHCreatView];
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        }
    } andFail:^(YHBaseError *error) {
          [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}


-(void)YHCreatView{
    self.title = EXAM_INFO_DETAIL_CONTROLLER_TITLE;
    _titleLabel.text=_dataModel.title;
    _dateLabel.text=[NSString stringWithFormat:@"更新:%@",_dataModel.date];
    [_webView loadHTMLString:_dataModel.content baseURL:nil];
}

-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _titleLabel.backgroundColor = manager.bgColor;
    _titleLabel.textColor = manager.textColor;
    _dateLabel.backgroundColor = manager.bgColor;
    _dateLabel.textColor = manager.textColor;
    _webView.backgroundColor = manager.bgColor;
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
