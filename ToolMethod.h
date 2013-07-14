//
//  ToolMethod.h
//  TourAPP
//
//  Created by 尚德机构 on 13-6-15.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolMethod : NSObject
//字符型转日期型
+(NSDate*)StringToDate:(NSString*)string formatString:(NSString*)formatstring;
//日期型转字符型
+(NSString*)DateToString:(NSDate*)date formatString:(NSString*)formatstring;
//id转成整数
+(NSInteger)IDToInteger:(id)_number;
//将NSDictionary转换为指定的模型类
+(id)NSDictionaryToObject:(NSDictionary*)dictionary ObjectName:(NSString*)objectName;
+(id)NSDictionaryToObject:(NSDictionary*)dictionary Object:(NSObject*)object;
//将多层嵌套的NSDictionary层层剥皮得到需要的值
+(id)PeelOfftheSkin:(NSArray*)dictionaryKeys dictionary:(NSDictionary*)dictionary;
@end
