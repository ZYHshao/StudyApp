//
//  YHBaseCecheCenter.m
//  StudyApp
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseCecheCenter.h"

@implementation YHBaseCecheCenter
+(instancetype)sharedTheSingletion{
    static YHBaseCecheCenter * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[YHBaseCecheCenter alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //缓存地址的拼接
        [self creatCachePath];
    }
    return self;
}
-(void)creatCachePath{
    _mainCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_MAIN];
    _imageCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_IMAGE];
    _fileCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_FILE];
    _audioCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_AUDIO];
    _videoCechePath = [NSHomeDirectory() stringByAppendingString:YH_BASE_CECHE_PATH_VEDIO];
}


-(void)writeCecheFile:(NSData *)data
           withFileID:(NSString *)fileID
               toPath:(YHBaseCechePath)path{
    NSString * cechePath = [self getCechePath:path];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //判断目录是否存在
    if (![fileManager fileExistsAtPath:cechePath]) {
        //创建目录
        [fileManager createDirectoryAtPath:cechePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //拼接文件路径
    NSString * writePath = [cechePath stringByAppendingFormat:@"/%@",fileID];
    [data writeToFile:writePath atomically:YES];
//    NSLog(@"写缓存");
}

-(NSData *)readCecheFile:(NSString *)fileID fromPath:(YHBaseCechePath)path{
    NSString * cechePath = [self getCechePath:path];
    NSString * readPath = [cechePath stringByAppendingFormat:@"/%@",fileID];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //判断文件是否
    if (![fileManager fileExistsAtPath:readPath]) {
       
        return nil;
    }else{
        NSData *data = [NSData dataWithContentsOfFile:readPath];
        return data;
    }
   

}

-(NSString *)getCechePath:(YHBaseCechePath)path{
    switch (path) {
            //从1开始
        case 1:
        {
            return _mainCechePath;
        }
            break;
        case 2:
        {
            return _imageCechePath;
        }
            break;
        case 3:
        {
            return _fileCechePath;
        }
            break;
        case 4:
        {
            return _videoCechePath;
        }
            break;
        case 5:
        {
            return _audioCechePath;
        }
            break;
        default:
            return _mainCechePath;
            break;
    }

}

@end
