//
//  TourAppDelegate.m
//  TourAPP
//
//  Created by 尚德机构 on 13-6-15.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "TourAppDelegate.h"
#import "SystemUpdate.h"
#import "ToolMethod.h"
#import "Pro_Country.h"
#import "ScenicType.h"
#import "Equipment.h"
#import "FoodType.h"
#import "ProjectPublicMethod.h"
#import "TabBarViewController.h"
#import "TopSDKBundle.h"
@implementation TourAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    dm=[[DataManage alloc]init];
    dm.delegate=self;
    [self startApp];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController=[[TabBarViewController alloc]init];
    [self.window makeKeyAndVisible];
      TopIOSClient *iosclient=[TopIOSClient registerIOSClient:APPKEY appSecret:APPSECRET callbackUrl:CALLBACKURL needAutoRefreshToken:YES];
    [TopAppConnector registerAppConnector:APPKEY topclient:iosclient];
    return YES;
}

-(void)startApp{
    
   [ProjectPublicMethod checkNetworkStatus:HOST target:self success:@selector(connectHost) fail:nil];
        
}
-(void)connectHost{
    [self queryTableUpdate];
}

//检查系统表的更新情况
-(void)queryTableUpdate{
    
    _data=[[NSMutableData alloc]init];
     NSMutableString *jsonstring=[[NSMutableString alloc]init];
    MyHttpRequest *request=[[MyHttpRequest alloc]initWithDelegate:self tag:100 userInfo:jsonstring];
    [request sendRequestToURL:[NSString stringWithFormat:@"%@%@",SERVERURL,GETTABLEUPDATEDATE]];
    // NSString
}
//根据请求返回的JSON得到系统表的更新情况
-(void)checkTableUpdate:(NSString*) jsonString{
    NSError *error;
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];//解析JSON
    if(error!=nil){
        NSLog(@"%@",error);
    }else{
        
        for (NSDictionary *dict in arr) {
            NSString *tablename=[dict objectForKey:TABLENAME];
            NSString *updateDate=[dict objectForKey:UPDATEDATE];
            NSDate *date=[ToolMethod StringToDate:updateDate formatString:DATEFORMAT];
            BOOL isupdate=YES;
            BOOL isfind=NO;
            NSDate *lastupdate;
            NSArray *systemupdates=[dm Query:SYSTEMUPDATE forTag:100 userInfo:tablename];
            SystemUpdate *su;
            [dm lock];
            if (systemupdates.count==0) {
                su=[dm createEntityForName:SYSTEMUPDATE];
                su.tableName=tablename;
                su.update=date;
                lastupdate=[NSDate dateWithTimeIntervalSince1970:0];
            }else
            {
                su=systemupdates[0];
                lastupdate=su.update;
                isfind=YES;
                if([su.update compare:date]==NSOrderedSame)
                    isupdate=NO;
                else{
                    su.update=date;
                }
                
            }
                            
            if(isupdate==YES||isfind==NO){
                    [self queryPro_CountryTable:lastupdate tablename:tablename];
            }
            

        }
    }

}

