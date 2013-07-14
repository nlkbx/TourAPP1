//
//  ToolMethod.m
//  TourAPP
//
//  Created by 尚德机构 on 13-6-15.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "ToolMethod.h"

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
+(NSInteger)IDToInteger:(id)_number;{
    NSNumber *number=_number;
    return [number intValue]; 
}
+(id)NSDictionaryToObject:(NSDictionary*)dictionary ObjectName:(NSString*)objectName{
    
    Class tempClass =  NSClassFromString(objectName);
  
    return [ToolMethod NSDictionaryToObject:dictionary Object:[[tempClass alloc]init]];
}
+(id)NSDictionaryToObject:(NSDictionary*)dictionary Object:(NSObject*)object{
    NSArray *keys=[dictionary allKeys];
    for (NSString *key in keys) {
        
        [object setValue:[dictionary objectForKey:key] forKey:key];
    }
    return object;
}
+(NSArray*)PeelOfftheSkin:(NSArray*)dictionaryKeys dictionary:(NSDictionary*)dictionary
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
@end
