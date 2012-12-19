/**
 *   Constants.h
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */


#pragma mark-
#pragma mark GeoLoqi Service Accounts Constants

#pragma mark-
#pragma mark Genral Constants
#define CONST_EMPTY_STRING                     @""
#define CONST_DEVICE_TOKEN                     @"deviceToken"

#pragma pragma mark-
#pragma mark Inline Properties

#define CONST_GEOLOQI_SERVICE_API_KEY           @"clientId"
#define CONST_GEOLOQI_SERVICE_API_SECRET        @"clientSecret"
#define CONST_GEOLOQI_SERVICE_USERNAME          @"username"
#define CONST_GEOLOQI_SERVICE_PASSWORD          @"password"
#define CONST_GEOLOQI_SERVICE_TRACKING_PROFILE  @"trackingProfile"
#define CONST_GEOLOQI_SERVICE_ALLOW_ANONYMOUS   @"allowAnonymousUsers"
#define CONST_GEOLOQI_SERVICE_USER_KEY          @"key"
#define CONST_GEOLOQI_SERVICE_USER_LAYERS       @"layerIds"
#define CONST_GEOLOQI_SERVICE_USER_GROUPS       @"groupTokens"

#pragma mark-
#pragma mark Service Methods

#define CONST_GEOLOQI_SERVICE_REQUEST_GET        @"GET"
#define CONST_GEOLOQI_SERVICE_REQUEST_POST       @"POST"

#pragma mark-
#pragma mark Callback Events

#define CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS       @"onSuccess"
#define CONST_GEOLOQI_SERVICE_REQUEST_FAILURE       @"onFailure"
#define CONST_GEOLOQI_SERVICE_REQUEST_VALIDATION    @"onValidate"

#define CONST_GEOLOQI_EVENT_ON_VALIDATE             @"onValidate"
#define CONST_GEOLOQI_EVENT_LOCATION_CHANGED        @"onLocationChanged"
#define CONST_GEOLOQI_EVENT_LOCATION_UPLOADED       @"onLocationUploaded"
#define CONST_GEOLOQI_EVENT_TRACKER_PROFILE_CHANGED @"onTrackerProfileChanged"


#define CONST_GEOLOQI_SERVICE_START_FAILURE   @"onServiceFailure"

#pragma mark-
#pragma mark Custom error message


#define CONST_GEOLOQI_VALIDATION_INVALID_ARGS               @"Invalid arguments passed!"
#define CONST_GEOLOQI_VALIDATION_NO_SESSION                 @"Valid session is not available!"
#define CONST_GEOLOQI_VALIDATION_INVALID_API_KEY_SECRET     @"Invalid clientId or clientSecret passed. in init"
#define CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS     @"Invalid event listners passed."


#pragma mark-
#pragma mark Validation Error Constants

#define CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE               301
#define CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE                 302
#define CONST_GEOLOQI_VALIDATION_INVALID_API_KEY_SECRET_CODE     303
#define CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE     304
#define CONST_GEOLOQI_VALIDATION_INVALID_METHOD_CALL             305


#pragma mark LQTracker Profile Enum Constants

#define CONST_GEOLOQI_LQTRACKER_PROFILE_OFF         @"OFF"
#define CONST_GEOLOQI_LQTRACKER_PROFILE_PASSIVE     @"PASSIVE"
#define CONST_GEOLOQI_LQTRACKER_PROFILE_REALTIME    @"REALTIME"
#define CONST_GEOLOQI_LQTRACKER_PROFILE_LOGGING     @"LOGGING"

#pragma mark LQTracker Status Enum Constants
#define CONST_GEOLOQI_LQTRACKER_STATUS_LIVE            @"LIVE"
#define CONST_GEOLOQI_LQTRACKER_STATUS_NOTTRACKING     @"NOTTRACKING"
#define CONST_GEOLOQI_LQTRACKER_STATUS_QUEUEING        @"QUEUEING"

#pragma mark LQTracker Location Constants
#define CONST_GEOLOQI_LQTRACKER_LOCATION_LATITUDE              @"latitude"
#define CONST_GEOLOQI_LQTRACKER_LOCATION_LONGITUDE             @"longitude"
#define CONST_GEOLOQI_LQTRACKER_LOCATION_RADIUS                @"radius"
#define CONST_GEOLOQI_LQTRACKER_LOCATION_IDENTIFIER            @"identifier"


