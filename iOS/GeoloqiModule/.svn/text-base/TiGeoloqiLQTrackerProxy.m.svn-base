/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGeoloqiLQTrackerProxy.h"
#import "TiUtils.h"
#import <GeoloqiSDK/Geoloqi.h>
#import "TiGeoloqiLQSessionProxy.h"
#import "TiGeoloqiModule.h"

@implementation TiGeoloqiLQTrackerProxy

-(id)init
{
    
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

	// This is the designated initializer method and will always be called
	// when the proxy is created.
	
	trackerInstance = [LQTracker sharedTracker];		
	return [super init];
}


-(void)configureAnonymousUserAccountWithUserInfoAndProfile:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    NSString *trackerProfile       =   [TiUtils stringValue:[args objectAtIndex:1]];
    
    //CONVERT THE PARAMETER VALUE TO UPPERCASE STRING TO MAKE COMPARISON CASE INSENSATIVE   
    NSString *trackerProfileUpperCase   =   [trackerProfile uppercaseString];
    
    
    if ([trackerProfileUpperCase isEqualToString:@"OFF"]) 
    {
        [LQTracker configureAnonymousUserAccountWithUserInfo:[args objectAtIndex:0] profile:LQTrackerProfileOff];
    }
    else if([trackerProfileUpperCase isEqualToString:@"PASSIVE"])
    {
        [LQTracker configureAnonymousUserAccountWithUserInfo:[args objectAtIndex:0] profile:LQTrackerProfilePassive];
    }
    else if([trackerProfileUpperCase isEqualToString:@"REALTIME"])
    {
        [LQTracker configureAnonymousUserAccountWithUserInfo:[args objectAtIndex:0] profile:LQTrackerProfileRealtime];
    }
    else if([trackerProfileUpperCase isEqualToString:@"LOGGING"])
    {
        [LQTracker configureAnonymousUserAccountWithUserInfo:[args objectAtIndex:0] profile:LQTrackerProfileLogging];
    }

    
}

// Needs to be checked for Error Object What to do with that
-(BOOL)canSwitchToProfile:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    NSString *trackerProfile       =   [TiUtils stringValue:[args objectAtIndex:1]];
    
    //CONVERT THE PARAMETER VALUE TO UPPERCASE STRING TO MAKE COMPARISON CASE INSENSATIVE   
    NSString *trackerProfileUpperCase   =   [trackerProfile uppercaseString];
    
    NSError **err = nil;
    
    if ([trackerProfileUpperCase isEqualToString:@"OFF"]) 
    {
        [trackerInstance canSwitchToProfile:LQTrackerProfileOff error:err];
    }
    else if([trackerProfileUpperCase isEqualToString:@"PASSIVE"])
    {
        [trackerInstance canSwitchToProfile:LQTrackerProfilePassive error:err];    
    }
    else if([trackerProfileUpperCase isEqualToString:@"REALTIME"])
    {
        [trackerInstance canSwitchToProfile:LQTrackerProfileRealtime error:err];
    }
    else if([trackerProfileUpperCase isEqualToString:@"LOGGING"])
    {
        [trackerInstance canSwitchToProfile:LQTrackerProfileLogging error:err];
    }
    
}

-(void)refreshNearbyTriggers:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    
    [trackerInstance refreshNearbyTriggers];
}

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
                CLLocationDegrees latitudeRef =  [[locationDictionary valueForKey:@"latitude"] doubleValue];
                CLLocationDegrees longitudeRef = [[locationDictionary valueForKey:@"longitude"] doubleValue];
                
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

-(void)setSession:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    if (args && [args isKindOfClass:[TiGeoloqiLQSessionProxy class]]) {
        trackerInstance.session = [LQSession savedSession];
    }
}

// Getter Property
-(TiGeoloqiLQSessionProxy *)session
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    // i think it should not be like this, and we have to manage relationship between LQSession proxy creation and Native session.
    return [[[TiGeoloqiLQSessionProxy alloc] init] autorelease];
}

