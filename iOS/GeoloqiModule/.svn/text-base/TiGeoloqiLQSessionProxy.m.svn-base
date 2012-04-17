/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiGeoloqiLQSessionProxy.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "TiGeoloqiModule.h"

@implementation TiGeoloqiLQSessionProxy

@synthesize objRequestHelper;
@synthesize strAuthenicatedUserName;


#pragma mark-
#pragma life cycle event

//==========================================================================================
//  Method Name: _initWithProperties
//  Return Type: void
//  Parameter  : NSDictionary: properties 
//  description: Proxy lifecycle event, when proxy get initlized with specified inline properties        
//
//  created by : Tarun Sharma
//  created on : 12/04/2012
//==========================================================================================
-(void) _initWithProperties:(NSDictionary *)properties
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    strAuthenicatedUserName =   CONST_EMPTY_STRING;    
    
    isServiceStartedSuccessFully    =   NO;
    
    NSString *strAPIKey     =   [Utils getStringValueForDict:properties fromKey:CONST_GEOLOQI_SERVICE_API_KEY];
    NSString *strAPISecret  =   [Utils getStringValueForDict:properties fromKey:CONST_GEOLOQI_SERVICE_API_SECRET];
    
    //CHECK IF API SECRET & KEY IS NOT PASSED BY DEVELOPER THEN THROW ERROR THAT MANDATORY 
    //PARAMETERS ARE NOT AVAILABLE
    if ([strAPIKey isEqualToString:CONST_EMPTY_STRING] && [strAPISecret isEqualToString:CONST_EMPTY_STRING])
    {
        //%s@"TiGeoloqiLQSessionProxy::IF API SECRET OR KEY IS BLANK");  
        
        NSError *objError   =   [Utils getErrorObjectWithCode:111
                                                  description:@"Invalid api key or secret passed." 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        isServiceStartedSuccessFully    =   YES;
        //%s@"TiGeoloqiLQSessionProxy::IF API SECRET OR KEY IS OK");  
       // objRequestHelper        =   [[RequestHelper alloc] initWithDelegate:self];
        
        [self.objRequestHelper setAPIKey:strAPIKey secret:strAPISecret];
    }
}

//==========================================================================================
//  Method Name: init
//  Return Type: id
//  Parameter  : N.A.
//  description: override init method to initlize request helper object       
//
//  created by : Tarun Sharma
//  created on : 17/04/2012
//==========================================================================================
-(id)init
{
    if (self=[super init])
    {
       objRequestHelper        =   [[RequestHelper alloc] initWithDelegate:self];
    }
   
    return self;
}

//==========================================================================================
//  Method Name: authenticateUser
//  Return Type: void
//  Parameter  : id: args 
//  description: Authenticate the given username password & if authenticated 
//               then save the session       
//
//  created by : Tarun Sharma
//  created on : 12/04/2012
//==========================================================================================
-(void) authenticateUser:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=2)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:111 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString *strUserName   =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSString *strPassword   =   [TiUtils stringValue:[args objectAtIndex:1]];
        
        [self.objRequestHelper configureSessionForUserName:strUserName
                                                  password:strPassword];

    }
}

//==========================================================================================
//  Method Name: createAnonymousUserAccount
//  Return Type: void
//  Parameter  : id: args 
//  description: Create the anonoumous account with information provided by user       
//
//  created by : Tarun Sharma
//  created on : 12/04/2012
//==========================================================================================
-(void) createAnonymousUserAccount:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if ([args count]!=1)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:111 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSDictionary *extraInfo   =  [args objectAtIndex:0];
        [self.objRequestHelper createAnonymousAccountWithInfo:extraInfo];
    }    
}



//==========================================================================================
//  Method Name: getUSerName (NOT IMPLEMENTED YET)
//  Return Type: NSString
//  Parameter  : id: args 
//  description: Return the username with which session is authenticated      
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(NSString *) getUSerName:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
   return strAuthenicatedUserName;
}

//==========================================================================================
//  Method Name: createAccountForUserName: password: extraInfo
//  Return Type: void
//  Parameter  : id: args

//  description: create the new accont on the go
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(void) createAccountWithUsername:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=3)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:111 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strUserName   =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSString     *strPassword   =   [TiUtils stringValue:[args objectAtIndex:1]];
        NSDictionary *dictExtraInfo     =   [args objectAtIndex:2];
            
        [self.objRequestHelper createAccountForUserName:strUserName
                                               password:strPassword 
                                              extraInfo:dictExtraInfo];
    }
}

//==========================================================================================
//  Method Name: runAPIRequest:
//  Return Type: void
//  Parameter  : id: args

//  description: Make the request to geoloqi server
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(void) runAPIRequest:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=3)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:111 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSString     *strHttpVerb       =   [TiUtils stringValue:[args objectAtIndex:1]];
        NSDictionary *dictExtraInfo     =   [args objectAtIndex:2];
        
        [self.objRequestHelper runApiRequestWithAPIName:strApiName
                                             methodName:strHttpVerb 
                                                payload:dictExtraInfo];
    }
}

