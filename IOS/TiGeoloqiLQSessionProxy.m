/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGeoloqiLQSessionProxy.h"
#import "TiApp.h"
#import "TiGeoloqiModule.h"

@implementation TiGeoloqiLQSessionProxy

@synthesize objRequestHelper;


#pragma mark-
#pragma mark life cycle event

//==========================================================================================
//  Method Name: _initWithProperties
//  Return Type: void
//  Parameter  : NSDictionary: properties 
//  description: Proxy lifecycle event, when proxy get initlized with specified inline properties        
//
//  created by : Globallogic
//==========================================================================================
-(void) _initWithProperties:(NSDictionary *)properties
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    
    NSString *strAPIKey     =   [Utils getStringValueForDict:properties fromKey:CONST_GEOLOQI_SERVICE_API_KEY];
    NSString *strAPISecret  =   [Utils getStringValueForDict:properties fromKey:CONST_GEOLOQI_SERVICE_API_SECRET];
    
    //CHECK IF API SECRET & KEY IS NOT PASSED BY DEVELOPER THEN THROW ERROR THAT MANDATORY 
    //PARAMETERS ARE NOT AVAILABLE
    if ([strAPIKey isEqualToString:CONST_EMPTY_STRING] && [strAPISecret isEqualToString:CONST_EMPTY_STRING])
    {
        //%s@"TiGeoloqiLQSessionProxy::IF API SECRET OR KEY IS BLANK");  
        
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_API_KEY_SECRET_CODE
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_API_KEY_SECRET 
                                                       method:CONST_EMPTY_STRING];
        
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        [self.objRequestHelper setAPIKey:strAPIKey secret:strAPISecret];
    }
}

//==========================================================================================
//  Method Name: init
//  Return Type: id
//  Parameter  : N.A.
//  description: override init method to initlize request helper object       
//
//  created by : Globallogic
//==========================================================================================
-(id)init
{
    if (self=[super init])
    {
        RequestHelper *objReqHelper   =   [[RequestHelper alloc] initWithDelegate:self];   
        self.objRequestHelper         =   objReqHelper;
        
        [objReqHelper release];
        objReqHelper    =   nil;
    }
   
    return self;
}

#pragma mark-
#pragma mark  Exposed method to titanium developers
//==========================================================================================
//  Method Name: authenticateUser
//  Return Type: void
//  Parameter  : id: args 
//  description: Authenticate the given username password & if authenticated 
//               then save the session       
//
//  created by : Globallogic
//==========================================================================================
-(void) authenticateUser:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }


    
    if ([args count]!=3)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",_cmd]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString *strUserName   =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSString *strPassword   =   [TiUtils stringValue:[args objectAtIndex:1]];
        
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:2];
        
        id success = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS];
        id error = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE];
      
        //IF EVENT LISTNERS ARE NOT VALID/PROVIDED THEN THROW VALIDATION ERROR
        if (success==nil || error==nil)
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];

            return;
        }
        
        [self.objRequestHelper configureSessionForUserName:strUserName
                                                  password:strPassword 
                                       successEventListner:success
                                         errorEventListner:error];
    }
}

//==========================================================================================
//  Method Name: createAnonymousUserAccount
//  Return Type: void
//  Parameter  : id: args 
//  description: Create the anonoumous account with information provided by user       
//
//  created by : Globallogic
//==========================================================================================
-(void) createAnonymousUserAccount:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if ([args count]!=2)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",_cmd]];
        
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSDictionary *extraInfo   =  [args objectAtIndex:0];
        
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:1];
        
        id success = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS];
        id error = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE];
        
        //IF EVENT LISTNERS ARE NOT VALID/PROVIDED THEN THROW VALIDATION ERROR
        if (success==nil || error==nil)
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];
            
            return;
        }

        
        [self.objRequestHelper createAnonymousAccountWithInfo:extraInfo 
                                          successEventListner:success 
                                            errorEventListner:error];
    }    
}

//==========================================================================================
//  Method Name: createAccountForUserName: password: extraInfo
//  Return Type: void
//  Parameter  : id: args

