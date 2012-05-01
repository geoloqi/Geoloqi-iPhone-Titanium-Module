/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import "TiGeoloqiLQSessionProxy.h"

@interface TiGeoloqiLQTrackerProxy : TiProxy {
    
    LQTracker *trackerInstance;
}

//Methods
/**
 * Get Method Used as a property for JS Developer.
 * Used for getting the profile type set to tracker
*/
-(NSString*)profile;
-(void)configureAnonymousUserAccountWithUserInfoAndProfile:(id) args;
-(BOOL)canSwitchToProfile:(id) args;
-(void)refreshNearbyTriggers:(id)args;
-(void)processTriggersForLocation:(id)args;

-(void)setSession:(id) args;
-(TiGeoloqiLQSessionProxy *)getSession:(id)args;

-(void)setProfile:(id)args;
-(NSString*)getProfile:(id)args;

-(void)setStatus:(id)args;
-(NSString*)getStatus:(id)args;

-(void)setErrorStatus:(id)args;
-(NSDictionary*)getErrorStatus:(id)args;

-(NSDate*)dateOfLastLocationUpdate;
-(NSDate*)getDateOfLastLocationUpdate:(id)args;

-(NSDate*)dateOfLastSyncedLocationUpdate;
-(NSDate*)getDateOfLastSyncedLocationUpdate:(id)args;

-(void)setRefreshTriggersDate:(id)args;
-(NSDate*)getRefreshTriggersDate:(id)args;

-(void)setRefreshTriggersRegion:(id)args;
-(NSDictionary*)getRefreshTriggersRegion:(id)args;

@end
