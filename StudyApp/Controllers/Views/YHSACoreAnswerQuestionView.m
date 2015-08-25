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
#import <SDWebImage/UIImageView+WebCache.h>
#import "YHSAAnswerQuestionTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface YHSACoreAnswerQuestionView()<UITableViewDataSource,UITableViewDelegate>
{
    //题目视图
    YHBaseScrollView * _titleScrollView;
    //题目label,加载时动态确定大小
    YHBaseView * _titleView;
    //选项答题视图
    YHBaseTableView * _answerTableView;
    //tableView的数据源数组
    NSMutableArray * _tableViewDataArray;
    //选项图片数组
    NSMutableArray * _tableViewImageArray;
    //tableView的头视图
    UILabel * _tableViewHeaderLabel;
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
    NSArray * arr = _titleView.subviews;
    for (UIView *view in arr) {
        [view removeFromSuperview];
    }
    [_tableViewImageArray removeAllObjects];
    [_tableViewDataArray removeAllObjects];
    [_answerTableView reloadData];
}
//把数据的读取和加载部分放在这个方法中
-(void)creatViewWithData:(id)data{
    NSArray * arr = _titleView.subviews;
    for (UIView *view in arr) {
        [view removeFromSuperview];
    }
    YHSAAnswerQuestionModel * model = data;
    YHBaseTypesettingEngine * engine = [[YHBaseTypesettingEngine alloc]initWithText:[NSString stringWithFormat:@"%@:%@",model.typename,model.content]];
    YHBaseTypesettingEngineModel * enM = [[YHBaseTypesettingEngineModel alloc]init];
    enM.field = @"[*]";
    enM.type = YHBaseTypesettingImage;
    [engine setModelArray:@[enM]];
    [engine startEngineInSize:CGSizeMake(_titleScrollView.frame.size.width-40, _titleScrollView.frame.size.height)];
    _titleView.frame = CGRectMake(0, 20, _titleScrollView.frame.size.width, [engine getTheTypesettingView].frame.size.height);
    [_titleView addSubview:[engine getTheTypesettingView]];
    NSArray * imageArray = [NSArray arrayWithArray:[engine getTheTypesettingNode:YHBaseTypesettingImage]];
    //进行图片的加载
    NSArray * urlArray = [model.contentImg componentsSeparatedByString:@","];
    for (int i=0; i<imageArray.count; i++) {
        UIImageView * img = imageArray[i];
        [img sd_setImageWithURL:[NSURL URLWithString:urlArray[i]]];
    }
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
    [_tableViewDataArray addObject:model.secondcontent];
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
    //添加图片
    if (model.optionImg1.length>0) {
        [_tableViewImageArray addObject:model.optionImg1];
    }else{
         [_tableViewImageArray addObject:@""];
    }
    if (model.optionImg2.length>0) {
        [_tableViewImageArray addObject:model.optionImg2];
    }else{
        [_tableViewImageArray addObject:@""];
    }
    if (model.optionImg3.length>0) {
        [_tableViewImageArray addObject:model.optionImg3];
    }else{
        [_tableViewImageArray addObject:@""];
    }
    if (model.optionImg4.length>0) {
        [_tableViewImageArray addObject:model.optionImg4];
    }else{
        [_tableViewImageArray addObject:@""];
    }
    if (model.optionImg5.length>0) {
        [_tableViewImageArray addObject:model.optionImg5];
    }else{
        [_tableViewImageArray addObject:@""];
    }
    [_answerTableView reloadData];
    
   
}
-(void)reloadView{
    _titleScrollView = [[YHBaseScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height-64)/4*3)];
    _titleScrollView.bounces = NO;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    
    _titleView = [[YHBaseView alloc]init];
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
        _tableViewHeaderLabel = [[UILabel alloc]init];
        _tableViewHeaderLabel.numberOfLines=0;
      
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
    _tableViewHeaderLabel.textColor=manager.textColor;
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
        _tableViewHeaderLabel.text=[NSString stringWithFormat:@"%d.%@",_index,_tableViewDataArray[0]];
       CGSize size = [YHBaseGeometryTools getLabelSize:_tableViewHeaderLabel inConstrainedSize:CGSizeMake(tableView.frame.size.width-20, MAXFLOAT)];
        return size.height+20;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([_tableViewDataArray[0] length]>0) {
        //计算文字高度
           _tableViewHeaderLabel.text=[NSString stringWithFormat:@"%d.%@",_index,_tableViewDataArray[0]];
           CGSize size = [YHBaseGeometryTools getLabelSize:_tableViewHeaderLabel inConstrainedSize:CGSizeMake(tableView.frame.size.width-20, MAXFLOAT)];
           _tableViewHeaderLabel.frame=CGRectMake(10, 20, tableView.frame.size.width-20, size.height);
            _tableViewHeadView.frame=CGRectMake(0, 0, tableView.frame.size.width, _tableViewHeaderLabel.frame.size.height+20);
        return _tableViewHeadView;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //计算cell大小
    CGFloat imageHight;
    UILabel * label = [[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:14];
    label.text = _tableViewDataArray[indexPath.row];
    CGSize size = [YHBaseGeometryTools getLabelSize:label inConstrainedSize:CGSizeMake(262, MAXFLOAT)];
    if ([_tableViewImageArray[indexPath.row] length]>0) {
        imageHight = 40+10;
    }else{
        imageHight = 0;
    }
    CGFloat cellH = imageHight+size.height+10+10;
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
    }
    if ([_tableViewImageArray[indexPath.row] length]>0) {
        cell.theImageView.hidden=NO;
        cell.theImageView.image=nil;
        [cell.theImageView sd_setImageWithURL:[NSURL URLWithString:_tableViewImageArray[indexPath.row]]];
    }else{
        cell.theImageView.image=nil;
        cell.theImageView.hidden=YES;
    }
    cell.indexLabel.text = [NSString stringWithFormat:@"%c",(int)indexPath.row+'A'];
    cell.contentLabel.text = _tableViewDataArray[indexPath.row];
    //位置设置
    CGSize size = [YHBaseGeometryTools getLabelSize:cell.contentLabel inConstrainedSize:CGSizeMake(cell.contentLabel.frame.size.width, MAXFLOAT)];
    cell.contentLabel.frame=CGRectMake(cell.contentLabel.frame.origin.x, cell.contentLabel.frame.origin.y, cell.contentLabel.frame.size.width, size.height);
    cell.theImageView.frame=CGRectMake(cell.theImageView.frame.origin.x, 20+size.height, cell.theImageView.frame.size.width, cell.theImageView.frame.size.height);
    return cell;
}















@end
