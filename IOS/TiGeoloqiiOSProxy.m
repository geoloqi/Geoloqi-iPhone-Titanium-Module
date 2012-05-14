/**
 *  TiGeoloqiiOSProxy.m
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */

#import "TiGeoloqiiOSProxy.h"
#import "TiUtils.h"
#import "TiGeoloqiModule.h"

@implementation TiGeoloqiiOSProxy


//==========================================================================================
//  Method Name: registerDeviceToken
//  Return Type: void
//  Parameter  : id:deviceTokenArray

//  description: used for registering with geoloqi push notification.

//  created by : Globallogic
//==========================================================================================

-(void)registerDeviceToken:(id)deviceTokenArray
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    
    //[LQSession registerDeviceToken:[[TiUtils stringValue:[deviceTokenArray objectAtIndex:0]] dataUsingEncoding:NSUnicodeStringEncoding]];
    [LQSession registerDeviceToken:[deviceTokenArray objectAtIndex:0]];
}


//==========================================================================================
//  Method Name: handlePush
//  Return Type: void
//  Parameter  : id:userInfoArray

//  description: used to handle user info, and pass that to geoloqi server.

//  created by : Globallogic
//==========================================================================================

-(void)handlePush:(id)userInfoArray
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    
    [LQSession handlePush:[userInfoArray objectAtIndex:0]];
}
@end
