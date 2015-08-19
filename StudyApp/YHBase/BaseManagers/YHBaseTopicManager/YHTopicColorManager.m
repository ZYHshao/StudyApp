//
//  YHTopicColorManager.m
//  
//
//  Created by user on 15/8/17.
//
//

#import "YHTopicColorManager.h"


@implementation YHTopicColorManager
+(instancetype)sharedTheSingletion{
    static YHTopicColorManager * sharedModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedModel = [[YHTopicColorManager alloc] init];
    });
    return sharedModel;
}



-(void)getTopicModel{
    //从本地读取
    NSString * tp = [[NSUserDefaults standardUserDefaults]objectForKey:TOPIC];
    if (tp==nil) {
        //默认为白天主题
        tp=[NSString stringWithFormat:@"%d",dayTime];
        [[NSUserDefaults standardUserDefaults]setObject:tp forKey:TOPIC];
    }
    switch ([tp intValue]) {
        case 1://白天模式
        {
            _navColor=[UIColor colorWithRed:10/255.0 green:85/255.0 blue:160/255.0 alpha:1];
            _bgColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
            _btnColor=[UIColor colorWithRed:10/255.0 green:85/255.0 blue:160/255.0 alpha:1];
            _textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
            _btnTextColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
            _navTextColor= [UIColor whiteColor];
        }
            break;
        case 2://夜间模式
        {
            
        }
            break;
        default:
            break;
    }
}
@end