// Getter Method
-(TiGeoloqiLQSessionProxy *)getSession:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    // i think it should not be like this, and we have to manage relationship between LQSession proxy creation and Native session.
    return [[[TiGeoloqiLQSessionProxy alloc] init] autorelease];
}

-(void)setProfile:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    NSString *trackerProfile       =   [TiUtils stringValue:args];
    
    //CONVERT THE PARAMETER VALUE TO UPPERCASE STRING TO MAKE COMPARISON CASE INSENSATIVE   
    NSString *trackerProfileUpperCase   =   [trackerProfile uppercaseString];
    
    
    if ([trackerProfileUpperCase isEqualToString:@"OFF"]) 
    {
        trackerInstance.profile = LQTrackerProfileOff;
    }
    else if([trackerProfileUpperCase isEqualToString:@"PASSIVE"])
    {
        trackerInstance.profile = LQTrackerProfilePassive;
    }
    else if([trackerProfileUpperCase isEqualToString:@"REALTIME"])
    {
        trackerInstance.profile = LQTrackerProfileRealtime;
    }
    else if([trackerProfileUpperCase isEqualToString:@"LOGGING"])
    {
        trackerInstance.profile = LQTrackerProfileLogging;
    }

}

// Getter Property
-(NSString*)profile
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    if (trackerInstance.profile == LQTrackerProfileOff) 
    {
        return @"OFF";
    }
    else if(trackerInstance.profile == LQTrackerProfilePassive)
    {
        return @"PASSIVE";
    }
    else if(trackerInstance.profile == LQTrackerProfileRealtime)
    {
        return @"REALTIME";
    }
    else if(trackerInstance.profile = LQTrackerProfileLogging)
    {
        return @"LOGGING";
    }

}

// Getter Method
-(NSString*)getProfile:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
    
    if (trackerInstance.profile == LQTrackerProfileOff) 
    {
        return @"OFF";
    }
    else if(trackerInstance.profile == LQTrackerProfilePassive)
    {
        return @"PASSIVE";
    }
    else if(trackerInstance.profile == LQTrackerProfileRealtime)
    {
        return @"REALTIME";
    }
    else if(trackerInstance.profile = LQTrackerProfileLogging)
    {
        return @"LOGGING";
    }
    
}

-(void)setStatus:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    
    NSString *trackerStatus       =   [TiUtils stringValue:args];
    
    //CONVERT THE PARAMETER VALUE TO UPPERCASE STRING TO MAKE COMPARISON CASE INSENSATIVE   
    NSString *trackerStatusUpperCase   =   [trackerStatus uppercaseString];
    
    
    if ([trackerStatusUpperCase isEqualToString:@"LIVE"]) 
    {
        trackerInstance.status = LQTrackerStatusLive;
    }
    else if([trackerStatusUpperCase isEqualToString:@"NOTTRACKING"])
    {
        trackerInstance.status = LQTrackerStatusNotTracking;
    }
    else if([trackerStatusUpperCase isEqualToString:@"QUEUEING"])
    {
        trackerInstance.status = LQTrackerStatusQueueing;
    }
}

// Getter Property
-(NSString*)status
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }
   
    if (trackerInstance.status = LQTrackerStatusLive) 
    {
        return @"LIVE";
    }
    else if(trackerInstance.status = LQTrackerStatusNotTracking)
    {
        return @"NOTTRACKING";
    }
    else if(trackerInstance.status = LQTrackerStatusQueueing)
    {
        return @"QUEUEING";
    }
    
}

// Getter Method
-(NSString*)getStatus:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    if (trackerInstance.status = LQTrackerStatusLive) 
    {
        return @"LIVE";
    }
    else if(trackerInstance.status = LQTrackerStatusNotTracking)
    {
        return @"NOTTRACKING";
    }
    else if(trackerInstance.status = LQTrackerStatusQueueing)
    {
        return @"QUEUEING";
    }
    
}

-(void)setErrorStatus:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    NSError *err = [NSError errorWithDomain:nil code:[TiUtils intValue:[args valueForKey:@"code"]] userInfo:[args valueForKey:@"userInfo"]];
    trackerInstance.errorStatus = args;
}

