/**
 *   TiGeoloqiLQTrackerProxy.m
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */

#import "TiGeoloqiLQTrackerProxy.h"
#import "TiUtils.h"
#import <GeoloqiSDK/Geoloqi.h>
#import "TiGeoloqiModule.h"

@implementation TiGeoloqiLQTrackerProxy


//==========================================================================================
//  Method Name: init
//  Return Type: id
//  Parameter  : N.A.

//  description: Its the initializer for the proxy class and will be called after memory allocation.
//
//  created by : Globallogic
//==========================================================================================
-(id)init
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
	
    trackerInstance = [LQTracker sharedTracker];
	return [super init];
}

//==========================================================================================
//  Method Name: canSwitchToProfile
//  Return Type: BOOL
//  Parameter  : id: args

//  description: Pre-check a profile to switch to instead of triggering an error state

//  created by : Globallogic
//==========================================================================================
-(BOOL)canSwitchToProfile:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    NSString *trackerProfile       =   [TiUtils stringValue:[args objectAtIndex:0]];
    
    //CONVERT THE PARAMETER VALUE TO UPPERCASE STRING TO MAKE COMPARISON CASE INSENSATIVE   
    NSString *trackerProfileUpperCase   =   [trackerProfile uppercaseString];
    
    NSError *err = trackerInstance.errorStatus;
    
    if ([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_OFF]) 
    {
        return [trackerInstance canSwitchToProfile:LQTrackerProfileOff error:&err];
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_PASSIVE])
    {
        return [trackerInstance canSwitchToProfile:LQTrackerProfilePassive error:&err];    
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_REALTIME])
    {
        return [trackerInstance canSwitchToProfile:LQTrackerProfileRealtime error:&err];
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_LOGGING])
    {
        return [trackerInstance canSwitchToProfile:LQTrackerProfileLogging error:&err];
    }
    
}

//==========================================================================================
//  Method Name: setProfile
//  Return Type: void
//  Parameter  : id:args, should be of type NSString

//  description: Used for setting a specific profile to the tracker.

//  created by : Globallogic
//==========================================================================================
-(void)setProfile:(id)args
{
        ENSURE_UI_THREAD_1_ARG(args);
    
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    NSString *trackerProfile       =   [TiUtils stringValue:args];
    
    //CONVERT THE PARAMETER VALUE TO UPPERCASE STRING TO MAKE COMPARISON CASE INSENSATIVE   
    NSString *trackerProfileUpperCase   =   [trackerProfile uppercaseString];
    
    
    if ([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_OFF]) 
    {
        trackerInstance.profile = LQTrackerProfileOff;
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_PASSIVE])
    {
        trackerInstance.profile = LQTrackerProfilePassive;
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_REALTIME])
    {
        trackerInstance.profile = LQTrackerProfileRealtime;
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_LOGGING])
    {
        trackerInstance.profile = LQTrackerProfileLogging;
    }
}

//==========================================================================================
//  Method Name: profile
//  Return Type: NSString
//  Parameter  : N.A.

//  description: // Get Property
                 // Used for getting the profile type set to tracker

//  created by : Globallogic
//==========================================================================================

-(NSString*)profile
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    if (trackerInstance.profile == LQTrackerProfileOff) 
    {
        return CONST_GEOLOQI_LQTRACKER_PROFILE_OFF;
    }
    else if(trackerInstance.profile == LQTrackerProfilePassive)
    {
        return CONST_GEOLOQI_LQTRACKER_PROFILE_PASSIVE;
    }
    else if(trackerInstance.profile == LQTrackerProfileRealtime)
    {
        return CONST_GEOLOQI_LQTRACKER_PROFILE_REALTIME;
    }
    else if(trackerInstance.profile == LQTrackerProfileLogging)
    {
        return CONST_GEOLOQI_LQTRACKER_PROFILE_LOGGING;
    }

}

//==========================================================================================
//  Method Name: getProfile
//  Return Type: NSString
//  Parameter  : N.A.

