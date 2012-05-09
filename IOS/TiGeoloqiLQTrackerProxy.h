/**
 *   TiGeoloqiLQTrackerProxy.h
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */

#import "TiProxy.h"
#import "TiGeoloqiLQSessionProxy.h"

@interface TiGeoloqiLQTrackerProxy : TiProxy {
    
    LQTracker *trackerInstance;
}

//Methods

/**
 * Method Used to check before switching to another profile,
 * and throwing an error state.
 */
-(BOOL)canSwitchToProfile:(id) args;

/**
 * set Method,Used for setting the profile type to tracker.
 */
//-(void)setProfile:(id)args;

/**
 * Used for getting the profile type set to tracker
 */
-(NSString*)getProfile:(id)args;

/**
 * Get Method Used as a property for JS Developer.
 * Used for getting the profile type set to tracker
 */
-(NSString*)profile;

/**
 * Used for getting the status type returned by tracker.
 */
-(NSString*)getStatus:(id)args;

/**
 * Get Method Used as a property for JS Developer.
 * Used for getting the status type returned by tracker.
 */
-(NSString*)status;

/**
 * Get Method Used as a property for JS Developer.
 * Used for getting the date of last location update returned by tracker.
 */
-(NSDate*)dateOfLastLocationUpdate;

/**
 * Used for getting the date of last location update returned by tracker.
 */
-(NSDate*)getDateOfLastLocationUpdate:(id)args;

/**
 * Get Method Used as a property for JS Developer.
 * Used for getting the date of last synced location update returned by tracker.
 */
-(NSDate*)dateOfLastSyncedLocationUpdate;

/**
 * Used for getting the date of last synced location update returned by tracker.
 */
-(NSDate*)getDateOfLastSyncedLocationUpdate:(id)args;


@end
