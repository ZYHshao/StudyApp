//
//  YHSAExamInfoViewController.m
//  
//
//  Created by user on 15/8/26.
//
//

#import "YHSAExamInfoViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAExamInfoListModel.h"
#import "YHSAExamListTableViewCell.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSAExamInfoDetailViewController.h"
@interface YHSAExamInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    YHBaseTableView * _tableView;
    NSMutableArray * _dataArray;
    //当前加载的页码
    int _currentPage;
}
@end

@implementation YHSAExamInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatView{
    self.title = EXAM_INFO_CONTROLLER_TITLE;
    _tableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    __BLOCK__WEAK__SELF__(__self);
    [_tableView shouldRefresh:^{
        //刷新数据
        [__self reFreshData];
    }];
    [_tableView shouldReload:^{
        [__self reloadMoreData];
    }];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _currentPage = 1;
    [self.view addSubview:_tableView];
    
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _tableView.backgroundColor = manager.bgColor;
}

//刷新数据
-(void)reFreshData{
    NSDictionary * dic = @{INTERFACE_FIELD_EXAM_INFO_PAGEINDEX:@"1",INTERFACE_FIELD_EXAM_INFO_PAGESIZE:[NSString stringWithFormat:@"%d",REQUEST_PAGE_SIZE]};
    //进行数据源数据的请求
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeExamInfo infoDic:dic Succsee:^(NSData *data) {
        [_tableView.header endRefreshing];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAExamInfoListModel * tmpModel = [[YHSAExamInfoListModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        tmpModel.pageData = [tmpModel.data objectForKey:@"pageData"];
        tmpModel.pageCount = [tmpModel.data objectForKey:@"pageCount"];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_EXAM_INFO_SUCCESS intValue]) {
            //包装数据
            for (int i=0; i<tmpModel.pageData.count; i++) {
                YHSAExamInfoListDataModel * model = [[YHSAExamInfoListDataModel alloc]init];
                [model creatModelWithDic:[tmpModel.pageData objectAtIndex:i]];
                [_dataArray replaceObjectAtIndex:i withObject:model];
            }
            if (_tableView!=nil) {
                [_tableView reloadData];
            }
        }else if([tmpModel.resultCode intValue]==[INTERFACE_RETURN_EXAM_INFO_FAILED intValue]){
            //请求失败
        }
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } andFail:^(YHBaseError *error) {
        [_tableView.header endRefreshing];
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];

}

//下拉加载
-(void)reloadMoreData{
    _currentPage++;
    NSDictionary * dic = @{INTERFACE_FIELD_EXAM_INFO_PAGEINDEX:[NSString stringWithFormat:@"%d",_currentPage],INTERFACE_FIELD_EXAM_INFO_PAGESIZE:[NSString stringWithFormat:@"%d",REQUEST_PAGE_SIZE]};
    //进行数据源数据的请求
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeExamInfo infoDic:dic Succsee:^(NSData *data) {
        [_tableView.footer endRefreshing];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAExamInfoListModel * tmpModel = [[YHSAExamInfoListModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        tmpModel.pageData = [tmpModel.data objectForKey:@"pageData"];
        tmpModel.pageCount = [tmpModel.data objectForKey:@"pageCount"];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_EXAM_INFO_SUCCESS intValue]) {
            //包装数据
            if ([tmpModel.pageCount intValue]<=_currentPage) {
                [_tableView ReloadEnd];
                return ;
            }
            for (int i=0; i<tmpModel.pageData.count; i++) {
                YHSAExamInfoListDataModel * model = [[YHSAExamInfoListDataModel alloc]init];
                [model creatModelWithDic:[tmpModel.pageData objectAtIndex:i]];
                [_dataArray addObject:model];
            }
            if (_tableView!=nil) {
                [_tableView reloadData];
            }
        }else if([tmpModel.resultCode intValue]==[INTERFACE_RETURN_EXAM_INFO_FAILED intValue]){
            //请求失败
        }
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } andFail:^(YHBaseError *error) {
        [_tableView.footer endRefreshing];
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];

}

-(void)YHCreatDate{
    _dataArray = [[NSMutableArray alloc]init];
    NSDictionary * dic = @{INTERFACE_FIELD_EXAM_INFO_PAGEINDEX:@"1",INTERFACE_FIELD_EXAM_INFO_PAGESIZE:[NSString stringWithFormat:@"%d",REQUEST_PAGE_SIZE]};
    //进行数据源数据的请求
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeExamInfo infoDic:dic Succsee:^(NSData *data) {
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAExamInfoListModel * tmpModel = [[YHSAExamInfoListModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        tmpModel.pageData = [tmpModel.data objectForKey:@"pageData"];
        tmpModel.pageCount = [tmpModel.data objectForKey:@"pageCount"];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_EXAM_INFO_SUCCESS intValue]) {
            //包装数据
            for (int i=0; i<tmpModel.pageData.count; i++) {
                YHSAExamInfoListDataModel * model = [[YHSAExamInfoListDataModel alloc]init];
                [model creatModelWithDic:[tmpModel.pageData objectAtIndex:i]];
                [_dataArray addObject:model];
            }
            if (_tableView!=nil) {
                [_tableView reloadData];
            }
        }else if([tmpModel.resultCode intValue]==[INTERFACE_RETURN_EXAM_INFO_FAILED intValue]){
            //请求失败
        }
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHSAExamListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_ID_EXAM_INFO];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YHSAExamListTableViewCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    YHSAExamInfoListDataModel * model = _dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    CGSize size = [YHBaseGeometryTools getLabelSize:cell.titleLabel inConstrainedSize:CGSizeMake(tableView.frame.size.width-40, MAXFLOAT)];
    cell.titleLabel.frame = CGRectMake(20, 10, tableView.frame.size.width-40, size.height);
    cell.dateLabel.text = [NSString stringWithFormat:@"更新日期:%@",model.date];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算获取高度
    UILabel * label = [[UILabel alloc]init];
    label.text= [_dataArray[indexPath.row] title];
    label.font = [UIFont systemFontOfSize:17];
    CGSize size = [YHBaseGeometryTools getLabelSize:label inConstrainedSize:CGSizeMake(tableView.frame.size.width-40, MAXFLOAT)];
    return 10+size.height+5+20+5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHSAExamInfoDetailViewController * con = [[YHSAExamInfoDetailViewController alloc]init];
    con.infoid = [_dataArray[indexPath.row] msgid];
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
