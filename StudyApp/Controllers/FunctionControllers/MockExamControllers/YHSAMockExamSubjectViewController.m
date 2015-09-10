//
//  YHSAMockExamSubjectViewController.m
//  
//
//  Created by user on 15/8/21.
//
//

#import "YHSAMockExamSubjectViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAMockExamDetailsViewController.h"
#import "YHSAActivityIndicatorView.h"

@interface YHSAMockExamSubjectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    YHBaseTableView *_tableView;
    NSString * _controllerTiele;
    //记录当前页数，用于上拉加载数据
    int _currentPage;
    
    
}
@end

@implementation YHSAMockExamSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)YHCreatDate{
    
}


-(void)reDownData{
    NSDictionary * dic =@{INTERFACE_FIELD_MOCKEXAM_CODE:[NSString stringWithFormat:@"%@",_dataModel.typecode],INTERFACE_FIELD_MOCKEXAM_PAGEINDEX:@"0",INTERFACE_FIELD_MOCKEXAM_PAGESIZE:@"10"};
    //开启刷新状态
    [_tableView.header beginRefreshing];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamListFirst infoDic:dic Succsee:^(NSData *data) {
        //数据处理
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAMockExamMainListModel * model = [[YHSAMockExamMainListModel alloc]init];
        [model creatModelWithDic:dataDic];
        if ([model.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_SUCCESS intValue]) {
            
            //数据正确 进行数据封
            
            if (_status==1) {
                [_dataArray removeAllObjects];
                for (int i=0; i<[model.data count]; i++) {
                    YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
                    [dataModel creatModelWithDic:[model.data objectAtIndex:i]];
                    [_dataArray addObject:dataModel];
                    //
                }
            }else{
                NSRange range = {0,10};
                if (_dataArray.count>=10) {
                    [_dataArray removeObjectsInRange:range];
                }else{
                    [_dataArray removeAllObjects];
                }
                
                NSArray * subArray = [model.data objectForKey:@"pageData"];
                for (int i=0; i<subArray.count; i++) {
                    YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
                    [dataModel creatModelWithDic:[subArray objectAtIndex:i]];
                    [_dataArray insertObject:dataModel atIndex:i];
                }

            }
           
           
        }else if([model.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_FAILED intValue]){
            //做数据失败的处理
            
        }
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
    } andFail:^(YHBaseError *error) {
         [_tableView.header endRefreshing];
    } isbuffer:NO];

}

-(void)reLoadData{
    NSDictionary * dic =@{INTERFACE_FIELD_MOCKEXAM_CODE:[NSString stringWithFormat:@"%@",_dataModel.typecode],INTERFACE_FIELD_MOCKEXAM_PAGEINDEX:[NSString stringWithFormat:@"%d",++_currentPage],INTERFACE_FIELD_MOCKEXAM_PAGESIZE:[NSString stringWithFormat:@"%d",REQUEST_PAGE_SIZE]};
    //开启刷新状态
    [_tableView.footer beginRefreshing];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamListFirst infoDic:dic Succsee:^(NSData *data) {
        //数据处理
        NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSAMockExamMainListModel * model = [[YHSAMockExamMainListModel alloc]init];
        [model creatModelWithDic:dataDic];
        if ([model.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_SUCCESS intValue]) {
            //数据正确 进行数据封装
            NSArray * subArray = [model.data objectForKey:@"pageData"];
                for (int i=0; i<subArray.count; i++) {
                    YHSAMockExamMainListDataModel * dataModel = [[YHSAMockExamMainListDataModel alloc]init];
                    [dataModel creatModelWithDic:[subArray objectAtIndex:i]];
                    [_dataArray addObject:dataModel];
                }
            if (_dataArray.count==_examCount) {
                [_tableView ReloadEnd];
            }
        }else if([model.resultCode intValue] == [INTERFACE_RETURN_MOCKEXAM_FAILED intValue]){
            //做数据失败的处理
            
        }
        
        [_tableView reloadData];
        [_tableView.footer endRefreshing];
    } andFail:^(YHBaseError *error) {
        [_tableView.footer endRefreshing];
    } isbuffer:NO];

}

#pragma mark - 创建视图
-(void)YHCreatView{
    if (!_isSearch) {
        self.title = _dataModel.typename;
    }
    _tableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //刷新和加载都打开
    if (!_isSearch) {
        [_tableView shouldRefresh:^{
            //进行数据刷新
            [self reDownData];
        }];
    }
    //是否可以进行上拉加载
    if (_status==0&&_dataArray.count<_examCount) {
        [_tableView shouldReload:^{
            [self reLoadData];
        }];
    }
    [self.view addSubview:_tableView];
}



-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * model = [YHTopicColorManager sharedTheSingletion];
    [model getTopicModel];
    self.view.backgroundColor = model.bgColor;
    _tableView.backgroundColor = model.bgColor;
}



#pragma mark - tableView delegate
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
    if (_status==1) {
        cell.textLabel.text = model.typename;
    }else{
        cell.textLabel.text = model.examname;
    }
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //进行传值跳转
    YHSAMockExamMainListDataModel * model = _dataArray[indexPath.row];
    if (_status==1) {
        //分类的目录
        [self pushOne:model];
    }else{
        [self pushTwo:model];
    }
    
}
//分类目录的跳转
-(void)pushOne:(YHSAMockExamMainListDataModel*)model{
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

-(void)pushTwo:(YHSAMockExamMainListDataModel *)model{
    //试卷详情的跳转
    YHSAMockExamDetailsViewController * con = [[YHSAMockExamDetailsViewController alloc]init];
    con.examID = model.examid;
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