//==========================================================================================
//  Method Name: runGetRequest:
//  Return Type: void
//  Parameter  : id: args

//  description: Make the GET request to geoloqi server
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(void) runGetRequest:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=1)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:111 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:0]];
        [self.objRequestHelper runGetRequestWithAPIName:strApiName];
    }
}

//==========================================================================================
//  Method Name: runPostRequestWithJSONObject:
//  Return Type: void
//  Parameter  : id: args

//  description: Make the POST request to geoloqi server
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(void) runPostRequestWithJSONObject:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=2)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:111 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSDictionary *dictExtraInfo     =   [args objectAtIndex:1];
        
        [self.objRequestHelper runPostRequestWithAPIName:strApiName payload:dictExtraInfo];
    }
}

//==========================================================================================
//  Method Name: runPostRequestWithJSONArray:
//  Return Type: void
//  Parameter  : id: args

//  description: Make the POST request to geoloqi server
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(void) runPostRequestWithJSONArray:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    
    if ([args count]!=2)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:111 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        [self requestCompleteWithValidationError:objError];
    }
    else
    {
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSArray      *arrExtraInfo      =   [args objectAtIndex:1];
        
        [self.objRequestHelper runPostRequestWithAPIName:strApiName payload:arrExtraInfo];
    }
    
}

//==========================================================================================
//  Method Name: getAccessToken:
//  Return Type: NSString
//  Parameter  : id: args

//  description: Returns the access token of saved session
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
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
//  created by : Tarun Sharma
//  created on : 13/04/2012
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
//  created by : Tarun Sharma
//  created on : 13/04/2012
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
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(id) savedSession:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    TiGeoloqiLQSessionProxy *newProxy  =   [[TiGeoloqiLQSessionProxy alloc] init];
    
    [newProxy.objRequestHelper setObjSession:[LQSession savedSession]];
    
    return newProxy;
}

//==========================================================================================
//  Method Name: sessionWithAccessToken:   (NOT IMPLEMENTED YET)
//  Return Type: id
//  Parameter  : NSString: accessToken

//  description: get the session object from access token
//
//  created by : Tarun Sharma
//  created on : 16/04/2012
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
        newProxy   =   [[TiGeoloqiLQSessionProxy alloc] init];// autorelease];
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
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) requestCompleteWithSuccess:(NSDictionary *) responseDictionary
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //%s@"TiGeoloqiLQSessionProxy::requestCompleteWithSuccess called");  
    //%s@"Response dictnary %@",responseDictionary);
    
    if ([self _hasListeners:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS])
    {
        [self fireEvent:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS
             withObject:responseDictionary];
    }
}

//==========================================================================================
//  Method Name: requestCompleteWithError
//  Return Type: void
//  Parameter  : NSError: error 
//  description: Callback event, there is some error from geoloqi service, return the error object with error_key & error_description       
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) requestCompleteWithError:(NSError *) error
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //%s@"TiGeoloqiLQSessionProxy::requestCompleteWithError called");
    
    if ([self _hasListeners:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE])
    {
        [self fireEvent:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE 
             withObject:[Utils getDictionaryFromErrorObject:error]];
    }
}

//==========================================================================================
//  Method Name: requestCompleteWithValidationError
//  Return Type: void
//  Parameter  : NSError: error 
//  description: Callback event, there is some validation error checked locally       
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) requestCompleteWithValidationError:(NSError *) error
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //%s@"TiGeoloqiLQSessionProxy::requestCompleteWithError called");
    
    if ([self _hasListeners:CONST_GEOLOQI_SERVICE_REQUEST_VALIDATION])
    {
        [self fireEvent:CONST_GEOLOQI_SERVICE_REQUEST_VALIDATION 
             withObject:[Utils getDictionaryFromErrorObject:error]];
    }
}



//==========================================================================================
//  Method Name: serviceStartedSuccessFully
//  Return Type: void
//  Parameter  : N.A. 
//  description: Geoloqi service started successfully to make further requests      
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) serviceStartedSuccessFully
{
    
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    //%s@"TiGeoloqiLQSessionProxy::serviceStartedSuccessFully called");                
    
    if ([self _hasListeners:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS])
    {
        [self fireEvent:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS
             withObject:nil];
    }
}





#pragma pragma mark-
#pragma mark Memory Methods
//==========================================================================================
//  Method Name: dealloc
//  Return Type: void
//  Parameter  : N.A. 
//  description: Release the memory resources      
//
//  created by : Tarun Sharma
//  created on : 12/04/2012
//==========================================================================================
-(void) dealloc
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    RELEASE_TO_NIL(strAuthenicatedUserName);
    RELEASE_TO_NIL(objRequestHelper);
    [super dealloc];
}

//==========================================================================================
//  Method Name: isPushEnabled
//  Return Type: BOOL
//  Parameter  : N.A.

//  description: Check if APN is Enabled
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(BOOL) isPushEnabled:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    [self.objRequestHelper isPushEnabled];
}

//==========================================================================================
//  Method Name: setPushEnabled
//  Return Type: void
//  Parameter  : BOOL: bPushEnable