//  description: // Get Method
                 // Used for getting the profile type set to tracker

//  created by : Globallogic
//==========================================================================================
-(NSString*)getProfile:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    
    if (trackerInstance.profile == LQTrackerProfileOff) 
    {
        return CONST_GEOLOQI_LQTRACKER_PROFILE_OFF;
    }
    else if(trackerInstance.profile == LQTrackerProfilePassive)
    {
        return CONST_GEOLOQI_LQTRACKER_PROFILE_PASSIVE;
    }
    else if(trackerInstance.profile == LQTrackerProfileRealtime)
    {
        return CONST_GEOLOQI_LQTRACKER_PROFILE_REALTIME;
    }
    else if(trackerInstance.profile == LQTrackerProfileLogging)
    {
        return CONST_GEOLOQI_LQTRACKER_PROFILE_LOGGING;
    }
    
}

//==========================================================================================
//  Method Name: status
//  Return Type: NSString
//  Parameter  : N.A.

//  description: // Get Property
                 // Used for getting the status type set to tracker

//  created by : Globallogic
//==========================================================================================
-(NSString*)status
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
   
    if (trackerInstance.status == LQTrackerStatusLive) 
    {
        return CONST_GEOLOQI_LQTRACKER_STATUS_LIVE;
    }
    else if(trackerInstance.status == LQTrackerStatusNotTracking)
    {
        return CONST_GEOLOQI_LQTRACKER_STATUS_NOTTRACKING;
    }
    else if(trackerInstance.status == LQTrackerStatusQueueing)
    {
        return CONST_GEOLOQI_LQTRACKER_STATUS_QUEUEING;
    }
    
}

//==========================================================================================
//  Method Name: getStatus
//  Return Type: NSString
//  Parameter  : N.A.

//  description: // Get Method
                 // Used for getting the status type set to tracker

//  created by : Globallogic
//==========================================================================================
-(NSString*)getStatus:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    if (trackerInstance.status == LQTrackerStatusLive) 
    {
        return CONST_GEOLOQI_LQTRACKER_STATUS_LIVE;
    }
    else if(trackerInstance.status == LQTrackerStatusNotTracking)
    {
        return CONST_GEOLOQI_LQTRACKER_STATUS_NOTTRACKING;
    }
    else if(trackerInstance.status == LQTrackerStatusQueueing)
    {
        return CONST_GEOLOQI_LQTRACKER_STATUS_QUEUEING;
    }
    
}

//==========================================================================================
//  Method Name: dateOfLastLocationUpdate
//  Return Type: NSDate
//  Parameter  : N.A.

//  description: // Get Property
                 // Used for getting the date of Last Location Update.

//  created by : Globallogic
//==========================================================================================
-(NSDate*)dateOfLastLocationUpdate
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.dateOfLastLocationUpdate;
    
}


//==========================================================================================
//  Method Name: getDateOfLastLocationUpdate
//  Return Type: NSDate
//  Parameter  : N.A.

//  description: // Get Method
                 // Used for getting the date of Last Location Update.

//  created by : Globallogic
//==========================================================================================
-(NSDate*)getDateOfLastLocationUpdate:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.dateOfLastLocationUpdate;
    
}

//==========================================================================================
//  Method Name: dateOfLastSyncedLocationUpdate
//  Return Type: NSDate
//  Parameter  : N.A.

//  description: // Get Property
                 // Used for getting the date of Last Synced Location Update.

//  created by : Globallogic
//==========================================================================================
-(NSDate*)dateOfLastSyncedLocationUpdate
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.dateOfLastSyncedLocationUpdate;
    
}


//==========================================================================================
//  Method Name: getDateOfLastSyncedLocationUpdate
//  Return Type: NSDate
//  Parameter  : N.A.

//  description: // Get Method
                 // Used for getting the date of Last Synced Location Update.

//  created by : Globallogic
//==========================================================================================
-(NSDate*)getDateOfLastSyncedLocationUpdate:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.dateOfLastSyncedLocationUpdate;
}

@end
