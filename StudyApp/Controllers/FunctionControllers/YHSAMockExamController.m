//
//  YHSAMockExamController.m
//  
//
//  Created by user on 15/8/20.
//
//

#import "YHSAMockExamController.h"
#import "YHSAHttpManager.h"
#import "YHSAMockExamMainListModel.h"
@interface YHSAMockExamController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    YHBaseTableView * _tableView;
    UISearchBar * _searchBar;
    NSMutableArray * _dataArray;
}
@end

@implementation YHSAMockExamController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatDate{
    //进行数据相关初始化
    _dataArray = [[NSMutableArray alloc]init];
    //进行请求
    [self creatRequest];
   
}

-(void)YHCreatView{
    self.title = MOCK_EXAM_CONTROLLER_TITLE;
    //进行界面相关初始化
    _tableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
    [_tableView shouldRefresh:^{
        //重新加载数据
        [self reDownData];
    }];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.placeholder = MOCK_EXAM_SEARCH_BAR_PLACEHOLDER_TEXT;
    _searchBar.delegate=self;
    [self.view addSubview:_searchBar];
}

-(void)useYHTopicToCreatViewWithModel{
    //进行主题颜色设置
    YHTopicColorManager * model = [YHTopicColorManager sharedTheSingletion];
    [model getTopicModel];
    self.view.backgroundColor = model.bgColor;
    _tableView.backgroundColor = model.bgColor;
    _searchBar.barTintColor = model.bgColor;
}

#pragma mark - request
-(void)creatRequest{
    //拼接参数地址
    NSDictionary * dic =@{INTERFACE_FIELD_MOCKEXAM_CODE:@"0",INTERFACE_FIELD_MOCKEXAM_PAGEINDEX:@"0",INTERFACE_FIELD_MOCKEXAM_PAGESIZE:@"100"};
    //开启刷新状态
    [_tableView.header beginRefreshing];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamListFirst infoDic:dic Succsee:^(NSData *data) {
        //数据处理
        [_tableView.header endRefreshing];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAMockExamMainListModel * model = [[YHSAMockExamMainListModel alloc]init];
        [model creatModelWithDic:dataDic];
        if ([model.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_SUCCESS intValue]) {
            //数据正确 进行数据封装
            for (int i=0; i<model.data.count; i++) {
                YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
                [dataModel creatModelWithDic:[model.data objectAtIndex:i]];
                [_dataArray addObject:dataModel];
            }
        }
        [_tableView reloadData];
    } andFail:^(YHBaseError *error) {
        [_tableView.header endRefreshing];
    } isbuffer:YES];
}
-(void)reDownData{
    NSDictionary * dic =@{INTERFACE_FIELD_MOCKEXAM_CODE:@"0",INTERFACE_FIELD_MOCKEXAM_PAGEINDEX:@"0",INTERFACE_FIELD_MOCKEXAM_PAGESIZE:@"100"};
    //开启刷新状态
    [_tableView.header beginRefreshing];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamListFirst infoDic:dic Succsee:^(NSData *data) {
        //数据处理
        [_tableView.header endRefreshing];
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAMockExamMainListModel * model = [[YHSAMockExamMainListModel alloc]init];
        [model creatModelWithDic:dataDic];
        if ([model.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_SUCCESS intValue]) {
            //数据正确 进行数据封装
            [_dataArray removeAllObjects];
            for (int i=0; i<model.data.count; i++) {
                YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
                [dataModel creatModelWithDic:[model.data objectAtIndex:i]];
                [_dataArray addObject:dataModel];
            }
        }
        [_tableView reloadData];
    } andFail:^(YHBaseError *error) {
        [_tableView.header endRefreshing];
    } isbuffer:NO];
}
#pragma mark - tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_ID_MOCK_EXAM_FIRST];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLEVIEW_CELL_ID_MOCK_EXAM_FIRST];
    }
    YHSAMockExamMainListDataModel * model = _dataArray[indexPath.row];
    cell.textLabel.text = model.typename;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //进行传值跳转
}

//收键盘相关
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}



#pragma mark - scarchBar Delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"查找");
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
