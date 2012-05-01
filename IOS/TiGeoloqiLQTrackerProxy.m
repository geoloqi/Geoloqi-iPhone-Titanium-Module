/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
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
//  Method Name: configureAnonymousUserAccountWithUserInfoAndProfile
//  Return Type: void
//  Parameter  : id: args

//  description:// This Method is used to configure Anonymous User account,
                //it accepts Array of two parameter from JAVA SCRIPT.
                // First: User Info in the JSON format
                // Second: Tracking Profile Type.

//  created by : Globallogic
//==========================================================================================
-(void)configureAnonymousUserAccountWithUserInfoAndProfile:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    NSString *trackerProfile       =   [TiUtils stringValue:[args objectAtIndex:1]];
    
    //CONVERT THE PARAMETER VALUE TO UPPERCASE STRING TO MAKE COMPARISON CASE INSENSATIVE   
    NSString *trackerProfileUpperCase   =   [trackerProfile uppercaseString];
    
    
    if ([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_OFF]) 
    {
        [LQTracker configureAnonymousUserAccountWithUserInfo:[args objectAtIndex:0] profile:LQTrackerProfileOff];
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_PASSIVE])
    {
        [LQTracker configureAnonymousUserAccountWithUserInfo:[args objectAtIndex:0] profile:LQTrackerProfilePassive];
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_REALTIME])
    {
        [LQTracker configureAnonymousUserAccountWithUserInfo:[args objectAtIndex:0] profile:LQTrackerProfileRealtime];
    }
    else if([trackerProfileUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_LOGGING])
    {
        [LQTracker configureAnonymousUserAccountWithUserInfo:[args objectAtIndex:0] profile:LQTrackerProfileLogging];
    }

    
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
//  Method Name: refreshNearbyTriggers
//  Return Type: void
//  Parameter  : id: args

//  description: Method used to refresh the Nearby Triggers

//  created by : Globallogic
//==========================================================================================
-(void)refreshNearbyTriggers:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    
    [trackerInstance refreshNearbyTriggers];
}


//==========================================================================================
//  Method Name: processTriggersForLocation
//  Return Type: void
//  Parameter  : id: args

//  description: // Method is used for processing Location and user can pass a JSON with the format given in documentation or can use titanium inbuil 
                 // location processing and pass the received location object in this method.

//  created by : Globallogic
//==========================================================================================
-(void)processTriggersForLocation:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    if (args)
    {
        @try {
            if ([[args objectAtIndex:0] isKindOfClass:[NSDictionary class]]) 
            {
                NSDictionary *locationDictionary = [[args objectAtIndex:0] valueForKey:@"coords"];
                CLLocationDegrees latitudeRef =  [[locationDictionary valueForKey:CONST_GEOLOQI_LQTRACKER_LOCATION_LATITUDE] doubleValue];
                CLLocationDegrees longitudeRef = [[locationDictionary valueForKey:CONST_GEOLOQI_LQTRACKER_LOCATION_LONGITUDE] doubleValue];
                
                if (((longitudeRef<=180)&& (longitudeRef>=-180))&&((latitudeRef<=90)&& (latitudeRef>=-90)))
                {
                    CLLocation *locationRef = [[[CLLocation alloc]initWithLatitude:latitudeRef longitude:longitudeRef] autorelease];
                    [trackerInstance processTriggersForLocation:locationRef];
                }
                else{
                    NSException *invalidArgumentException = [NSException exceptionWithName:@"invalidArgument" reason:@"The value for latitude or longitude is not correct" userInfo:nil];
                    @throw invalidArgumentException;
                }
                
            }
            else{
                NSException *invalidArgumentException = [NSException exceptionWithName:@"invalidArgument" reason:@"The Object passed is not a correct Location object" userInfo:nil];
                @throw invalidArgumentException;
            }
        }
        @catch(NSException *invalidArgumentException) {
            
            NSLog(@"[ERROR] %@",[invalidArgumentException reason]);
        }

    }
}


//==========================================================================================
//  Method Name: setSession
//  Return Type: void
//  Parameter  : id: args, should be of TiGeoloqiLQSessionProxy* Type

//  description: To set the tracker for a specific session

//  created by : Globallogic
//==========================================================================================
-(void)setSession:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    if (args && [args isKindOfClass:[TiGeoloqiLQSessionProxy class]]) {
        TiGeoloqiLQSessionProxy *proxy  =   (TiGeoloqiLQSessionProxy *)args;
        trackerInstance.session = proxy.objRequestHelper.objSession;
    }
}


//==========================================================================================
//  Method Name: session
//  Return Type: TiGeoloqiLQSessionProxy
//  Parameter  : N.A.

//  description: // Getter Property
                 // used for getting the session object which is set in the tracker.

//  created by : Globallogic
//==========================================================================================
-(TiGeoloqiLQSessionProxy *)session
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    TiGeoloqiLQSessionProxy *newProxy  =   [[[TiGeoloqiLQSessionProxy alloc] init] autorelease];
    
    [newProxy.objRequestHelper setObjSession:trackerInstance.session];
    
    return newProxy;
}