//  description: create the new accont on the go
//
//  created by : Globallogic
//==========================================================================================
-(void) createAccountWithUsername:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=3)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",_cmd]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strUserName       =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSString     *strPassword       =   [TiUtils stringValue:[args objectAtIndex:1]];
        //NSDictionary *dictExtraInfo     =   [args objectAtIndex:2];
        
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:2];
        
        id success  = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS];
        id error    = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE];
        
        //IF EVENT LISTNERS ARE NOT VALID/PROVIDED THEN THROW VALIDATION ERROR
        if (success==nil || error==nil)
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];
            
            return;
        }

        
        [self.objRequestHelper createAccountForUserName:strUserName
                                               password:strPassword 
                                              extraInfo:nil 
                                    successEventListner:success 
                                      errorEventListner:error];
    }
}

//==========================================================================================
//  Method Name: runAPIRequest:
//  Return Type: void
//  Parameter  : id: args

//  description: Make the request to geoloqi server
//
//  created by : Globallogic
//==========================================================================================
-(void) runAPIRequest:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=4)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",_cmd]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSString     *strHttpVerb       =   [TiUtils stringValue:[args objectAtIndex:1]];
        NSDictionary *dictExtraInfo     =   [args objectAtIndex:2];
        
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:3];
        
        id success = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS];
        id error = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE];
        
        //IF EVENT LISTNERS ARE NOT VALID/PROVIDED THEN THROW VALIDATION ERROR
        if (success==nil || error==nil)
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];
            
            return;
        }

        
        [self.objRequestHelper runApiRequestWithAPIName:strApiName
                                             methodName:strHttpVerb 
                                                payload:dictExtraInfo 
                                    successEventListner:success 
                                      errorEventListner:error];
    }
}

//==========================================================================================
//  Method Name: runGetRequest:
//  Return Type: void
//  Parameter  : id: args

//  description: Make the GET request to geoloqi server
//
//  created by : Globallogic
//==========================================================================================
-(void) runGetRequest:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if ([args count]!=2)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",_cmd]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:0]];
        
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:1];
        
        id success = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS];
        id error = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE];
        
        //IF EVENT LISTNERS ARE NOT VALID/PROVIDED THEN THROW VALIDATION ERROR
        if (success==nil || error==nil)
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];
            
            return;
        }

        
        [self.objRequestHelper runGetRequestWithAPIName:strApiName 
                                    successEventListner:success 
                                      errorEventListner:error];
    }
}

//==========================================================================================
//  Method Name: runPostRequestWithJSONObject:
//  Return Type: void
//  Parameter  : id: args

//  description: Make the POST request to geoloqi server
//
//  created by : Globallogic
//==========================================================================================
-(void) runPostRequestWithJSONObject:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=3)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",_cmd]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSDictionary *dictExtraInfo     =   [args objectAtIndex:1];
        
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:2];
        
        id success = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS];
        id error = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE];
        
        //IF EVENT LISTNERS ARE NOT VALID/PROVIDED THEN THROW VALIDATION ERROR
        if (success==nil || error==nil)
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];
            
            return;
        }

        
        [self.objRequestHelper runPostRequestWithAPIName:strApiName
                                                 payload:dictExtraInfo 
                                     successEventListner:success 
                                       errorEventListner:error];
    }
}

//==========================================================================================
//  Method Name: runPostRequestWithJSONArray:
//  Return Type: void
//  Parameter  : id: args

//  description: Make the POST request to geoloqi server
//
//  created by : Globallogic
//==========================================================================================
-(void) runPostRequestWithJSONArray:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    
    if ([args count]!=3)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",_cmd]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSArray      *arrExtraInfo      =   [args objectAtIndex:1];
        
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:2];
        
        id success = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS];
        id error = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE];
        
        //IF EVENT LISTNERS ARE NOT VALID/PROVIDED THEN THROW VALIDATION ERROR
        if (success==nil || error==nil)
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];
            
            return;
        }

        
        [self.objRequestHelper runPostRequestWithAPIName:strApiName
                                                 payload:arrExtraInfo 
                                     successEventListner:success 
                                       errorEventListner:error];
    }
    
}

//==========================================================================================
//  Method Name: getAccessToken:
//  Return Type: NSString
//  Parameter  : id: args

//  description: Returns the access token of saved session
//
//  created by : Globallogic
//==========================================================================================
-(NSString *) getAccessToken:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    return [self.objRequestHelper getAccessToken];
}

//==========================================================================================
//  Method Name: accessToken: (Exposed as property)
//  Return Type: NSString
//  Parameter  : id: args

//  description: Returns the access token of saved session
//
//  created by : Globallogic
//==========================================================================================
-(NSString *) accessToken
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    
    return [self.objRequestHelper getAccessToken];
}

