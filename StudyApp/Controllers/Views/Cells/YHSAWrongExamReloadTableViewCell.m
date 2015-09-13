//
//  YHSAWrongExamReloadTableViewCell.m
//  StudyApp
//
//  Created by apple on 15/9/13.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAWrongExamReloadTableViewCell.h"
#import "YHSASubWrongRecordModel.h"
@implementation YHSAWrongExamReloadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self creatView];
}
-(void)creatView{
    [self.contentView removeAllSubviews];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.width-20,40)];
    titleLabel.text = _theTitle;
    [self.contentView addSubview:titleLabel];
    for (int i=0; i<_dataArray.count; i++) {
        YHSASubWrongRecordModel * model = _dataArray[i];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 45+i*30, self.frame.size.width-60, 20)];
        label.text = [NSString stringWithFormat:@"%@  存有%@道答错过的试题       抽取",model.txname,model.count];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(self.frame.size.width-50, 45+i*30, 40, 20)];
        field.tag=801+i;
        field.borderStyle = UITextBorderStyleLine;
        field.delegate=self;
        [self.contentView addSubview:field];
    }
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(self.frame.size.width/2-50, 45+30*_dataArray.count, 100, 30);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"开始组卷" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:button];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
