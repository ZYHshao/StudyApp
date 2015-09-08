//
//  YHSAReportCardViewController.m
//  
//
//  Created by user on 15/9/8.
//
//

#import "YHSAReportCardViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAUserManager.h"
#import "YHSARequestGetDataModel.h"
#import "YHSAReportCardModel.h"
#import "YHSAReportCardSubModel.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSAReportCardTableViewCell.h"
#import "YHSAMockExamDetailsModel.h"
#import "YHSAMockExamAnswerQuestionViewController.h"
@interface YHSAReportCardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArray;
    YHSAReportCardModel * _dataModel;
    YHBaseView * _headView;
    YHBaseLabel * _headLabel;
    YHBaseView * _footView;
    YHBaseButton * _footBtn;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YHSAReportCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)YHCreatDate{
    _dataArray = [[NSMutableArray alloc]init];
    _dataModel = [[YHSAReportCardModel alloc]init];
    NSDictionary * dic = @{INTERFACE_FIELD_POST_REPORT_CARD_EXAMID:_examid,INTERFACE_FIELD_POST_ACHIEVEMENT_ANALYSE_LIST_PHONECODE:[YHSAUserManager sharedTheSingletion].userName};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeReportCard infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        if ([tmpModel.resultCode integerValue]==[INTERFACE_RETURN_POST_REPORT_CARD_SUCCESS intValue]) {
            [_dataModel creatModelWithDic:tmpModel.data];
            for (int i= 0; i<_dataModel.pageData.count; i++) {
                YHSAReportCardSubModel * model = [[YHSAReportCardSubModel alloc]init];
                [model creatModelWithDic:[_dataModel.pageData objectAtIndex:i]];
                [_dataArray addObject:model];
               
            }
            [_tableView reloadData];
        }else if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_REPORT_CARD_FAILED intValue]){
            
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView  sharedTheSingletion]unShow];
    } isbuffer:NO];
}
-(void)YHCreatView{
    _tableView.bounces=NO;
    //区分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _headView = [[YHBaseView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    _headLabel = [[YHBaseLabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 100)];
    [_headView addSubview:_headLabel];
    _headLabel.numberOfLines=0;
    _headLabel.font = [UIFont boldSystemFontOfSize:19];
    
    _footView = [[YHBaseView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    _footBtn = [[YHBaseButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-140, 20, 280, 30) backgroundImage:nil backgroundColor:nil textColor:nil titleText:@"查看试卷" andClickBlock:^(YHBaseButton *btn) {
        //打开响应试卷
        [[YHSAActivityIndicatorView sharedTheSingletion]show];
        //获取试卷
        __BLOCK__WEAK__SELF__(__self);
        NSDictionary * dic = @{INTERFACE_FIELD_MOCKEXAM_EXAMID:_examid};
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamDetails infoDic:dic Succsee:^(NSData *data) {
            YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
            NSDictionary * temDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            [model creatModelWithDic:temDic];
            if ([model.resultCode intValue]==[INTERFACE_RETURN_MOCKEXAM__DETAILS_SUCCESS intValue]) {
                //下载成功 处理数据
                YHSAMockExamDetailsModel * mockModel = [[YHSAMockExamDetailsModel alloc]init];
                [mockModel creatModelWithDic:[model.data firstObject]];
                YHSAMockExamAnswerQuestionViewController * con = [[YHSAMockExamAnswerQuestionViewController alloc]init];
                con.dataModel = mockModel;
                [[__self navigationController]pushViewController:con animated:YES];
            }
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } andFail:^(YHBaseError *error) {
            [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        } isbuffer:NO];

    }];
    [_footView addSubview:_footBtn];
    
}

-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    self.view.backgroundColor = manager.bgColor;
    _headView.backgroundColor = manager.bgColor;
    _footView.backgroundColor = manager.bgColor;
    _headLabel.backgroundColor = manager.bgColor;
    _footBtn.backgroundColor = manager.btnColor;
    [_footBtn setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
}

#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headLabel.text = _dataModel.examname;
    return _headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return _footView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHSAReportCardTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_ID_REPORT_CAED];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:TABLEVIEW_CELL_ID_REPORT_CAED owner:self options:nil] lastObject];
    }
    YHSAReportCardSubModel * model = _dataArray[indexPath.row];
    cell.theTitleLabel.text = model.txname;
    cell.contentLabel.text = [NSString stringWithFormat:@"共 %@ 题    答对 %@ 题    正确率:%@%%",model.total,model.correct,model.percent];
    return cell;
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
