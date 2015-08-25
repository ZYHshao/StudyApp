//
//  YHBaseSelfServiceDrawControlView.m
//  
//
//  Created by user on 15/8/25.
//
//

#import "YHBaseSelfServiceDrawControlView.h"
@interface YHBaseSelfServiceDrawControlView()
{
    //双指的滑动手势
    UIPanGestureRecognizer * _gesture;
    //记录移动的开始点
    CGPoint _startPoint;
    CGFloat _lineWidth;
    UIColor * _lineColor;
    UIColor * _drawViewColor;
}
@end
@implementation YHBaseSelfServiceDrawControlView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc{
    [self removeGestureRecognizer:_gesture];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _drawView = [[YHBaseSelfServiceDrawView alloc]init];
        _gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        _gesture.minimumNumberOfTouches=2;
        [self addGestureRecognizer:_gesture];
        [self addSubview:_drawView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _drawView = [[YHBaseSelfServiceDrawView alloc]init];
        _width=frame.size.width;
        _height=frame.size.height;
        _gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        _gesture.minimumNumberOfTouches=2;
        [self addGestureRecognizer:_gesture];
        [self addSubview:_drawView];
        
        }
    return self;
}

-(void)setDrawSize:(CGSize)size{
    _drawView.frame = CGRectMake(_width/2-size.width/2,_height/2-size.height/2 , size.width,size.height);
    _drawSize = size;
}

-(void)pan:(UIPanGestureRecognizer *)gesture{
    //由手指移动视图
    CGPoint point = [gesture locationInView:self];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _startPoint = point;
    }else if (gesture.state==UIGestureRecognizerStateChanged){
        //获取两个偏移量
        CGFloat offsetX = point.x-_startPoint.x;
        CGFloat offsetY = point.y-_startPoint.y;
        if (offsetX>0) {//往右移动
            if (_drawView.frame.origin.x+offsetX<0) {
                _drawView.frame=CGRectMake(_drawView.frame.origin.x+offsetX, _drawView.frame.origin.y, _drawView.frame.size.width, _drawView.frame.size.height);
            }else{
                _drawView.frame=CGRectMake(0, _drawView.frame.origin.y, _drawView.frame.size.width, _drawView.frame.size.height);
            }
        }
        if (offsetX<0) {//往左移动
            if (_drawView.frame.origin.x+_drawView.frame.size.width+offsetX>_width) {
                _drawView.frame=CGRectMake(_drawView.frame.origin.x+offsetX, _drawView.frame.origin.y, _drawView.frame.size.width, _drawView.frame.size.height);
            }else{
                 _drawView.frame=CGRectMake(_width-_drawView.frame.size.width, _drawView.frame.origin.y, _drawView.frame.size.width, _drawView.frame.size.height);
            }
        }
        if (offsetY>0) {//往下移动
            if (_drawView.frame.origin.y+offsetY<0) {
                 _drawView.frame=CGRectMake(_drawView.frame.origin.x, _drawView.frame.origin.y+offsetY, _drawView.frame.size.width, _drawView.frame.size.height);
            }else{
                 _drawView.frame=CGRectMake(_drawView.frame.origin.x,0, _drawView.frame.size.width, _drawView.frame.size.height);
            }
        }
        if (offsetY<0) {//网上移动
            if (_drawView.frame.origin.y+_drawView.frame.size.height+offsetY>_height) {
                 _drawView.frame=CGRectMake(_drawView.frame.origin.x, _drawView.frame.origin.y+offsetY, _drawView.frame.size.width, _drawView.frame.size.height);
            }else{
                _drawView.frame=CGRectMake(_drawView.frame.origin.x,_height-_drawView.frame.size.height, _drawView.frame.size.width, _drawView.frame.size.height);
            }
        }
        
    }
}

-(void)setDrawViewBackgroundColor:(UIColor *)color{
    _drawView.backgroundColor = color;
}
-(void)clearView{
    //换草稿纸
    
    [_drawView removeFromSuperview];
    _drawView = nil;
    _drawView = [[YHBaseSelfServiceDrawView alloc]init];
    [self addSubview:_drawView];
    _drawView.frame = CGRectMake(_width/2-_drawSize.width/2,_height/2-_drawSize.height/2 , _drawSize.width,_drawSize.height);
    if (_lineColor!=nil) {
        [_drawView setDrawLineColor:_lineColor];
    }
    if (_lineWidth!=0) {
        [_drawView setDrawLineWidth:_lineWidth];
    }
}
-(void)setDrawSettingOfWidth:(CGFloat)width andColor:(UIColor *)color{
    [_drawView setDrawLineWidth:width];
    _lineWidth = width;
    [_drawView setDrawLineColor:color];
    _lineColor =color;
}


@end