//==========================================================================================
//  Method Name: setSavedSession:
//  Return Type: void
//  Parameter  : LQSession: session

//  description: set the session object
//
//  created by : Globallogic
//==========================================================================================
-(void) setSavedSession:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    TiGeoloqiLQSessionProxy *proxy  =   (TiGeoloqiLQSessionProxy *)args;
    
    [LQSession setSavedSession:proxy.objRequestHelper.objSession];
}

//==========================================================================================
//  Method Name: savedSession:
//  Return Type: LQSession
//  Parameter  : id: args

//  description: get the session object
//
//  created by : Globallogic
//==========================================================================================
-(id) savedSession:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    TiGeoloqiLQSessionProxy *newProxy  =   [[[TiGeoloqiLQSessionProxy alloc] init] autorelease];
    
    [newProxy.objRequestHelper setObjSession:[LQSession savedSession]];
    
    return [newProxy retain];
}

//==========================================================================================
//  Method Name: sessionWithAccessToken:   
//  Return Type: id
//  Parameter  : NSString: accessToken

//  description: get the session object from access token
//
//  created by : Globallogic
//==========================================================================================
-(id) sessionWithAccessToken:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    TiGeoloqiLQSessionProxy *newProxy   =   nil;
    
    NSString *accessToken    =    [TiUtils stringValue:[args objectAtIndex:0]];
    
    LQSession *session  =   [self.objRequestHelper sessionWithAccessToken:accessToken];

    if (session!=nil)
    {
        newProxy   =   [[[TiGeoloqiLQSessionProxy alloc] init] autorelease];
        [newProxy.objRequestHelper setObjSession:session];
    }
    
    return newProxy;
}

#pragma pragma mark-
#pragma mark Callback Events
//==========================================================================================
//  Method Name: requestCompleteWithSuccess
//  Return Type: void
//  Parameter  : NSDictionary: responseDictionary 
//  description: Callback event, request is successfully completed from request helper class using geoloqi sdk, return the resonse object recieved from geoloqi server       
//
//  created by : Globallogic
//==========================================================================================
-(void) requestCompleteWithSuccess:(NSDictionary *) responseDictionary  eventListner:(id) listner
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    [self _fireEventToListener:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS withObject:[Utils getResponseDictionary:responseDictionary] listener:listner
                    thisObject:nil];
    
}

//==========================================================================================
//  Method Name: requestCompleteWithError
//  Return Type: void
//  Parameter  : NSError: error 
//  description: Callback event, there is some error from geoloqi service, return the error object with error_key & error_description       
//
//  created by : Globallogic
//==========================================================================================
-(void) requestCompleteWithError:(NSError *) error eventListner:(id) listner
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //%s@"TiGeoloqiLQSessionProxy::requestCompleteWithError called");

    [self _fireEventToListener:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE withObject:[Utils getDictionaryFromErrorObject:error] listener:listner
                    thisObject:nil];
    
}

//==========================================================================================
//  Method Name: requestCompleteWithValidationError
//  Return Type: void
//  Parameter  : NSError: error 
//  description: Callback event, there is some validation error checked locally       
//
//  created by : Globallogic
//==========================================================================================
-(void) requestCompleteWithValidationError:(NSError *) error
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    [[TiGeoloqiModule getCurrentObject] validationErrorOccuredWithError:error];
}


#pragma pragma mark-
#pragma mark Memory Methods
//==========================================================================================
//  Method Name: dealloc
//  Return Type: void
//  Parameter  : N.A. 
//  description: Release the memory resources      
//
//  created by : Globallogic
//==========================================================================================
-(void) dealloc
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

   // RELEASE_TO_NIL(self.objRequestHelper);
    
    [super dealloc];
}

#pragma pragma mark-
#pragma mark APN Methods
////==========================================================================================
////  Method Name: isPushEnabled
////  Return Type: BOOL
////  Parameter  : N.A.
//
////  description: Check if APN is Enabled
////
////  created by : Globallogic
////==========================================================================================
//-(BOOL) isPushEnabled:(id) args
//{
//    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
//    {
//        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
//    }
//
//    
//    return [self.objRequestHelper isPushEnabled];
//}
//
////==========================================================================================
////  Method Name: setPushEnabled
////  Return Type: void
////  Parameter  : BOOL: bPushEnable
//
////  description: Set the APN Enable
////
////  created by : Globallogic
////==========================================================================================
//-(void) setPushEnabled:(id) args
//{
//    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
//    {
//        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
//    }
//
//    
//    if (!args)
//    {
//        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
//                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
//                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
//        
//        [self requestCompleteWithValidationError:objError];
//    }
//    else
//    {
//        BOOL bPushEnabled    =  [TiUtils boolValue:args]; 
//        [self.objRequestHelper setPushEnabled:bPushEnabled];
//    }    
//}

