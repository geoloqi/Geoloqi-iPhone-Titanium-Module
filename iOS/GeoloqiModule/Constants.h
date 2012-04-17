//
//  Constants.h
//  geoloqimodule
//
//  Created by globallogic on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#pragma mark-
#pragma mark GeoLoqi Service Accounts Constants

#define CONST_GEOLOQI_GET_ACCOUNT_PROFILE      @"/account/profile"
#define CONST_GEOLOQI_GET_ACCOUNT_USERNAME     @"/account/username"

#pragma mark-
#pragma mark GeoLoqi Service Link Constants

#define CONST_GEOLOQI_POST_SHARING_CREATE     @"/link/create"

#pragma mark-
#pragma mark GeoLoqi Service Geonote Constants

#define CONST_GEOLOQI_POST_GEONOTE_CREATE          @"/geonote/create"
#define CONST_GEOLOQI_GET_GEONOTE_INFO_FROM_ID     @"/geonote/info/"



#pragma mark-
#pragma mark Genral Constants
#define CONST_EMPTY_STRING                     @""

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

#define CONST_GEOLOQI_VALIDATION_INVALID_ARGS   @"Please provide valid arguments!"
#define CONST_GEOLOQI_VALIDATION_NO_SESSION     @"Session is NULL!"