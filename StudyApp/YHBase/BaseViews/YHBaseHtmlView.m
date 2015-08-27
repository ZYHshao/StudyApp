//
//  YHBaseHtmlView.m
//  StudyApp
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseHtmlView.h"
#import "RCLabel.h"

@interface YHBaseHtmlView()<RTLabelSizeDelegate,YHRTLabelImageDelegate>
{
    RCLabel * _rcLabel;
    //保存属性 用于异步加载完成后刷新
    RTLabelComponentsStructure * _origenComponent;
    NSString * _srt;
}

@end

@implementation YHBaseHtmlView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _rcLabel = [[RCLabel alloc]initWithFrame:self.frame];
        [self addSubview:_rcLabel];
    }
    return self;
}
-(void)reSetHtmlStr:(NSString *)htmlStr{
    _srt = htmlStr;
    _rcLabel.imageDelegate=self;
    _rcLabel.sizeDelegate=self;
    _origenComponent = [RCLabel extractTextStyle:htmlStr IsLocation:NO withRCLabel:_rcLabel];
    _rcLabel.componentsAndPlainText = _origenComponent;
   
    CGSize size = [_rcLabel optimumSize];
    _rcLabel.frame=CGRectMake(0, 0, _rcLabel.frame.size.width, size.height);
    self.frame=_rcLabel.frame;
}
-(void)YHRTLabelImageSuccess:(RCLabel *)label{
    NSLog(@"图片下载完成");
    _origenComponent = [RCLabel extractTextStyle:_srt IsLocation:NO withRCLabel:_rcLabel];
    _rcLabel.componentsAndPlainText = _origenComponent;

}

-(void)rtLabel:(id)rtLabel didChangedSize:(CGSize)size{
    NSLog(@"21");
}
@end