//==========================================================================================
//  Method Name: getSession
//  Return Type: TiGeoloqiLQSessionProxy
//  Parameter  : N.A.

//  description: // Getter Method
                 // used for getting the session object which is set in the tracker.

//  created by : Globallogic
//==========================================================================================
-(TiGeoloqiLQSessionProxy *)getSession:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    TiGeoloqiLQSessionProxy *newProxy  =   [[[TiGeoloqiLQSessionProxy alloc] init] autorelease];
    
    [newProxy.objRequestHelper setObjSession:trackerInstance.session];
    
    return newProxy;
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

//  description: // Getter Property
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

//  description: // Getter Method
                 // Used for getting the profile type set to tracker

//  created by : Globallogic
//==========================================================================================
-(NSString*)getProfile:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    
    NSLog(@"getProfile: %d",trackerInstance.profile);
    
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
//  Method Name: setStatus
//  Return Type: void
//  Parameter  : id: args, should be of NSString Type

//  description: Used for setting the status type to tracker

//  created by : Globallogic
//==========================================================================================
-(void)setStatus:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    NSString *trackerStatus       =   [TiUtils stringValue:args];
    
    //CONVERT THE PARAMETER VALUE TO UPPERCASE STRING TO MAKE COMPARISON CASE INSENSATIVE   
    NSString *trackerStatusUpperCase   =   [trackerStatus uppercaseString];
    
    
    if ([trackerStatusUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_STATUS_LIVE]) 
    {
        trackerInstance.status = LQTrackerStatusLive;
    }
    else if([trackerStatusUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_STATUS_NOTTRACKING])
    {
        trackerInstance.status = LQTrackerStatusNotTracking;
    }
    else if([trackerStatusUpperCase isEqualToString:CONST_GEOLOQI_LQTRACKER_STATUS_QUEUEING])
    {
        trackerInstance.status = LQTrackerStatusQueueing;
    }
}

//==========================================================================================
//  Method Name: status
//  Return Type: NSString
//  Parameter  : N.A.

//  description: // Getter Property
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

//  description: // Getter Method
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
//  Method Name: setErrorStatus
//  Return Type: void
//  Parameter  : id: args, shoould be of NSDictionary Type

//  description: Used for setting the Error Status to tracker

//  created by : Globallogic
//==========================================================================================
-(void)setErrorStatus:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    NSError *err = [NSError errorWithDomain:NSCocoaErrorDomain code:[TiUtils intValue:[args valueForKey:@"code"]] userInfo:[args valueForKey:@"userInfo"]];
    trackerInstance.errorStatus = err;
}

//==========================================================================================
//  Method Name: errorStatus
//  Return Type: NSDictionary
//  Parameter  : N.A.

//  description: // Getter Property
                 // Used for getting the error status type set to tracker

//  created by : Globallogic
//==========================================================================================
-(NSDictionary*)errorStatus
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[trackerInstance.errorStatus code]],@"code",[NSString stringWithFormat:@"%@",[trackerInstance.errorStatus userInfo]],@"userInfo",nil];
    return event;
    
}


//==========================================================================================
//  Method Name: getErrorStatus
//  Return Type: NSDictionary
//  Parameter  : N.A.

//  description: // Getter Method
                 // Used for getting the error status type set to tracker

//  created by : Globallogic
//==========================================================================================
-(NSDictionary*)getErrorStatus:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    NSDictionary *errorStatus = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[trackerInstance.errorStatus code]],@"code",[NSString stringWithFormat:@"%@",[trackerInstance.errorStatus userInfo]],@"userInfo",nil];
    return errorStatus;
    
}

//==========================================================================================
//  Method Name: dateOfLastLocationUpdate
//  Return Type: NSDate
//  Parameter  : N.A.

//  description: // Getter Property
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

//  description: // Getter Method
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

//  description: // Getter Property
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

//  description: // Getter Method
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

//==========================================================================================
//  Method Name: setRefreshTriggersDate
//  Return Type: void
//  Parameter  : id: args, Should be of NSDictionary type

//  description: Used to set the Refresh Triggers Date

//  created by : Globallogic
//==========================================================================================
-(void)setRefreshTriggersDate:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    ENSURE_SINGLE_ARG(args,NSDictionary);
	
	//NSLog(@"[METHODSDEMO] demoMethodDate received 1 argument of type NSDictionary");
	
	// Use the TiUtils methods to get the values from the arguments
	NSInteger month = [TiUtils intValue:@"month" properties:args def:1];
	NSInteger day = [TiUtils intValue:@"day" properties:args def:1];
	NSInteger year = [TiUtils intValue:@"year" properties:args def:2000];

// this commented code is used not required as if now.
    
