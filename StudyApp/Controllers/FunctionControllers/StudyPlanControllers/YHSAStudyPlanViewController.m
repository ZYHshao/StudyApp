//
//  YHSAStudyPlanViewController.m
//  
//
//  Created by user on 15/9/6.
//
//

#import "YHSAStudyPlanViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAUserManager.h"
#import "YHSARequestGetDataModel.h"
#import "YHSAStudyPlanListModel.h"
#import "YHSAStudyPlanEditViewController.h"
#import "YHSAActivityIndicatorView.h"
@interface YHSAStudyPlanViewController ()<YHBaseCalendarViewDelegate>
{
    NSMutableArray * _dataArray;
    //当前的计划模型
    __strong YHSAStudyPlanListModel * _currentModel;
    
    __strong YHBaseDateModel *_currentDateModel;
}
@property (weak, nonatomic) IBOutlet YHBaseCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *funcView;
@property (weak, nonatomic) IBOutlet UILabel *throughLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *reviseButton;
@property (weak, nonatomic) IBOutlet UIButton *detailsButton;

@property (weak, nonatomic) IBOutlet UIButton *theNewBtn;


@end

@implementation YHSAStudyPlanViewController
- (IBAction)deleteClick:(UIButton *)sender {
    __BLOCK__WEAK__SELF__(__self);
    //进行提示
    [YHBaseAlertView showWithStyle:YHBaseAlertViewNormal title:PUBLIC_PART_ALERT_TITLE text:@"是否确定删除计划" cancleBtn:PUBLIC_PART_ALERT_CANCLE_BTN selectBtn:PUBLIC_PART_ALERT_SELECT_BTN andSelectFunc:^{
        NSDictionary * dic = @{INTERFACE_FIELD_POST_STUDY_PLAN_ID:_currentModel.id,INTERFACE_FIELD_POST_STUDY_PLAN_STATUS:INTERFACE_FIELD_POST_DELETE_STUDY_PLAN_STATUS};
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeStudyPlanAdd infoDic:dic Succsee:^(NSData *data) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
            NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
            [model creatModelWithDic:dataDic];
            if ([model.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_ADD_SUCCESS intValue]) {
                [YHBaseAlertView showWithStyle:YHBaseAlertViewSimple title:PUBLIC_PART_ALERT_TITLE text:@"删除成功" cancleBtn:PUBLIC_PART_ALERT_SELECT_BTN selectBtn:nil andSelectFunc:nil];
                _currentDateModel =nil;
                [__self update];
            }else if ([model.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_ADD_FAILED intValue]){
                [__self update];
            }
            
        } andFail:^(YHBaseError *error) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } isbuffer:NO];

    }];

    
}
- (IBAction)reviseClick:(UIButton *)sender {
    YHSAStudyPlanEditViewController * con = [[YHSAStudyPlanEditViewController alloc]init];
    con.style = YHSAStudyPlanEditViewControllerStyleEdit;
    con.planId = _currentModel.id;
    [self.navigationController pushViewController:con animated:YES];
}
- (IBAction)newClick:(UIButton *)sender {
    YHSAStudyPlanEditViewController * con = [[YHSAStudyPlanEditViewController alloc]init];
    con.style = YHSAStudyPlanEditViewControllerStyleAdd;
    con.dateStr = [NSString stringWithFormat:@"%@-%@-%@",_currentDateModel.year,_currentDateModel.month,_currentDateModel.day];
    [self.navigationController pushViewController:con animated:YES];
}
- (IBAction)detailesClick:(UIButton *)sender {
    YHSAStudyPlanEditViewController * con = [[YHSAStudyPlanEditViewController alloc]init];
    con.style = YHSAStudyPlanEditViewControllerStyleDetails;
    con.planId = _currentModel.id;
    [self.navigationController pushViewController:con animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self update];
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _funcView.backgroundColor = manager.bgColor;
    _throughLabel.backgroundColor = manager.bgColor;
    _throughLabel.textColor = manager.textColor;
    _detailsButton.backgroundColor = manager.btnColor;
    _deleteButton.backgroundColor = manager.btnColor;
    _reviseButton.backgroundColor = manager.btnColor;
    _theNewBtn.backgroundColor = manager.btnColor;
    [_deleteButton setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
    [_detailsButton setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
    [_reviseButton setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
    [_theNewBtn setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
}

-(void)YHCreatDate{
    _dataArray = [[NSMutableArray alloc]init];
    //下载数据
    NSDictionary * dic = @{INTERFACE_FIELD_POST_STUDY_PLAN_LIST_PLONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_POST_STUDY_PLAN_STATUS:INTERFACE_FIELD_POST_GET_STUDY_PLAN_STATUS};
    //这里进行静默加载 不要有提示
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeStudyPlanList infoDic:dic Succsee:^(NSData *data) {
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_LIST_SUCCESS intValue]) {
            for (int i=0; i<[tmpModel.data count]; i++) {
                YHSAStudyPlanListModel * model = [[YHSAStudyPlanListModel alloc]init];
                [model creatModelWithDic:[tmpModel.data objectAtIndex:i]];
                [_dataArray addObject:model];
            }
            YHBaseDateModel * model = [[YHBaseDateModel alloc]init];
            model.year = [NSString stringWithFormat:@"%d",[_calendarView.currentDate getYear]];
            model.month = [NSString stringWithFormat:@"%02d",[_calendarView.currentDate getMonth]];
            model.day = [NSString stringWithFormat:@"%02d",[_calendarView.currentDate getDay]];
            _currentDateModel = model;
            [self updateViewWithDate:model];
        }else if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_LIST_FAILED intValue]){
            
        }
    } andFail:^(YHBaseError *error) {
        
    } isbuffer:NO];
    
}
-(void)update{
    NSDictionary * dic = @{INTERFACE_FIELD_POST_STUDY_PLAN_LIST_PLONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_POST_STUDY_PLAN_STATUS:INTERFACE_FIELD_POST_GET_STUDY_PLAN_STATUS};
    //这里进行静默加载 不要有提示
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeStudyPlanList infoDic:dic Succsee:^(NSData *data) {
        [_dataArray removeAllObjects];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_LIST_SUCCESS intValue]) {
            
            for (int i=0; i<[tmpModel.data count]; i++) {
                YHSAStudyPlanListModel * model = [[YHSAStudyPlanListModel alloc]init];
                [model creatModelWithDic:[tmpModel.data objectAtIndex:i]];
                [_dataArray addObject:model];
            }
            [self updateViewWithDate:_currentDateModel];
        }else if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_STUDY_PLAN_LIST_FAILED intValue]){
             [self updateViewWithDate:_currentDateModel];
        }
    } andFail:^(YHBaseError *error) {
        
    } isbuffer:NO];

}
-(void)YHCreatView{
    _calendarView.delegate=self;
    self.title = [NSString stringWithFormat:@"%d年%d月",[_calendarView.currentDate getYear],[_calendarView.currentDate getMonth]];
    YHBaseDateModel * model = [[YHBaseDateModel alloc]init];
    model.year = [NSString stringWithFormat:@"%d",[_calendarView.currentDate getYear]];
    model.month = [NSString stringWithFormat:@"%02d",[_calendarView.currentDate getMonth]];
    model.day = [NSString stringWithFormat:@"%02d",[[NSDate date] getDay]];
    _currentDateModel = model;
    _detailsButton.layer.masksToBounds=YES;
    _detailsButton.layer.cornerRadius=6;
    _deleteButton.layer.masksToBounds=YES;
    _deleteButton.layer.cornerRadius=6;
    _reviseButton.layer.masksToBounds=YES;
    _reviseButton.layer.cornerRadius=6;
    _theNewBtn.layer.masksToBounds=YES;
    _theNewBtn.layer.cornerRadius=6;
    _throughLabel.text = @"今日没有计划哦~";
    _theNewBtn.hidden=NO;
    _deleteButton.hidden=YES;
    _reviseButton.hidden=YES;
    _detailsButton.hidden=YES;
   
    //
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)updateViewWithDate:(YHBaseDateModel *)dateModel{
    _throughLabel.text = @"今日没有计划哦~";
    _theNewBtn.hidden=NO;
    _deleteButton.hidden=YES;
    _reviseButton.hidden=YES;
    _detailsButton.hidden=YES;
    for (YHSAStudyPlanListModel * model in _dataArray) {
        if ([model.date isEqualToString:[NSString stringWithFormat:@"%@-%@-%@",dateModel.year,dateModel.month,dateModel.day]]) {
            _currentModel = model;
            _throughLabel.text = model.title;
            _theNewBtn.hidden=YES;
            _deleteButton.hidden=NO;
            _reviseButton.hidden=NO;
            _detailsButton.hidden=NO;
            return;
        }else{
            _throughLabel.text = @"今日没有计划哦~";
            _theNewBtn.hidden=NO;
            _deleteButton.hidden=YES;
            _reviseButton.hidden=YES;
            _detailsButton.hidden=YES;
        }
    }
}

#pragma mark - delegate
-(void)YHBaseCalendarViewSelectAtDateModel:(YHBaseDateModel *)dateModel{
    //展示数据
    [self updateViewWithDate:dateModel];
    _currentDateModel = dateModel;
}

-(void)YHBaseCalendarViewScrollEndToDate:(YHBaseDateModel *)dateModel{
    self.title = [NSString stringWithFormat:@"%@年%@月",dateModel.year,dateModel.month];
}








@end
