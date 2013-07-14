//
//  DataManage.m
//  studentManage
//
//  Created by 徐彪 on 13-5-14.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "DataManage.h"
#import "TourAppDelegate.h"
@implementation DataManage
@synthesize delegate;
- (id)init{
    if(self=[super init]){
        TourAppDelegate *delegate=[UIApplication sharedApplication].delegate;
        context=delegate.managedObjectContext;
        return self;
    }
    return nil;
}
-(NSManagedObject*)createEntityForName:(NSString*) entityName{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
}
-(void)addEntityForName:(NSString*) entityName forTag:(NSInteger)tag userInfo:(id) userInfo
{
    NSManagedObject *object=[NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    if (![delegate respondsToSelector:@selector(configurationManagedObject:inManagedObjectContext:forTag:userInfo:)]) {
        NSLog(@"没有设置代理");
        return;
    }
    
    [delegate configurationManagedObject:object inManagedObjectContext:context forTag:tag userInfo:userInfo];
    
    [self save];
}
-(void)save{
    NSError *error;
    if(![context save:&error]){
        
        NSLog(@"错误：%@",error);
        [context rollback];
    }
}
-(void)delete:(NSManagedObject*)object{
    [context deleteObject:object];
}
-(NSArray*) Query:(NSString*) entityName forTag:(NSInteger)tag userInfo:(id)userInfo{
    NSEntityDescription    * entity   = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity: entity];
    if (![delegate respondsToSelector:@selector(configurationQueryParameters:forTag:userInfo:)]) {
        NSLog(@"没有设置代理，无法设置查询条件和排序方式");
    }else{
        [delegate configurationQueryParameters:fetch forTag:tag userInfo:userInfo];
    }
    NSError *error;
    NSArray * results = [context executeFetchRequest:fetch error:&error];
    
    if(error!=nil)
        NSLog(@"错误：%@",error);
    return results;
}
- (void)undo{
    [context undo];
}
- (void)lock{
    [context lock];
}
- (void)rollback{
    
    [context rollback];
}
@end