//    NSInteger monthFromJSON = [TiUtils intValue:[args valueForKey:@"month"] def:1];
//	NSInteger dayFromJSON = [TiUtils intValue:[args valueForKey:@"day"] def:1];
//	NSInteger yearFromJSON = [TiUtils intValue:[args valueForKey:@"year"] def:2000];
	
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:month];
	[comps setDay:day];
	[comps setYear:year];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *result = [gregorian dateFromComponents:comps];
	[comps release];
	[gregorian release];
    trackerInstance.refreshTriggersDate = result;
}

//==========================================================================================
//  Method Name: refreshTriggersDate
//  Return Type: NSDate
//  Parameter  : // Getter Property
                 // Used to get the Refresh Triggers Date

//  description: Used to set the Refresh Triggers Date

//  created by : Globallogic
//==========================================================================================
-(NSDate*)refreshTriggersDate
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.refreshTriggersDate;
    
}

//==========================================================================================
//  Method Name: getRefreshTriggersDate
//  Return Type: NSDate
//  Parameter  : N.A.
//  description: // Getter Method
                 // Used to get the Refresh Triggers Date

//  created by : Globallogic
//==========================================================================================
-(NSDate*)getRefreshTriggersDate:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.refreshTriggersDate;
    
}

//==========================================================================================
//  Method Name: setRefreshTriggersRegion
//  Return Type: void
//  Parameter  : id: args, should be of type NSDictionary

//  description: Used to set the region for Refresh Triggers

//  created by : Globallogic
//==========================================================================================
-(void)setRefreshTriggersRegion:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    CLLocationDegrees latitudeRef =  [[args valueForKey:CONST_GEOLOQI_LQTRACKER_LOCATION_LATITUDE] doubleValue];
    CLLocationDegrees longitudeRef = [[args valueForKey:CONST_GEOLOQI_LQTRACKER_LOCATION_LONGITUDE] doubleValue];
    CLLocationDistance locRadius =  [[args valueForKey:CONST_GEOLOQI_LQTRACKER_LOCATION_RADIUS] doubleValue];
    NSString *identifier = [TiUtils stringValue:[args valueForKey:CONST_GEOLOQI_LQTRACKER_LOCATION_IDENTIFIER]];

    CLLocationCoordinate2D cordinates;
    cordinates.latitude = latitudeRef;
    cordinates.longitude = longitudeRef;
    
    CLRegion *region = [[CLRegion alloc]initCircularRegionWithCenter:cordinates radius:locRadius identifier:identifier];
    trackerInstance.refreshTriggersRegion = region;
}

//==========================================================================================
//  Method Name: refreshTriggersRegion
//  Return Type: NSDictionary
//  Parameter  : N.A.

//  description: // Getter Property
                 // Used to get the region of Refresh Trigger

//  created by : Globallogic
//==========================================================================================
-(NSDictionary*)refreshTriggersRegion
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    CLLocationDegrees latitudeRef = [trackerInstance.refreshTriggersRegion center].latitude;
    CLLocationDegrees longitudeRef = [trackerInstance.refreshTriggersRegion center].longitude;
    
    NSDictionary *regionDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%@",latitudeRef],CONST_GEOLOQI_LQTRACKER_LOCATION_LATITUDE,
                                 [NSString stringWithFormat:@"%@",longitudeRef],CONST_GEOLOQI_LQTRACKER_LOCATION_LONGITUDE,
                                 [NSString stringWithFormat:@"%@",[trackerInstance.refreshTriggersRegion radius ]],CONST_GEOLOQI_LQTRACKER_LOCATION_RADIUS,
                                 [NSString stringWithFormat:@"%@",[trackerInstance.refreshTriggersRegion identifier ]],CONST_GEOLOQI_LQTRACKER_LOCATION_IDENTIFIER,nil];
    return regionDict;
    
}

//==========================================================================================
//  Method Name: getRefreshTriggersRegion
//  Return Type: NSDictionary
//  Parameter  : N.A.

//  description: // Getter Method
                 // Used to get the region of Refresh Trigger

//  created by : Globallogic
//==========================================================================================
-(NSDictionary*)getRefreshTriggersRegion:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    CLLocationDegrees latitudeRef = [trackerInstance.refreshTriggersRegion center].latitude;
    CLLocationDegrees longitudeRef = [trackerInstance.refreshTriggersRegion center].longitude;
    
    NSDictionary *regionDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",latitudeRef],CONST_GEOLOQI_LQTRACKER_LOCATION_LATITUDE,
                                [NSString stringWithFormat:@"%@",longitudeRef],CONST_GEOLOQI_LQTRACKER_LOCATION_LONGITUDE,
                                [NSString stringWithFormat:@"%@",[trackerInstance.refreshTriggersRegion radius ]],CONST_GEOLOQI_LQTRACKER_LOCATION_RADIUS,
                                [NSString stringWithFormat:@"%@",[trackerInstance.refreshTriggersRegion identifier ]],CONST_GEOLOQI_LQTRACKER_LOCATION_IDENTIFIER,nil];
    return regionDict;
    
}

@end
