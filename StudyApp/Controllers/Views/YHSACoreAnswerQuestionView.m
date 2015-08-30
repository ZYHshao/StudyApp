//
//  YHSACoreAnswerQuestionView.m
//  
//
//  Created by user on 15/8/24.
//
//这个界面将题目和答案的视图分层 便于边阅题边做答 答案最低为1/4 最高为3/4

#import "YHSACoreAnswerQuestionView.h"
#import "YHSAAnswerQuestionModel.h"
#import "YHTopicColorManager.h"
#import "YHSAAnswerQuestionTableViewCell.h"
@interface YHSACoreAnswerQuestionView()<UITableViewDataSource,UITableViewDelegate,YHBaseHtmlViewProcotop>
{
    //题目视图
    YHBaseScrollView * _titleScrollView;
    //题目label,加载时动态确定大小
    YHBaseHtmlView * _titleView;
    //选项答题视图
    YHBaseTableView * _answerTableView;
    //tableView的数据源数组
    NSMutableArray * _tableViewDataArray;
    //选项图片数组
    NSMutableArray * _tableViewImageArray;
    //tableView的头视图
    YHBaseHtmlView * _tableViewHeaderLabel;
    UIView * _tableViewHeadView;
    //手势视图
    UIView * _gestureView;
    //手势
    UIPanGestureRecognizer * _panGesture;
}
@end


@implementation YHSACoreAnswerQuestionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)dealloc{
    [_gestureView removeGestureRecognizer:_panGesture];
}

-(void)clearData{
    _answerTableView.frame=CGRectMake(0,(self.frame.size.height-64)/4*3-60, self.frame.size.width, (self.frame.size.height-64)/4+60);
    _titleScrollView.contentOffset=CGPointMake(0, 0);
    [_tableViewHeaderLabel reSetHtmlStr:@""];
    [_tableViewImageArray removeAllObjects];
    [_tableViewDataArray removeAllObjects];
    [_answerTableView reloadData];
}
//把数据的读取和加载部分放在这个方法中
-(void)creatViewWithData:(id)data{
    YHSAAnswerQuestionModel * model = data;
    
    [_titleView reSetHtmlStr:[NSString stringWithFormat:@"%@:%@",model.typename,model.content]];
    //计算大小
    
        //这里多加60
    _titleScrollView.contentSize = CGSizeMake(0, _titleView.frame.size.height+60);
    
    
    //进行tableView的加载
    if (_tableViewDataArray==nil) {
        _tableViewDataArray = [[NSMutableArray alloc]init];
    }
    if (_tableViewImageArray==nil) {
        _tableViewImageArray = [[NSMutableArray alloc]init];
    }
    
    [_tableViewImageArray removeAllObjects];
    [_tableViewDataArray removeAllObjects];
    //先加题目
    if (model.secondcontent==nil) {
        [_tableViewDataArray addObject:@""];
    }else{
        [_tableViewDataArray addObject:model.secondcontent];

    }
       //添加选项
    if (model.option1.length>0) {
        [_tableViewDataArray addObject:model.option1];
    }
    if (model.option2.length>0) {
        [_tableViewDataArray addObject:model.option2];
    }
    if (model.option3.length>0) {
        [_tableViewDataArray addObject:model.option3];
    }
    if (model.option4.length>0) {
        [_tableViewDataArray addObject:model.option4];
    }
    if (model.option5.length>0) {
        [_tableViewDataArray addObject:model.option5];
    }
//    //添加图片
//    if (model.optionImg1.length>0) {
//        [_tableViewImageArray addObject:model.optionImg1];
//    }else{
//         [_tableViewImageArray addObject:@""];
//    }
//    if (model.optionImg2.length>0) {
//        [_tableViewImageArray addObject:model.optionImg2];
//    }else{
//        [_tableViewImageArray addObject:@""];
//    }
//    if (model.optionImg3.length>0) {
//        [_tableViewImageArray addObject:model.optionImg3];
//    }else{
//        [_tableViewImageArray addObject:@""];
//    }
//    if (model.optionImg4.length>0) {
//        [_tableViewImageArray addObject:model.optionImg4];
//    }else{
//        [_tableViewImageArray addObject:@""];
//    }
//    if (model.optionImg5.length>0) {
//        [_tableViewImageArray addObject:model.optionImg5];
//    }else{
//        [_tableViewImageArray addObject:@""];
//    }
    [_answerTableView reloadData];
    
   
}
-(void)reloadView{
    _titleScrollView = [[YHBaseScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height-64)/4*3)];
    _titleScrollView.bounces = NO;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    //这里的高度随便设 可以自适应
    _titleView = [[YHBaseHtmlView alloc]initWithFrame:CGRectMake(0, 0, _titleScrollView.frame.size.width, 100)];
    _titleView.delegate=self;
    [_titleScrollView addSubview:_titleView];
    [self addSubview:_titleScrollView];
    
    //初始位置设置在题目视图下
    _answerTableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0,(self.frame.size.height-64)/4*3-60, self.frame.size.width, (self.frame.size.height-64)/4+60) style:UITableViewStylePlain];
    _answerTableView.dataSource=self;
    _answerTableView.delegate=self;
    _answerTableView.bounces=NO;
    _answerTableView.showsHorizontalScrollIndicator = NO;
    _answerTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_answerTableView];
    
    if (_tableViewHeaderLabel==nil) {
        _tableViewHeaderLabel = [[YHBaseHtmlView alloc]initWithFrame:CGRectMake(0, 20,_answerTableView.frame.size.width,0)];
        _tableViewHeaderLabel.delegate=self;
    }
    _tableViewHeadView = [[UIView alloc]init];
    [_tableViewHeadView addSubview:_tableViewHeaderLabel];
    //对透视图的手势控制
    [self creatGesture];
}

