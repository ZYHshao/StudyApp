//
//  YHSAStudyNoteListTableViewCell.m
//  StudyApp
//
//  Created by apple on 15/9/4.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAStudyNoteListTableViewCell.h"

@implementation YHSAStudyNoteListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)reviseClick:(id)sender {
    if ([self.YHDelegate respondsToSelector:@selector(YHSAStudyNoteListTableViewCellClickRevise:)]) {
        [self.YHDelegate YHSAStudyNoteListTableViewCellClickRevise:_indexRow];
    }
}
- (IBAction)deleteClick:(id)sender {
    if ([self.YHDelegate respondsToSelector:@selector(YHSAStudyNoteListTableViewCellClickDelete:)]) {
        [self.YHDelegate YHSAStudyNoteListTableViewCellClickDelete:_indexRow];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