//  description: Set the APN Enable
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(void) setPushEnabled:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if ([args count]!=1)
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:111 
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                       method:[NSString stringWithFormat:@"%s",__FUNCTION__]];
        
        [self requestCompleteWithError:objError];
    }
    else
    {
        BOOL bPushEnabled    =  [TiUtils boolValue:[args objectAtIndex:0]]; 
        [self.objRequestHelper setPushEnabled:bPushEnabled];
    }    
}

-(void)applicationDidFinishLaunchWithOptions:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    TiApp *appObject = [[TiApp alloc]init];
    [LQSession application:(UIApplication*)[TiApp app] didFinishLaunchingWithOptions:[appObject launchOptions]];
    [appObject release];
}

-(void)registerDeviceToken:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if (args && [args isKindOfClass:[NSString class]])
    {
        NSData *deviceToken = [args dataUsingEncoding:NSUTF8StringEncoding];
        [LQSession registerDeviceToken:deviceToken];
    }
    if (args && [args isKindOfClass:[TiBlob class]])
    {
        [LQSession registerDeviceToken:[args data]];
    }
}

-(void)handleDidFailToRegisterForRemoteNotifications:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    NSError *err = [NSError errorWithDomain:@"remoteNotification" code:[TiUtils intValue:[args valueForKey:@"code"]] userInfo:[args valueForKey:@"userInfo"]];
    [LQSession handleDidFailToRegisterForRemoteNotifications:err];
}

-(void)handlePush:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if (args && [args isKindOfClass:[NSDictionary class]]) {
        [LQSession handlePush:args];
    }
}

-(TiBlob *)deviceIdentifier:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    return [[[TiBlob alloc]initWithData:[LQSession deviceIdentifier] mimetype:@"application/octet-stream"] autorelease];
}

-(void)setDeviceIdentifier:(TiBlob*)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    if (args && [args isKindOfClass:[TiBlob class]])
    {
        if ([[args data] isEqualToData:[LQSession deviceIdentifier]]) {
            [LQSession setDeviceIdentifier:[args data]];
        }
        
    }
}

-(NSString *)deviceIdentifierHexString:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    return [LQSession deviceIdentifierHexString];
}

-(void)registerWithGeoLoqiForPushNotificationsWithEvents:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    [LQSession registerForPushNotificationsWithCallback:^(NSData *deviceToken, NSError *error) {
        if(error){
            if ([self _hasListeners:@"REGISTRATION FAILED FOR PUSH NOTIFICATION"])
            {
                NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[error code]],@"code",[NSString stringWithFormat:@"%@",[error localizedDescription]],@"description",nil];
                
                [self fireEvent:@"REGISTRATION FAILED FOR PUSH NOTIFICATION" withObject:event];
            }
            //%s@"Failed to register for push tokens: %@", error);
        } else {
            if ([self _hasListeners:@"REGISTRATION SUCCESSFUL"])
            {
                TiBlob *deviceToken =[[[TiBlob alloc]initWithData:[LQSession deviceIdentifier] mimetype:@"application/octet-stream"] autorelease];
                [self fireEvent:@"REGISTRATION SUCCESSFUL" withObject:deviceToken];
            }
            //%s@"Got a push token! %@", deviceToken);
        }
    }];

}

-(BOOL)pushAlertsEnabled:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    LQSession *sessionObj =[[LQSession alloc]init];
    return [sessionObj pushAlertsEnabled];
    [sessionObj release];
}

-(BOOL)pushSoundsEnabled:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    LQSession *sessionObj =[[LQSession alloc]init];
    return [sessionObj pushSoundsEnabled];
    [sessionObj release];
}

-(BOOL)pushBadgesEnabled:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    
    LQSession *sessionObj =[[LQSession alloc]init];
    return [sessionObj pushBadgesEnabled];
    [sessionObj release];
}

-(void)cancelRequest:(id)args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    LQSession *sessionObj =[[LQSession alloc]init];
    if ([[args objectAtIndex:0] isEqualToString:@"requestSessionWithUsername"])
    {
        [sessionObj cancelRequest:[LQSession requestSessionWithUsername:nil password:nil completion:^(LQSession *session, NSError *error) {
        }]];
    }
    else if([[args objectAtIndex:0] isEqualToString:@"createAccountWithUsername"])
    {
        [sessionObj cancelRequest:[LQSession createAccountWithUsername:nil password:nil extra:nil completion:^(LQSession *session, NSError *error) {
        }]];
        
    }
    else if([[args objectAtIndex:0] isEqualToString:@"createAnonymousUserAccountWithUserInfo"])
    {
        [sessionObj cancelRequest:[LQSession createAnonymousUserAccountWithUserInfo:nil completion:^(LQSession *session, NSError *error) {
        }]];
        
    }
    else if([[args objectAtIndex:0] isEqualToString:@"runAPIRequest"])
    {
        [sessionObj cancelRequest:[sessionObj runAPIRequest:nil completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        }]];
        
    }
    [sessionObj release];
}

@end
