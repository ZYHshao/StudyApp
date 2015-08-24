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
@interface YHSACoreAnswerQuestionView()
{
    //题目视图
    YHBaseScrollView * _titleScrollView;
    //题目label,加载时动态确定大小
    YHBaseView * _titleView;
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


-(void)clearData{
    NSArray * arr = _titleView.subviews;
    for (UIView *view in arr) {
        [view removeFromSuperview];
    }
}
//把数据的读取和加载部分放在这个方法中
-(void)creatViewWithData:(id)data{
    NSArray * arr = _titleView.subviews;
    for (UIView *view in arr) {
        [view removeFromSuperview];
    }
    YHSAAnswerQuestionModel * model = data;
    YHBaseTypesettingEngine * engine = [[YHBaseTypesettingEngine alloc]initWithText:[NSString stringWithFormat:@"%d.%@\n%@",_index,model.content,model.secondcontent]];
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
    _titleScrollView.contentSize = CGSizeMake(0, _titleView.frame.size.height);
   
}
-(void)reloadView{
    _titleScrollView = [[YHBaseScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height-64)/4*3)];
    _titleScrollView.bounces = NO;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    
    _titleView = [[YHBaseView alloc]init];
    [_titleScrollView addSubview:_titleView];
    [self addSubview:_titleScrollView];
}
-(void)setTopic{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.backgroundColor = manager.bgColor;
    _titleScrollView.backgroundColor = manager.greyBgColor;
    _titleView.backgroundColor = manager.greyBgColor;
}
@end
