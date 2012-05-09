/**
 *  TiGeoloqiModule.h
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */


#import "TiModule.h"
#import "TiGeoloqiLQTrackerProxy.h"
#import "TiGeoloqiLQSessionProxy.h"
#import "RequestHelper.h"
#import "TiGeoloqiiOSProxy.h"

@interface TiGeoloqiModule : TiModule <RequestHelperDelegate> 
{
    BOOL bLogEnabled;
    TiGeoloqiLQSessionProxy *objLQSession;
    TiGeoloqiiOSProxy *objiOSProxy;
    TiGeoloqiLQTrackerProxy *objLQTracker;
}

/**
 * Request helper property
 */
@property (nonatomic,retain)     RequestHelper *objRequestHelper;

//Internal method's not to be exposed to titanium app developer
-(void) setDebug:(id) value;
-(BOOL) isDebugOn;
+(TiGeoloqiModule *) getCurrentObject;
-(void) validationErrorOccuredWithError:(NSError *) err;

/**
 * Initlize the geoloqi with a session & start tracking profile
*/
-(void) init:(id) args;

/**
 * Authenticate the given username password & if authenticated then save the session
 */
-(void) authenticateUser:(id) args;

/**
 * Create the anonoumous account with information provided by user
 */
-(void) createAnonymousUser:(id) args;

/**
 * create the new accont on the go
 */
-(void) createUser:(id) args;

/**
 * Returns sessionProxy object to let user run the session specific methods/properties
 */
-(id) session;

/**
 * Get Method Used as a property for JS Developer.
 * Used for getting the iOS Proxy class object to use the methods of this class.
 */
-(TiGeoloqiiOSProxy*)iOS;

/**
 * Get Method Used as a property for JS Developer.
 * Used for getting the tracker Proxy class object to use the methods of this class.
 */
-(TiGeoloqiLQTrackerProxy*)tracker;

//Future methods, not implemented yet on geoloqi sdk
/**
 * Gets the current value of the low battery tracking preference
 */
-(BOOL) isLowBatteryTrackingEnabled:(id) args;

/**
 * Should enable low battery tracking preference
 */
-(void) enableLowBatteryTracking:(id) args;

/**
 * Should disable low battery tracking preference.
 */
-(void) disableLowBatteryTracking:(id) args;

@end
