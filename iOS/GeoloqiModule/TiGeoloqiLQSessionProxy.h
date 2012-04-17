/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import "RequestHelper.h"

@interface TiGeoloqiLQSessionProxy : TiProxy <RequestHelperDelegate> 
{
    BOOL isServiceStartedSuccessFully;
    NSString *strAuthenicatedUserName;
    
}

@property (nonatomic,retain)     RequestHelper *objRequestHelper;
@property (nonatomic,retain)     NSString *strAuthenicatedUserName;

-(LQSession *) savedLQSession;

@end
