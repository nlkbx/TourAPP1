//
//  ProjectPublicMethod.h
//  TourAPP
//
//  Created by 徐彪 on 13-6-30.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Label_IconView.h"
#import "DropDownView.h"
@interface ProjectPublicMethod : NSObject
+(void)checkNetworkStatus:(NSString*)host target:(id)target success:(SEL)successSel fail:(SEL)failSel;
+(Label_IconView*)getDropDownViewMainView:(NSString*)text frame:(CGRect)frame;
@end
