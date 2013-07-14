//
//  TourAppDelegate.h
//  TourAPP
//
//  Created by 尚德机构 on 13-6-15.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManage.h"
#import "Reachability.h"
#import "MyHttpRequest.h"
@interface TourAppDelegate : UIResponder <UIApplicationDelegate,UIApplicationDelegate>

{
    DataManage *dm;
    NSMutableData *_data;
    
    
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
