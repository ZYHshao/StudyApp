//
//  YHTopicColorModel.h
//  
//
//  Created by user on 15/8/17.
//
//具体的主题对象,单例

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHSingletonProcotol.h"
#import "YHTopicProtocol.h"
@interface YHTopicColorModel : NSObject<YHSingletonProcotol>


@property(nonatomic,readonly)UIColor * bgColor;
@property(nonatomic,readonly)UIColor * navColor;
@property(nonatomic,readonly)UIColor * btnColor;
@property(nonatomic,readonly)UIColor * labelColor;
@property(nonatomic,readonly)UIColor * textColor;


/**
 *使用之前需先调用这个方法进行设置主题
 */
-(void)getTopicModel;
@end