-(void)queryPro_CountryTable:(NSDate*)updatedate tablename:(NSString*)tablename
{
    NSString* datestring=[ToolMethod DateToString:updatedate formatString:DATEFORMAT];
    NSMutableString *jsonstring=[[NSMutableString alloc]init];
    NSInteger tag=0;
    
    if([tablename compare:PRO_COUNTRY]==NSOrderedSame){
        tag=102;
    }else if([tablename compare:SCENICTYPE]==NSOrderedSame){
        tag=103;
    }else if([tablename compare:EQUIPMENT]==NSOrderedSame){
        tag=104;
    }else if([tablename compare:FOODTYPE]==NSOrderedSame){
        tag=105;
    }
    if(tag!=0){
     MyHttpRequest *request=[[MyHttpRequest alloc]initWithDelegate:self tag:tag userInfo:jsonstring];
        [request sendRequestToURL:[NSString stringWithFormat:@"%@%@",SERVERURL,GETSYSTEMTABLEUPDATEDATA] params:[NSString stringWithFormat:@"%@=%@&%@=%@",TABLENAME,tablename,GETSYSTEMTABLEUPDATEDATAPARAM,datestring]];
    }
    
}
-(void)checkPro_countryTableUpdate:(NSString*)jsonstring{
    NSError *error;
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];//解析JSON
    if(error!=nil){
        NSLog(@"%@",error);
        [dm rollback];
    }else{
        for (NSDictionary *dict in arr) {
                      
            NSInteger pid=[ToolMethod IDToInteger:[dict objectForKey:PRO_COUNTRY_PID]];
            NSString *pname=[dict objectForKey:PRO_COUNTRY_PNAME];
                        NSInteger ischina=[ToolMethod IDToInteger:[dict objectForKey:PRO_COUNTRY_ISCHINA]];
            NSDate *createdate=[ToolMethod StringToDate:[dict objectForKey:PRO_COUNTRY_CREATEDATE] formatString:DATEFORMAT];
            NSDate *updatedate=[ToolMethod StringToDate:[dict objectForKey:PRO_COUNTRY_UPDATEDATE] formatString:DATEFORMAT];
            NSArray *pro_countries=[dm Query:PRO_COUNTRY forTag:103 userInfo:[NSNumber numberWithInteger:pid]];
            Pro_Country *pro_country;
            if([pro_countries count]==0){
                pro_country=[dm createEntityForName:PRO_COUNTRY];
            }else{
                pro_country=pro_countries[0];
            }
            pro_country.pid=[NSNumber numberWithInteger:pid];
            pro_country.pname=pname;
            pro_country.ischina=[NSNumber numberWithInteger:ischina];
            pro_country.createdate=createdate;
            pro_country.updatedate=updatedate;
                        
        }
        [dm save];
    }
}
-(void)checkScenicTypeTableUpdate:(NSString*)jsonstring{
    NSError *error;
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];//解析JSON
    if(error!=nil){
        NSLog(@"%@",error);
        [dm rollback];
    }else{
        for (NSDictionary *dict in arr) {
            
            NSInteger sid=[ToolMethod IDToInteger:[dict objectForKey:SCENICTYPE_SID]];
            NSString *sname=[dict objectForKey:SCENICTYPE_STYPE];
              NSDate *createdate=[ToolMethod StringToDate:[dict objectForKey:SCENICTYPE_CREATEDATE] formatString:DATEFORMAT];
            NSDate *updatedate=[ToolMethod StringToDate:[dict objectForKey:SCENICTYPE_UPDATEDATE] formatString:DATEFORMAT];
            NSArray *scenictypes=[dm Query:SCENICTYPE forTag:104 userInfo:[NSNumber numberWithInteger:sid]];
            ScenicType *scenictype;
            if([scenictypes count]==0){
                scenictype=[dm createEntityForName:SCENICTYPE];
            }else{
                scenictype=scenictypes[0];
            }
            scenictype.sid=[NSNumber numberWithInteger:sid];
            scenictype.stype=sname;
            
            scenictype.createdate=createdate;
            scenictype.updatedate=updatedate;
            
        }
        [dm save];
    }
}
-(void)checkEquiomentTableUpdate:(NSString*)jsonstring{
    NSError *error;
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];//解析JSON
    if(error!=nil){
        NSLog(@"%@",error);
        [dm rollback];
    }else{
        for (NSDictionary *dict in arr) {
            
            NSInteger eid=[ToolMethod IDToInteger:[dict objectForKey:EQUIPMENT_EID]];
            NSString *ename=[dict objectForKey:EQUIPMENT_ENAME];
            NSInteger fathereid= [ToolMethod IDToInteger:[dict objectForKey:EQUIPMENT_FATHEREID]];
            NSArray *fathers=[dm Query:EQUIPMENT forTag:105 userInfo:[NSNumber numberWithInteger:fathereid]];
            Equipment *father=fathers.count==0?nil:fathers[0];
            NSDate *createdate=[ToolMethod StringToDate:[dict objectForKey:EQUIPMENT_CREATEDATE] formatString:DATEFORMAT];
            NSDate *updatedate=[ToolMethod StringToDate:[dict objectForKey:EQUIPMENT_UPDATEDATE] formatString:DATEFORMAT];
            NSString *cid=[dict objectForKey:EQUIPMENT_CID];
            NSArray *equioments=[dm Query:EQUIPMENT forTag:105 userInfo:[NSNumber numberWithInteger:eid]];
            Equipment *equipment;
            if([equioments count]==0){
                equipment=[dm createEntityForName:EQUIPMENT];
            }else{
                equipment=equioments[0];
            }
            equipment.eid=[NSNumber numberWithInteger:eid];
            equipment.ename=ename;
            equipment.eqiupments_equipment=father;
            equipment.createdate=createdate;
            equipment.updatedate=updatedate;
            equipment.cid=cid;
            
        }
        [dm save];
    }
}
-(void)checkFoodTypeTableUpdate:(NSString*)jsonstring{
    NSError *error;
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];//解析JSON
    if(error!=nil){
        NSLog(@"%@",error);
        [dm rollback];
    }else{
        for (NSDictionary *dict in arr) {
            
            NSInteger fid=[ToolMethod IDToInteger:[dict objectForKey:FOODTYPE_FID]];
            NSString *fname=[dict objectForKey:FOODTYPE_FNAME];
            
            NSDate *createdate=[ToolMethod StringToDate:[dict objectForKey:FOODTYPE_CREATEDATE] formatString:DATEFORMAT];
            NSDate *updatedate=[ToolMethod StringToDate:[dict objectForKey:FOODTYPE_UPDATEDATE] formatString:DATEFORMAT];
            NSArray *foodtypies=[dm Query:FOODTYPE forTag:106 userInfo:[NSNumber numberWithInteger:fid]];
            FoodType *foodtype;
            if([foodtypies count]==0){
                foodtype=[dm createEntityForName:FOODTYPE];
            }else{
                foodtype=foodtypies[0];
            }
            foodtype.fid=[NSNumber numberWithInteger:fid];
            foodtype.fname=fname;
           
            foodtype.createdate=createdate;
            foodtype.updatedate=updatedate;
            
        }
        [dm save];
    }
}

