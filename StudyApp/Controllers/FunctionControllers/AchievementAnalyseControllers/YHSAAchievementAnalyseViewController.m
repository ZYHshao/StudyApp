//
//  YHSAAchievementAnalyseViewController.m
//  
//
//  Created by user on 15/9/8.
//
//

#import "YHSAAchievementAnalyseViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAUserManager.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSAAchievementAnalyseListModel.h"
#import "YHSARequestGetDataModel.h"
#import "YHSAAchievementAnalyseTableViewCell.h"
#import "YHSAReportCardViewController.h"
@interface YHSAAchievementAnalyseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArray;
    YHBaseTableView * _tableView;
    
}
@end

@implementation YHSAAchievementAnalyseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatDate{
    _dataArray = [[NSMutableArray alloc]init];
    //进行数据请求
    NSDictionary * dic = @{INTERFACE_FIELD_POST_ACHIEVEMENT_ANALYSE_LIST_PHONECODE:[YHSAUserManager sharedTheSingletion].userName};
    [[YHSAActivityIndicatorView  sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeAchievementAnalyse infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView  sharedTheSingletion]unShow];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * tmpModel  = [[YHSARequestGetDataModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_ACHIEVEMENT_ANALYSE_SUCCESS intValue]) {
            //进行数据包装
            for (int i=0; i<[tmpModel.data count]; i++) {
                YHSAAchievementAnalyseListModel * model = [[YHSAAchievementAnalyseListModel alloc]init];
                [model creatModelWithDic:[tmpModel.data objectAtIndex:i]];
                [_dataArray addObject:model];
            }
            //进行视图刷新
            [_tableView reloadData];
        }else if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_ACHIEVEMENT_ANALYSE_FAILED intValue]){
            
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}

-(void)YHCreatView{
    self.title = ACHIEVEMENT_ANALYES_CONTROLLER_TITLE;
    _tableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView shouldRefresh:^{
       //下拉刷新
        [self update];
    }];
    [self.view addSubview:_tableView];
}

-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _tableView.backgroundColor = manager.bgColor;
    [_tableView reloadData];
}
#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHSAAchievementAnalyseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_ID_ACHIEVEMENT_ANALYSE];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:TABLEVIEW_CELL_ID_ACHIEVEMENT_ANALYSE owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
        cell.backgroundColor = manager.cellColor;
        cell.examTitleLabel.textColor = manager.cellTextColor;
        cell.dateLabel.textColor = manager.cellTextColor;
    }
    cell.examTitleLabel.text = [_dataArray[indexPath.row] examname];
    cell.dateLabel.text = [NSString stringWithFormat:@"答卷日期:%@",[_dataArray[indexPath.row] examdate]];
    return cell;
}

-(void)update{
    [_tableView.header beginRefreshing];
    NSDictionary * dic = @{INTERFACE_FIELD_POST_ACHIEVEMENT_ANALYSE_LIST_PHONECODE:[YHSAUserManager sharedTheSingletion].userName};
    [[YHSAActivityIndicatorView  sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeAchievementAnalyse infoDic:dic Succsee:^(NSData *data) {
        [_tableView.header endRefreshing];
        [[YHSAActivityIndicatorView  sharedTheSingletion]unShow];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel * tmpModel  = [[YHSARequestGetDataModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_ACHIEVEMENT_ANALYSE_SUCCESS intValue]) {
            //进行数据包装
            [_dataArray removeAllObjects];
            for (int i=0; i<[tmpModel.data count]; i++) {
                YHSAAchievementAnalyseListModel * model = [[YHSAAchievementAnalyseListModel alloc]init];
                [model creatModelWithDic:[tmpModel.data objectAtIndex:i]];
                [_dataArray addObject:model];
            }
            //进行视图刷新
            [_tableView reloadData];
        }else if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_ACHIEVEMENT_ANALYSE_FAILED intValue]){
            
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        [_tableView.header endRefreshing];
    } isbuffer:NO];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //查看成绩单
    YHSAReportCardViewController * con = [[YHSAReportCardViewController alloc]init];
    con.examid = [_dataArray[indexPath.row] examid];
    [self.navigationController pushViewController:con animated:YES];
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
