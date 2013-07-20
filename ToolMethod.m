//
//  ToolMethod.m
//  TourAPP
//
//  Created by 尚德机构 on 13-6-15.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "ToolMethod.h"
#import <objc/runtime.h>
@implementation ToolMethod
+(NSDate*)StringToDate:(NSString*)string formatString:(NSString*)formatstring{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatstring];
    NSDate *destDate= [dateFormatter dateFromString:string];
   return destDate;
}
+(NSString*)DateToString:(NSDate*)date formatString:(NSString*)formatstring{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatstring];
    return [dateFormatter stringFromDate:date];
}
+ (NSInteger)IDToInteger:(id)_number;{
    NSNumber *number=_number;
    return [number intValue]; 
}
//通过类名得到类
+(id)GetObjectForObjectName:(NSString*)objectName{
    return [[ NSClassFromString(objectName) alloc]init];
}
//将NSDictionary转换成指定的类
+(id)NSDictionaryToObject:(NSDictionary*)dictionary ObjectName:(NSString*)objectName{
    return [ToolMethod NSDictionaryToObject:dictionary Object:[ToolMethod GetObjectForObjectName:objectName]];
}
+(id)NSDictionaryToObject:(NSDictionary*)dictionary Object:(NSObject*)object{
    NSArray *keys=[dictionary allKeys];
    for (NSString *key in keys) {
        id value=[dictionary objectForKey:key];
        if([value isKindOfClass:[NSArray class]]){
            NSArray *arr=value;
            NSMutableArray *array=[[NSMutableArray alloc]init];
              if([ToolMethod CheckPropForObject:key forObject:[object class]]){
                [object setValue:array forKey:key];
                for (NSDictionary *dic in arr) {
                    id va=[ToolMethod NSDictionaryToObject:dic ObjectName:key];
                    [array addObject:va];
//                    for (NSString * key in [dic allKeys]) {
//                        NSLog(@"%@",[va valueForKey:key]);
//                    }
 
                }
            }
        }else if([value isKindOfClass:[NSDictionary class]]){
             if([ToolMethod CheckPropForObject:key forObject:[object class]])
               [object setValue:[ToolMethod NSDictionaryToObject:value ObjectName:key] forKey:key];
        }else{
            if([ToolMethod CheckPropForObject:key forObject:[object class]])
            [object setValue:value forKey:key];
        }
    }
    return object;
}

//检查指定的类里面是否有指定的属性
+(BOOL)CheckPropForObject:(NSString*)propName forObject:(Class) class{
    unsigned int nCount = 0;
   objc_objectptr_t *popertylist = class_copyPropertyList(class,&nCount);
    for (int i = 0; i < nCount; i++) {
        objc_objectptr_t property = popertylist[i];
        if([propName compare:[NSString stringWithUTF8String:property_getName(property)]]==NSOrderedSame)
            return YES;
    }
    return NO;
}
//去除NSDictonary不需要的外壳
+(id)PeelOfftheSkin:(NSArray*)dictionaryKeys dictionary:(NSDictionary*)dictionary
{
    NSDictionary *temp=dictionary;
    for (int i=0;i<dictionaryKeys.count;i++) {
        if(i<dictionaryKeys.count-1){
            if(!(temp=[temp objectForKey:dictionaryKeys[i]]))
                return nil;
        }else{
            return [temp objectForKey:dictionaryKeys[i]];
        }
    }
}
//截取字符串
+(NSString*)SubString:(NSString*) string withHelps:(NSArray*) subStringHelpers{
    @try {
    
        for (SubStringHelper* help in subStringHelpers) {
            NSRange range=[string rangeOfString:help.substring];
            if(help.before)
            {
                if(help.keepsubstring){
                    string=[string substringToIndex:range.location+range.length];
                }else{
                     string=[string substringToIndex:range.location];
                }
            }else{
                if(help.keepsubstring){
                    string= [string substringFromIndex:range.location];
                }else{
                     string=[string substringFromIndex:range.location+range.length];
                }
            }
        }
        return string;

    }
    @catch (NSException *exception) {
        return @"";
    }
    @finally {
        
    }
}

//从Array取出数字
+(NSInteger)getIntegerFromArray:(NSArray*)array index:(NSUInteger)index{
    if(array.count<=index)
        return 0;
    NSNumber *number=[array objectAtIndex:index];
    return [number integerValue];
}
@end
@implementation SubStringHelper
@synthesize substring,before,keepsubstring;
-(id)initWithSubString:(NSString*) _substring before:(BOOL)_before keepsubstring:(BOOL)_keepsubstring{
    if(self=[super init]){
        self.substring=_substring;
        self.before=_before;
        self.keepsubstring=_keepsubstring;
    }
    
    return self;
}
@end