#pragma mark - 分屏的手势
-(void)creatGesture{
     _gestureView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, _answerTableView.frame.size.width, 20)];
    _gestureView.backgroundColor = [UIColor grayColor];
    [_tableViewHeadView addSubview:_gestureView];
    //添加手势
    _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureFunc:)];
    [_gestureView addGestureRecognizer:_panGesture];
}

-(void)panGestureFunc:(UIPanGestureRecognizer *)ges{
    CGPoint point = [ges locationInView:self];
    if (point.y<=(self.frame.size.height-64)/4*3&&point.y>=(self.frame.size.height-64)/4) {
        //移动答题tableView
        _answerTableView.frame=CGRectMake(0, point.y, _answerTableView.frame.size.width, self.frame.size.height-64-point.y);
    }
}



-(void)setTopic{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.backgroundColor = manager.bgColor;
    _titleScrollView.backgroundColor = manager.greyBgColor;
    _titleView.backgroundColor = manager.greyBgColor;
    _answerTableView.backgroundColor = manager.bgColor;
    _tableViewHeaderLabel.backgroundColor = manager.bgColor;
    _tableViewHeadView.backgroundColor =manager.bgColor;
}




#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataArray.count-1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_tableViewDataArray.count>1&&[_tableViewDataArray[0] length]>0) {
        //计算文字高度
        [_tableViewHeaderLabel reSetHtmlStr:[NSString stringWithFormat:@"%d.%@",_index,_tableViewDataArray[0]]];
        return _tableViewHeaderLabel.frame.size.height+20;
    }else{
        return 20;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_tableViewDataArray.count>0&&[_tableViewDataArray[0] length]>0) {
        //计算文字高度
           [_tableViewHeaderLabel reSetHtmlStr:[NSString stringWithFormat:@"%d.%@",_index,_tableViewDataArray[0]]];
            _tableViewHeadView.frame=CGRectMake(0, 0, tableView.frame.size.width, _tableViewHeaderLabel.frame.size.height+20);
        return _tableViewHeadView;
    }else{
        _tableViewHeadView.frame=CGRectMake(0, 0,tableView.frame.size.width,20);
        return _tableViewHeadView;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算cell大小
    
    YHBaseHtmlView * temView = [[YHBaseHtmlView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width-60, 100)];
    [temView reSetHtmlStr:_tableViewDataArray[indexPath.row+1]];
    
    CGFloat cellH = temView.frame.size.height+20;
    if (cellH<44) {
        return 44;
    }else{
        return cellH;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHSAAnswerQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_ID_ANSWER_QUESTION];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YHSAAnswerQuestionTableViewCell" owner:self  options:nil] lastObject];
        cell.indexLabel.layer.masksToBounds = YES;
        cell.indexLabel.layer.cornerRadius = 10;
        cell.theContentView.delegate=self;
    }
    cell.indexLabel.text = [NSString stringWithFormat:@"%c",(int)indexPath.row+'A'];
    [cell.theContentView reSetHtmlStr:_tableViewDataArray[indexPath.row+1]];
    //位置设置
    return cell;
}



#pragma mark - htmlView delegate
-(void)YHBaseHtmlView:(YHBaseHtmlView *)htmlView SizeChanged:(CGSize)size{
    if (htmlView==_titleView) {
        _titleScrollView.contentSize = CGSizeMake(0, _titleView.frame.size.height+60);
    }else{//有关tableView的
        [_answerTableView reloadData];
    }
    
}











@end