//==========================================================================================
//  Method Name: applicationDidFinishLaunchWithOptions
//  Return Type: void
//  Parameter  : N.A.

//  description: This Method is to be called by the user to set all the launch options from App launch Setting.
//
//  created by : Globallogic
//==========================================================================================
-(void)applicationDidFinishLaunchWithOptions:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    [self.objRequestHelper applicationDidFinish:(UIApplication *)[TiApp app] WithLaunchOptions:[[TiApp app] launchOptions]];
}

//==========================================================================================
//  Method Name: registerDeviceToken
//  Return Type: void
//  Parameter  : id: can be type casted to NSString or TiBlob

//  description: Used to register the device token for push notification.
//
//  created by : Globallogic
//==========================================================================================
-(void)registerDeviceToken:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if (args && [[args objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        NSData *deviceToken = [[args objectAtIndex:0] dataUsingEncoding:NSUTF8StringEncoding];
        [LQSession registerDeviceToken:deviceToken];
    }
    if (args && [[args objectAtIndex:0] isKindOfClass:[TiBlob class]])
    {
        [LQSession registerDeviceToken:[[args objectAtIndex:0] data]];
    }
}

//==========================================================================================
//  Method Name: handleDidFailToRegisterForRemoteNotifications
//  Return Type: void
//  Parameter  : NSDictionary : args

//  description: Used to handle the failure in registering for remote notification.
//
//  created by : Globallogic
//==========================================================================================
-(void)handleDidFailToRegisterForRemoteNotifications:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    NSError *err = [NSError errorWithDomain:@"remoteNotification" code:[TiUtils intValue:[[args objectAtIndex:0] valueForKey:@"code"]] userInfo:[[args objectAtIndex:0] valueForKey:@"userInfo"]];
    [LQSession handleDidFailToRegisterForRemoteNotifications:err];
}

//==========================================================================================
//  Method Name: handlePush
//  Return Type: void
//  Parameter  : NSDictionary : userInfo

//  description: Used to handle the push notification.
//
//  created by : Globallogic
//==========================================================================================
-(void)handlePush:(id) userInfo
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if (userInfo && [[userInfo objectAtIndex:0] isKindOfClass:[NSDictionary class]]) {
        [LQSession handlePush:[userInfo objectAtIndex:0]];
    }
}

//==========================================================================================
//  Method Name: deviceIdentifier
//  Return Type: TiBlob*
//  Parameter  : N.A.

//  description: Property getter used to get the device identifier in BLOB format.
//
//  created by : Globallogic
//==========================================================================================
-(TiBlob *)deviceIdentifier
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    return [[[TiBlob alloc]initWithData:[LQSession deviceIdentifier] mimetype:@"application/octet-stream"] autorelease];
}

//==========================================================================================
//  Method Name: getDeviceIdentifier
//  Return Type: TiBlob*
//  Parameter  : N.A.

//  description: Method used to get the device identifier in BLOB format.
//
//  created by : Globallogic
//==========================================================================================
-(TiBlob *)getDeviceIdentifier:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    
    return [[[TiBlob alloc]initWithData:[LQSession deviceIdentifier] mimetype:@"application/octet-stream"] autorelease];
}

//==========================================================================================
//  Method Name: setDeviceIdentifier
//  Return Type: void
//  Parameter  : TiBlob :args

//  description: Method used to set the device identifier, passed parameter must be a BLOB Object.
//
//  created by : Globallogic
//==========================================================================================
-(void)setDeviceIdentifier:(TiBlob*)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if (args && [args isKindOfClass:[TiBlob class]])
    {
        [LQSession setDeviceIdentifier:[args data]];
    }
}

//==========================================================================================
//  Method Name: deviceIdentifierHexString
//  Return Type: NSString
//  Parameter  : N.A.

//  description: Property getter used to get the device identier in HEX string.
//
//  created by : Globallogic
//==========================================================================================
-(NSString *)deviceIdentifierHexString
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    return [LQSession deviceIdentifierHexString];
}

//==========================================================================================
//  Method Name: getDeviceIdentifierHexString
//  Return Type: NSString
//  Parameter  : N.A.

