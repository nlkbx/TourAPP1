//
//  User.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-19.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * uemail;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSString * uname;
@property (nonatomic, retain) NSString * upassword;

@end
