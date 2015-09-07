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
#import "YHSAAnswerQuestionManager.h"
#import "YHSAAnswerStateModel.h"
@interface YHSACoreAnswerQuestionView()<UITableViewDataSource,UITableViewDelegate,YHBaseHtmlViewProcotop,UITextViewDelegate>
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
    //tableView的尾视图
    YHBaseHtmlView * _tableViewFooterLabel;
    UIView * _tableViewFootView;
    UIImageView * _tableViewFootImageView;
    //手势视图
    UIView * _gestureView;
    //手势
    UIPanGestureRecognizer * _panGesture;
    //题目类型 1 单选 2 多选 3 单行文本  4 多行文本
    int _questionType;
    //文字题的输入框
    YHBaseTextView * _answerTextView;
    
    //当前题目的模型
    __strong YHSAAnswerQuestionModel * _currentModel;
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
    _currentModel = model;
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
    
    _questionType = [model.type intValue];
    
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
    _answerTableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0,(self.frame.size.height-64)/4*3-60, self.frame.size.width, (self.frame.size.height-64)/4+60) style:UITableViewStyleGrouped];
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
    if (_tableViewFooterLabel==nil) {
        _tableViewFooterLabel = [[YHBaseHtmlView alloc]initWithFrame:CGRectMake(0, 20,_answerTableView.frame.size.width,0)];
        _tableViewFooterLabel.delegate=self;
    }
    _tableViewHeadView = [[UIView alloc]init];
    _tableViewFootView = [[UIView alloc]init];
    
    _tableViewFootImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
    [_tableViewFootView addSubview:_tableViewFootImageView];
    [_tableViewFootView addSubview:_tableViewFooterLabel];
    [_tableViewHeadView addSubview:_tableViewHeaderLabel];
    //对透视图的手势控制
    [self creatGesture];
    
    
    _answerTextView = [[YHBaseTextView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, 60)];
    _answerTextView.placeHolder=@"请填写您的答案";
    _answerTextView.delegate=self;
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
    if (_questionType==3||_questionType==4) {//文本题
        return 1;
    }else{
        return _tableViewDataArray.count-1;
    }
   
}
//=====================如果已经交卷 或者这道题查看过答案的话 进行尾视图的显示=====================
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    YHSAAnswerQuestionManager * manager = [YHSAAnswerQuestionManager sharedTheSingletion];
    if (_index<1) {
        return 0;
    }
    if (manager.hadHeanIn||[manager.dataArray[_index-1] hadLookAnswer]) {
        //计算文字高度
        [_tableViewFooterLabel reSetHtmlStr:[NSString stringWithFormat:@"答案:%@\n解析:%@",_currentModel.Answer,(_currentModel.discription.length>0?_currentModel.discription:@"无")]];
        return _tableViewFooterLabel.frame.size.height+20;
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     YHSAAnswerQuestionManager * manager = [YHSAAnswerQuestionManager sharedTheSingletion];
    if (_index<1) {
        return nil;
    }
    if (manager.hadHeanIn||[manager.dataArray[_index-1] hadLookAnswer]) {
        [_tableViewFooterLabel reSetHtmlStr:[NSString stringWithFormat:@"答案:%@\n解析:%@",_currentModel.Answer,(_currentModel.discription.length>0?_currentModel.discription:@"无")]];
         _tableViewFootView.frame=CGRectMake(0, 0, tableView.frame.size.width, _tableViewFooterLabel.frame.size.height+20);
        if ([manager.dataArray[_index-1] isCorrect]) {
            _tableViewFootImageView.image = [UIImage imageNamed:MOCK_EXAM_ANSWER_CURRECT_IMAGE];
        }else{
             _tableViewFootImageView.image = [UIImage imageNamed:MOCK_EXAM_ANSWER_WRONG_IMAGE];
        }
        return _tableViewFootView;
    }else{
        return nil;
    }

}

//=======================================================================================


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
    if (_questionType==3||_questionType==4) {
        return 70;
    }else{
        YHBaseHtmlView * temView = [[YHBaseHtmlView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width-60, 100)];
        [temView reSetHtmlStr:_tableViewDataArray[indexPath.row+1]];
        
        CGFloat cellH = temView.frame.size.height+20;
        if (cellH<44) {
            return 44;
        }else{
            return cellH;
        }

    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHSAAnswerStateModel * stateModel = [YHSAAnswerQuestionManager sharedTheSingletion].dataArray[_index-1];
    if (_questionType==3||_questionType==4) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:_answerTextView];
        }
        //判断是否已经做答过
        if (stateModel.hadAnswer) {
            _answerTextView.text = [stateModel.info objectForKey:@"ans"];
        }else{
            _answerTextView.text=@"";
        }
        //已经交卷 或者这道题已经查看过答案 则关闭交互
        if ([YHSAAnswerQuestionManager sharedTheSingletion].hadHeanIn||stateModel.hadLookAnswer) {
            _answerTextView.editable=NO;
        }else{
             _answerTextView.editable=YES;
        }
        return cell;
        
    }else{
        YHSAAnswerQuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_ID_ANSWER_QUESTION];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"YHSAAnswerQuestionTableViewCell" owner:self  options:nil] lastObject];
            cell.indexLabel.layer.masksToBounds = YES;
            cell.indexLabel.layer.cornerRadius = 10;
            cell.theContentView.delegate=self;
        }
        cell.indexLabel.text = [NSString stringWithFormat:@"%c",(int)indexPath.row+'A'];
        [cell.theContentView reSetHtmlStr:_tableViewDataArray[indexPath.row+1]];
        //判断是否已经答过
        if (stateModel.hadAnswer) {
            NSString * ansStr = [stateModel.info objectForKey:@"ans"];
            BOOL had=NO;
            for (int i=0; i<ansStr.length; i++) {
                if (indexPath.row+'A' == [ansStr characterAtIndex:i]) {
                    cell.indexLabel.backgroundColor = [UIColor cyanColor];
                    had=YES;
                }
            }
            if (had==NO) {
                cell.indexLabel.backgroundColor=[UIColor grayColor];
            }
        }else{
             cell.indexLabel.backgroundColor = [UIColor grayColor];
        }
        return cell;
    }
}



