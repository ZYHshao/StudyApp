//
//  YHSAAnswerQuestionModel.h
//  
//
//  Created by user on 15/8/24.
//
//

#import "YHSARequestGetDataModel.h"

@interface YHSAAnswerQuestionModel : YHSARequestGetDataModel
//题干
__PROPERTY_NO_STRONG__(NSString *, content);
//题干图片
__PROPERTY_NO_STRONG__(NSString *, contentImg);
//副题干
__PROPERTY_NO_STRONG__(NSString *, secondcontent);
//选项ABCDE
__PROPERTY_NO_STRONG__(NSString *, option1);
__PROPERTY_NO_STRONG__(NSString *, option2);
__PROPERTY_NO_STRONG__(NSString *, option3);
__PROPERTY_NO_STRONG__(NSString *, option4);
__PROPERTY_NO_STRONG__(NSString *, option5);
//选项ABCDE对应的图片路径
__PROPERTY_NO_STRONG__(NSString *, optionImg1);
__PROPERTY_NO_STRONG__(NSString *, optionImg2);
__PROPERTY_NO_STRONG__(NSString *, optionImg3);
__PROPERTY_NO_STRONG__(NSString *, optionImg4);
__PROPERTY_NO_STRONG__(NSString *, optionImg5);
//正确答案
__PROPERTY_NO_STRONG__(NSString *, Answer);
//答案图片
__PROPERTY_NO_STRONG__(NSString *, AnswerImg);
//解析
__PROPERTY_NO_STRONG__(NSString *, discription);
//解析对应的图片
__PROPERTY_NO_STRONG__(NSString *, discriptionImg);
//音频文件
__PROPERTY_NO_STRONG__(NSString *, listionUrl);
//音频原文
__PROPERTY_NO_STRONG__(NSString *, listionTxt);
//题目类型
__PROPERTY_NO_STRONG__(NSString *, typename);
@end
