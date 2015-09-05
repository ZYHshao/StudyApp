//
//  YHSAStudyNoteListTableViewCell.h
//  StudyApp
//
//  Created by apple on 15/9/4.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSAStudyNoteListTableViewCell;
@protocol YHSAStudyNoteListTableViewCellDelegate
-(void)YHSAStudyNoteListTableViewCellClickRevise:(int)indexRow;
-(void)YHSAStudyNoteListTableViewCellClickDelete:(int)indexRow;
@end




@interface YHSAStudyNoteListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *theTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIButton *reviseButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

//标记index
__PROPERTY_NO_ASSIGN__(int, indexRow);
__PROPERTY_NO_WEAK__(id, YHDelegate);
@end