#pragma mark - htmlView delegate
-(void)YHBaseHtmlView:(YHBaseHtmlView *)htmlView SizeChanged:(CGSize)size{
    if (htmlView==_titleView) {
        _titleScrollView.contentSize = CGSizeMake(0, _titleView.frame.size.height+60);
    }else{//有关tableView的
        [_answerTableView reloadData];
    }
    
}

#pragma mark - 这里做答题的处理

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //处理交互
     YHSAAnswerStateModel * stateModel = [YHSAAnswerQuestionManager sharedTheSingletion].dataArray[_index-1];
    if ([YHSAAnswerQuestionManager sharedTheSingletion].hadHeanIn||stateModel.hadLookAnswer) {
        return;
    }
    //进行数据的存储
    //判断题目的类型
    if (_questionType==1) {//单选题
        YHSAAnswerStateModel * model = [[YHSAAnswerStateModel alloc]init];
        model.questionID = _currentModel.id;
        model.sccore = _currentModel.score;
        model.hadAnswer = YES;
        //判断是否正确
        if ([[NSString stringWithFormat:@"%c",(int)indexPath.row+'A'] isEqualToString:_currentModel.Answer]) {
            model.isCorrect=YES;
        }else{
            model.isCorrect=NO;
        }
        NSDictionary * tmpDic = @{@"type":_currentModel.type,@"ans":[NSString stringWithFormat:@"%c",(int)indexPath.row+'A']};
        model.info=tmpDic;
        [[YHSAAnswerQuestionManager sharedTheSingletion].dataArray replaceObjectAtIndex:_index-1 withObject:model];
    }else if (_questionType==2){//多选题
        //先取model
        YHSAAnswerStateModel * model = [[YHSAAnswerQuestionManager sharedTheSingletion].dataArray objectAtIndex:_index-1];
        model.questionID = _currentModel.id;
        model.sccore = _currentModel.score;
        NSString * ansStr = [model.info objectForKey:@"ans"];
        NSMutableString * newAnsStr = [[NSMutableString alloc]init];
        //先判断是否已经有这个选项
        BOOL hadChara = NO;
        for (int i=0; i<ansStr.length; i++) {
            if ([ansStr characterAtIndex:i]=='A'+(int)indexPath.row) {
                //取消选中
                hadChara = YES;
            }else{
                [newAnsStr appendString:[NSString stringWithFormat:@"%c",[ansStr characterAtIndex:i]]];
            }
        }
        //如果没有这个选项 进行添加
        if (!hadChara) {
            [newAnsStr appendString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]];
        }
        //判断答案是否正确
        NSArray * temArr = [_currentModel.Answer componentsSeparatedByString:@","];
        NSMutableString * comStr = [[NSMutableString alloc]init];
        for (int i=0; i<temArr.count; i++) {
            [comStr appendString:temArr[i]];
        }
        //进行从小到大的字符排序
        NSString * finalStr = YHBaseSequenceString(YHBaseStringCompareLonger, newAnsStr);
        if (finalStr.length!=0) {
            model.hadAnswer=YES;
        }else{
            model.hadAnswer=NO;
        }
        //进行数据的存储
        if ([finalStr isEqualToString:comStr]) {//答案正确
            model.isCorrect=YES;
        }else{
            model.isCorrect=NO;
        }
        NSDictionary * temDic = @{@"type":_currentModel.type,@"ans":finalStr};
        model.info = temDic;
        
    }else if (_questionType==3||_questionType==4){//文字题
       //在textView的代理方法中处理
    }
    [_answerTableView reloadData];
}


-(void)textViewDidChange:(UITextView *)textView{
     YHSAAnswerStateModel * model = [[YHSAAnswerQuestionManager sharedTheSingletion].dataArray objectAtIndex:_index-1];
    model.questionID = _currentModel.id;
    model.sccore = _currentModel.score;
    if (_answerTextView.text.length!=0) {
        model.hadAnswer=YES;
        if ([_currentModel.Answer isEqualToString:_answerTextView.text]) {
            model.isCorrect=YES;
        }else{
            model.isCorrect=NO;
        }
        NSDictionary * temDic = @{@"type":_currentModel.type,@"ans":_answerTextView.text};
        model.info = temDic;
    }else{
        model.hadAnswer=NO;
    }
}
//移动answerTableView
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.3 animations:^{
        //移动答题tableView
        _answerTableView.frame=CGRectMake(0,(self.frame.size.height-64)/4,self.frame.size.width, (self.frame.size.height-64)/4*3);
        
    }];
    return YES;
}

-(void)updataView{
    [_answerTableView reloadData];
}



@end
