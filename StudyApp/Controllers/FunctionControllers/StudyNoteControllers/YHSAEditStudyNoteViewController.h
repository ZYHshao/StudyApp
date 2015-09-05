//
//  YHSAEditStudyNoteViewController.h
//  StudyApp
//
//  Created by apple on 15/9/5.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseViewController.h"
typedef enum {
    YHSAEditStudyNoteViewControllerTypeNew,
    YHSAEditStudyNoteViewControllerTypeEdit
}YHSAEditStudyNoteViewControllerType;
@interface YHSAEditStudyNoteViewController : YHBaseViewController
__PROPERTY_NO_ASSIGN__(YHSAEditStudyNoteViewControllerType, type);
__PROPERTY_NO_STRONG__(NSNumber *, noteId);
@end
