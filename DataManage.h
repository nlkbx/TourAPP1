//
//  DataManage.h
//  studentManage
//
//  Created by 徐彪 on 13-5-14.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DataManageDelegate <NSObject>
@required
-(void)configurationManagedObject:(NSManagedObject*) object inManagedObjectContext:(NSManagedObjectContext *)context forTag:(NSInteger)tag userInfo:(id)userInfo;
-(void)configurationQueryParameters:(NSFetchRequest*) fetchRequest forTag:(NSInteger)tag userInfo:(id)userInfo;
@end
@interface DataManage : NSObject
{
    NSManagedObjectContext *context;
}
@property(nonatomic,assign)id<DataManageDelegate> delegate;
-(void)save;
-(void)delete:(NSManagedObject*)object;
-(NSManagedObject*)createEntityForName:(NSString*) entityName;
-(void)addEntityForName:(NSString*) entityName forTag:(NSInteger)tag userInfo:(id)userInfo;
-(NSArray*) Query:(NSString*) entityName forTag:(NSInteger)tag userInfo:(id)userInfo;
- (void)undo;
- (void)lock;
- (void)rollback;

@end
