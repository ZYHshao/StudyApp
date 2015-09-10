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
#import "YHSAMockExamSubjectViewController.h"
#import "YHSAActivityIndicatorView.h"
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
   
 
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamListFirst infoDic:dic Succsee:^(NSData *data) {
        //数据处理
     
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAMockExamMainListModel * model = [[YHSAMockExamMainListModel alloc]init];
        [model creatModelWithDic:dataDic];
        if ([model.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_SUCCESS intValue]) {
            //数据正确 进行数据封装
            for (int i=0; i<[model.data count]; i++) {
                YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
                [dataModel creatModelWithDic:[model.data objectAtIndex:i]];
                [_dataArray addObject:dataModel];
            }
        }else if([model.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_FAILED intValue]){
            //做数据失败的处理
        }
        [_tableView reloadData];
    } andFail:^(YHBaseError *error) {
      
    } isbuffer:NO];
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
            for (int i=0; i<[model.data count]; i++) {
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    YHSAMockExamMainListDataModel * model = _dataArray[indexPath.row];
    cell.textLabel.text = model.typename;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //进行传值跳转
    YHSAMockExamMainListDataModel * model = _dataArray[indexPath.row];
    NSDictionary * dic =@{INTERFACE_FIELD_MOCKEXAM_CODE:[NSString stringWithFormat:@"%@",model.typecode],INTERFACE_FIELD_MOCKEXAM_PAGEINDEX:@"0",INTERFACE_FIELD_MOCKEXAM_PAGESIZE:@"10"};
    //开启等待状态
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamListFirst infoDic:dic Succsee:^(NSData *data) {
        //数据处理
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAMockExamMainListModel * tmpModel = [[YHSAMockExamMainListModel alloc]init];
        [tmpModel creatModelWithDic:dataDic];
        if ([tmpModel.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_SUCCESS intValue]) {
            NSMutableArray * temArray=[[NSMutableArray alloc]init];
            //进行分类级别的判断
            YHSAMockExamSubjectViewController * con = [[YHSAMockExamSubjectViewController alloc]init];
            con.dataModel = model;
            if ([tmpModel.status intValue]==1) {//还是分类目录界别
                //数据正确 进行数据封装
                    for (int i=0; i<[tmpModel.data count]; i++) {
                    YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
                    [dataModel creatModelWithDic:[tmpModel.data objectAtIndex:i]];
                    [temArray addObject:dataModel];
                }
                con.status=1;
              
            }else{
                //已经是试卷目录级别
                NSArray * subArray = [tmpModel.data objectForKey:@"pageData"];
                for (int i=0; i<subArray.count; i++) {
                    YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
                    [dataModel creatModelWithDic:[subArray objectAtIndex:i]];
                    [temArray addObject:dataModel];
                }
                con.examCount=[[tmpModel.data objectForKey:@"pageCount"] intValue];
                con.status=0;
            }
            con.dataArray = [NSMutableArray arrayWithArray:temArray];
            [self.navigationController  pushViewController:con animated:YES];
        }else if([tmpModel.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_FAILED intValue]){
            //做数据失败的处理
           
        }
          [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}

//收键盘相关
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}



#pragma mark - scarchBar Delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //请求数据 进行跳转
    NSDictionary * dic = @{INTERFACE_FIELD_SEARCH_KEY:searchBar.text};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeSearchKey infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView  sharedTheSingletion]unShow];
        YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
        [model creatModelWithData:data];
        YHSAMockExamSubjectViewController * con = [[YHSAMockExamSubjectViewController alloc]init];
        NSMutableArray * temArray = [[NSMutableArray alloc]init];
        for (int i=0; i<[model.data count]; i++) {
            YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
            [dataModel creatModelWithDic:[model.data objectAtIndex:i]];
            [temArray addObject:dataModel];
        }
        con.title = searchBar.text;
        con.dataArray = [NSMutableArray arrayWithArray:temArray];
        con.status=1;
        con.isSearch=YES;
        [self.navigationController  pushViewController:con animated:YES];
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView  sharedTheSingletion]unShow];
    } isbuffer:NO];
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
