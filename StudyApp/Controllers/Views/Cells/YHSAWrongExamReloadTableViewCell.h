//
//  YHSAWrongExamReloadTableViewCell.h
//  StudyApp
//
//  Created by apple on 15/9/13.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSAWrongExamReloadTableViewCell;
@protocol YHSAWrongExamReloadCellDelegate <NSObject>

-(void)clickBtn:(YHSAWrongExamReloadTableViewCell *)cell;

@end

@interface YHSAWrongExamReloadTableViewCell : UITableViewCell<UITextFieldDelegate>
//题型数据源数组 这个在设计上存在一些问题 这个数组一定要最后赋值
__PROPERTY_NO_STRONG__(NSMutableArray *, dataArray);
//用户选择题数的字典
__PROPERTY_NO_STRONG__(NSMutableDictionary *,userDic);
__PROPERTY_NO_STRONG__(NSString *, theTitle);
__PROPERTY_NO_WEAK__(id<YHSAWrongExamReloadCellDelegate>, delegate);
//标记当前的cell index
__PROPERTY_NO_ASSIGN__(int, indexRow);
@end