// Getter Property
-(NSDictionary*)errorStatus
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[trackerInstance.errorStatus code]],@"code",[NSString stringWithFormat:@"%@",[trackerInstance.errorStatus localizedDescription]],@"userInfo",nil];
    return event;
    
}

// Getter Method
-(NSDictionary*)getErrorStatus:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    NSDictionary *errorStatus = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[trackerInstance.errorStatus code]],@"code",[NSString stringWithFormat:@"%@",[trackerInstance.errorStatus localizedDescription]],@"userInfo",nil];
    return errorStatus;
    
}


// Getter Property
-(NSDate*)dateOfLastLocationUpdate
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.dateOfLastLocationUpdate;
    
}

// Getter Method
-(NSDate*)getDateOfLastLocationUpdate:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.dateOfLastLocationUpdate;
    
}


// Getter Property
-(NSDate*)dateOfLastSyncedLocationUpdate
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.dateOfLastSyncedLocationUpdate;
    
}

// Getter Method
-(NSDate*)getDateOfLastSyncedLocationUpdate:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.dateOfLastSyncedLocationUpdate;
    
}


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
	
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:month];
	[comps setDay:day];
	[comps setYear:year];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *result = [gregorian dateFromComponents:comps];
	[comps release];
	[gregorian release];
	
	//NSLog(@"[INFO] %@", result);

    trackerInstance.refreshTriggersDate = result;
}

// Getter Property
-(NSDate*)refreshTriggersDate
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.refreshTriggersDate;
    
}

// Getter Method
-(NSDate*)getRefreshTriggersDate:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    return trackerInstance.refreshTriggersDate;
    
}


-(void)setRefreshTriggersRegion:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    CLLocationDegrees latitudeRef =  [[args valueForKey:@"latitude"] doubleValue];
    CLLocationDegrees longitudeRef = [[args valueForKey:@"longitude"] doubleValue];
    CLLocationDistance locRadius =  [[args valueForKey:@"radius"] doubleValue];
    NSString *identifier = [TiUtils stringValue:[args valueForKey:@"identifier"]];

    CLLocationCoordinate2D cordinates;
    cordinates.latitude = latitudeRef;
    cordinates.longitude = longitudeRef;
    
    CLRegion *region = [[CLRegion alloc]initCircularRegionWithCenter:cordinates radius:locRadius identifier:identifier];
    trackerInstance.refreshTriggersRegion = region;
}

// Getter Property
-(NSDictionary*)refreshTriggersRegion
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    CLLocationDegrees latitudeRef = [trackerInstance.refreshTriggersRegion center].latitude;
    CLLocationDegrees longitudeRef = [trackerInstance.refreshTriggersRegion center].longitude;
    
    NSDictionary *regionDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%@",latitudeRef],@"latitude",
                                 [NSString stringWithFormat:@"%@",longitudeRef],@"longitude",
                                 [NSString stringWithFormat:@"%@",[trackerInstance.refreshTriggersRegion radius ]],@"radius",
                                 [NSString stringWithFormat:@"%@",[trackerInstance.refreshTriggersRegion identifier ]],@"identifier",nil];
    return regionDict;
    
}

// Getter Method
-(NSDictionary*)getRefreshTriggersRegion:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]];
    }

    CLLocationDegrees latitudeRef = [trackerInstance.refreshTriggersRegion center].latitude;
    CLLocationDegrees longitudeRef = [trackerInstance.refreshTriggersRegion center].longitude;
    
    NSDictionary *regionDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%@",latitudeRef],@"latitude",
                                [NSString stringWithFormat:@"%@",longitudeRef],@"longitude",
                                [NSString stringWithFormat:@"%@",[trackerInstance.refreshTriggersRegion radius ]],@"radius",
                                [NSString stringWithFormat:@"%@",[trackerInstance.refreshTriggersRegion identifier ]],@"identifier",nil];
    return regionDict;
    
}

@end
