//
//  ProjectPublicMethod.m
//  TourAPP
//
//  Created by 徐彪 on 13-6-30.
//  Copyright (c) 2013年 Tour. All rights reserved.
//

#import "ProjectPublicMethod.h"

@implementation ProjectPublicMethod
+(void)checkNetworkStatus:(NSString*)host target:(id)target success:(SEL)successSel fail:(SEL)failSel{
    Reachability* reachability=[Reachability reachabilityWithHostname:host];
    reachability.reachableBlock=^(Reachability* reachability){
    
        if(successSel!=nil&&[target respondsToSelector:successSel])
        [target performSelector:successSel];
    };
    reachability.unreachableBlock=^(Reachability* reachbility){
     
        if(failSel!=nil&&[target respondsToSelector:failSel])
        [target performSelector:failSel];
      
    };
    [reachability startNotifier];

}
+(Label_IconView*)getDropDownViewMainView:(NSString*)text frame:(CGRect)frame{
    Label_IconView *mainview=[[Label_IconView alloc]initWithFrame:frame];
    mainview.margin=10;
    mainview.backgroudImage=[UIImage imageNamed:@"lightblack"];
    mainview.text=text;
    mainview.textcolor=[UIColor grayColor];
    mainview.iconImage=[UIImage imageNamed:@"down"];
    return mainview;
}

@end