//  description: Method used to get the device identier in HEX string.
//
//  created by : Globallogic
//==========================================================================================
-(NSString *)getDeviceIdentifierHexString:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    
    return [LQSession deviceIdentifierHexString];
}

//==========================================================================================
//  Method Name: registerForPushNotificationsWithCallback
//  Return Type: void
//  Parameter  : N.A.

//  description: Method used to register for PUSH NOTIFICATION, and two call back events are fired,
//               one for error and one for success.
//
//  created by : Globallogic
//==========================================================================================
-(void)registerForPushNotificationsWithCallback:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if ([args count]!=1)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",_cmd]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:0];
        
        id success = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS];
        id error = [dictEventListners objectForKey:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE];
        
        //IF EVENT LISTNERS ARE NOT VALID/PROVIDED THEN THROW VALIDATION ERROR
        if (success==nil || error==nil)
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_EVENT_LISTNERS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];
            
            return;
        }
        
        
        [self.objRequestHelper registerForPushNotificationsWithSuccessEventListner:success
                                                                 errorEventListner:error];
    }
}

//==========================================================================================
//  Method Name: pushAlertsEnabled
//  Return Type: BOOL
//  Parameter  : N.A.

//  description: used to get the bool value that whether push alerts are enabled or not
//
//  created by : Globallogic
//==========================================================================================
-(BOOL)pushAlertsEnabled:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    return [self.objRequestHelper.objSession pushAlertsEnabled];
}

//==========================================================================================
//  Method Name: pushSoundsEnabled
//  Return Type: BOOL
//  Parameter  : N.A.

//  description: used to get the bool value that whether push sounds are enabled or not
//
//  created by : Globallogic
//==========================================================================================
-(BOOL)pushSoundsEnabled:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    return [self.objRequestHelper.objSession pushSoundsEnabled];
}

//==========================================================================================
//  Method Name: pushBadgesEnabled
//  Return Type: BOOL
//  Parameter  : N.A.

//  description: used to get the bool value that whether push badges are enabled or not
//
//  created by : Globallogic
//==========================================================================================
-(BOOL)pushBadgesEnabled:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    return [self.objRequestHelper.objSession pushBadgesEnabled];
}

/*
//==========================================================================================
//  Method Name: cancelRequest
//  Return Type: BOOL
//  Parameter  : id: args, should be of NSArray Type.

//  description: method used to cancel the request which is not processed yet,
//               but if processed the ready to parse the response.
//
//  created by : Globallogic
//==========================================================================================
-(void)cancelRequest:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if ([[args objectAtIndex:0] isEqualToString:@"requestSessionWithUsername"])
    {
        [self.objRequestHelper.objSession cancelRequest:[LQSession requestSessionWithUsername:nil password:nil completion:^(LQSession *session, NSError *error) {
        }]];
    }
    else if([[args objectAtIndex:0] isEqualToString:@"createAccountWithUsername"])
    {
        [self.objRequestHelper.objSession cancelRequest:[LQSession createAccountWithUsername:nil password:nil extra:nil completion:^(LQSession *session, NSError *error) {
        }]];
        
    }
    else if([[args objectAtIndex:0] isEqualToString:@"createAnonymousUserAccountWithUserInfo"])
    {
        [self.objRequestHelper.objSession cancelRequest:[LQSession createAnonymousUserAccountWithUserInfo:nil completion:^(LQSession *session, NSError *error) {
        }]];
        
    }
    else if([[args objectAtIndex:0] isEqualToString:@"runAPIRequest"])
    {
        [self.objRequestHelper.objSession cancelRequest:[self.objRequestHelper.objSession runAPIRequest:nil completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        }]];
        
    }
}
*/

#pragma mark-
#pragma mark new methods (SDK version 12.160) 

//==========================================================================================
//  Method Name: getUserID:
//  Return Type: NSString
//  Parameter  : id: args, this value will be ignored

//  description: Returns the user id of authentic user
//
//  created by : Globallogic
//==========================================================================================
-(NSString *) getUserID:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    return [self.objRequestHelper getUserID];
}

//==========================================================================================
//  Method Name: userID:
//  Return Type: NSString
//  Parameter  : id: args, this value will be ignored

//  description: Returns the user id of authentic user
//
//  created by : Globallogic
//==========================================================================================
-(NSString *) userID
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    
    return [self.objRequestHelper getUserID];
}

@end
