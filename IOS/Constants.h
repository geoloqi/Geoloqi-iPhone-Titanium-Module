//
//  Constants.h
//  geoloqimodule
//
//  Created by globallogic on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#pragma mark-
#pragma mark GeoLoqi Service Accounts Constants

#pragma mark-
#pragma mark Genral Constants
#define CONST_EMPTY_STRING                     @""
#define CONST_DEVICE_TOKEN                     @"deviceToken"

#pragma pragma mark-
#pragma mark Inline Properties

#define CONST_GEOLOQI_SERVICE_API_KEY          @"apiKey"
#define CONST_GEOLOQI_SERVICE_API_SECRET       @"apiSecret"
#define CONST_GEOLOQI_SERVICE_USERNAME         @"userName"
#define CONST_GEOLOQI_SERVICE_PASSWORD         @"password"

#pragma mark-
#pragma mark Service Methods

#define CONST_GEOLOQI_SERVICE_REQUEST_GET        @"GET"
#define CONST_GEOLOQI_SERVICE_REQUEST_POST       @"POST"

#pragma mark-
#pragma mark Callback Events

#define CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS       @"onSuccess"
#define CONST_GEOLOQI_SERVICE_REQUEST_FAILURE       @"onFailure"
#define CONST_GEOLOQI_SERVICE_REQUEST_VALIDATION    @"onValidate"


#define CONST_GEOLOQI_SERVICE_START_FAILURE   @"onServiceFailure"

#pragma mark-
#pragma mark Custom error message

#define CONST_GEOLOQI_VALIDATION_INVALID_ARGS               @"Please provide valid arguments!"
#define CONST_GEOLOQI_VALIDATION_NO_SESSION                 @"Session is NULL!"
#define CONST_GEOLOQI_VALIDATION_INVALID_API_KEY_SECRET     @"Invalid api key or secret passed."
#define CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS     @"Invalid event listners passed."


#pragma mark-
#pragma mark Validation Error Constants

#define CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE               301
#define CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE                 302
#define CONST_GEOLOQI_VALIDATION_INVALID_API_KEY_SECRET_CODE     303
#define CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE     304


#pragma mark-
#pragma mark LQTracker Constants

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


