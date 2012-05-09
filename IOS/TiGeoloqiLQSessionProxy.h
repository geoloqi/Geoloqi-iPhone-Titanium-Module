/**
 *   TiGeoloqiLQSessionProxy.h
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */

#import "TiProxy.h"
#import "TiUtils.h"
#import "RequestHelper.h"

@interface TiGeoloqiLQSessionProxy : TiProxy <RequestHelperDelegate> 
{

}

/**
 * Request helper property
 */
@property (nonatomic,retain)     RequestHelper *objRequestHelper;

//Methods
//-(NSString *) getAccessToken:(id) args;
//-(NSString *) accessToken;

/**
 * Returns the user id of authentic user
 */
-(NSString *) getUserId:(id) args;

//Async call to geoloqi server
/**
 * Make the request to geoloqi server
 */
-(void) apiRequest:(id) args;

/**
 * Make the GET request to geoloqi serverr
 */
-(void) getRequest:(id) args;

/**
 * Make the POST request to geoloqi server
 */
-(void) postRequest:(id) args;

//Future methods, not implemented yet on geoloqi sdk
/**
 * Returns the user name of authentic user
 */
-(NSString *) getUsername:(id) args;

/**
 * Is current session is anonymous
 */
-(BOOL) isAnonymous:(id) args;




@end