//得到请求返回的JSON
-(void)foundCharacters:(NSString *)string tag:(NSInteger)tag userInfo:(id)userinfo{
    NSMutableString *jsonstring=userinfo;
    [jsonstring appendString:string];
}
- (void)didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName tag:(NSInteger)tag userInfo:(id)userinfo{
    if(tag==100){
        [self checkTableUpdate:userinfo];
    }  else if(tag==102)
    {
        [self checkPro_countryTableUpdate:userinfo];
    }else if(tag==103){
        [self checkScenicTypeTableUpdate:userinfo];
    }else if(tag==104){
        [self checkEquiomentTableUpdate:userinfo];
    }else if(tag==105){
        [self checkFoodTypeTableUpdate:userinfo];
    }
}
-(void)configurationManagedObject:(NSManagedObject*) object inManagedObjectContext:(NSManagedObjectContext *)context forTag:(NSInteger)tag userInfo:(id)userInfo{
   
}
-(void)configurationQueryParameters:(NSFetchRequest *)fetchRequest forTag:(NSInteger)tag userInfo:(id)userInfo{
    if(tag==100){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"tableName=%@",userInfo];
        [fetchRequest setPredicate:pre];
        [fetchRequest setFetchLimit:1];
    }else if(tag==103){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"pid=%@",userInfo];
        [fetchRequest setPredicate:pre];
        [fetchRequest setFetchLimit:1];
    }else if(tag==104){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"sid=%@",userInfo];
        [fetchRequest setPredicate:pre];
        [fetchRequest setFetchLimit:1];
    }else if(tag==105){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"eid=%@",userInfo];
        [fetchRequest setPredicate:pre];
        [fetchRequest setFetchLimit:1];
    }else if(tag==106){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"fid=%@",userInfo];
        [fetchRequest setPredicate:pre];
        [fetchRequest setFetchLimit:1];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TourAPP" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TourAPP.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
