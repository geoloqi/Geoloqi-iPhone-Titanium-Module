/**
 *  TiGeoloqiiOSProxy.h
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */


#import "TiProxy.h"

@interface TiGeoloqiiOSProxy : TiProxy {

}

/**
 * Method Used to register device token for push notification with geoloqi server.
 */
-(void)registerDeviceToken:(id)deviceTokenArray;

/**
 * Method Used to handle push notification received from geoloqi server.
 */
-(void)handlePush:(id)userInfoArray;

@end
