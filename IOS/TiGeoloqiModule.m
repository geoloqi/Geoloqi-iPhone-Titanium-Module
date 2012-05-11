/**
 *  TiGeoloqiModule.m
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */


#import "TiGeoloqiModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiGeoloqiLQSessionProxy.h"
#import <TiApp.h>




static  TiGeoloqiModule *currentObject  =   nil;

@implementation TiGeoloqiModule

@synthesize objRequestHelper;

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"0cdcfb92-af6a-4d12-b518-792bb64f1b6f";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.geoloqi";
}

#pragma mark Lifecycle

-(void)startup
{
    bLogEnabled =   NO;
    
    if (self.objRequestHelper==nil)
    {
        RequestHelper *objReqHelper     =   [[RequestHelper alloc] initWithDelegate:self];
        self.objRequestHelper           =    objReqHelper;    
    
        [objReqHelper release];
        objReqHelper    = nil;
    }
        
    
    currentObject   =   self;
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	//NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
    RELEASE_TO_NIL(self.objRequestHelper);
    RELEASE_TO_NIL(objLQSession);
    RELEASE_TO_NIL(objLQTracker);
    RELEASE_TO_NIL(objiOSProxy);
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

//==========================================================================================
//  Method Name: createProxy:forName:context:
//  Return Type: id
//  Parameter  : NSArray: args, NSString: name, id<TiEvaluator>: evaluator

//  description: Overriding "createProxy" method of Timodule to restrict proxy object creation.

//  created by : Globallogic
//==========================================================================================
-(id)createProxy:(NSArray*)args forName:(NSString*)name context:(id<TiEvaluator>)evaluator
{
    return nil;
}

#pragma mark-
#pragma mark  Internal method's not to be exposed

//==========================================================================================
//  Method Name: setDebug
//  Return Type: void
//  Parameter  : id: value
//  description: set the debugger on        
//
//  created by : Globallogic
//==========================================================================================
-(void) setDebug:(id) value
{
    bLogEnabled  =   [TiUtils boolValue:value];
}

//==========================================================================================
//  Method Name: isDebugOn
//  Return Type: BOOL
//  Parameter  : N.A.
//  description: Check if debugger is on        
//
//  created by : Globallogic
//==========================================================================================
-(BOOL) isDebugOn
{
    return bLogEnabled;
}

//==========================================================================================
//  Method Name: getCurrentObject
//  Return Type: TiGeoloqiModule
//  Parameter  : N.A.
//  description: get the module static object     
//
//  created by : Globallogic
//==========================================================================================
+(TiGeoloqiModule *) getCurrentObject
{
    
    return currentObject;
}

//==========================================================================================
//  Method Name: validationErrorOccuredWithError
//  Return Type: void
//  Parameter  : NSError: err
//  description: Local validation error like invalid parameters passed     
//
//  created by : Globallogic
//==========================================================================================
-(void) validationErrorOccuredWithError:(NSError *) err
{
    if ([self _hasListeners:CONST_GEOLOQI_SERVICE_REQUEST_VALIDATION])
    {
        [self fireEvent:CONST_GEOLOQI_SERVICE_REQUEST_VALIDATION 
             withObject:[Utils getDictionaryFromErrorObject:err]];
    }
}

#pragma mark-
#pragma mark  Exposed method to titanium developers
//===================================================================================================================
//  Method Name: init
//  Return Type: Void
//  Parameter  : id: args; where in args user will pass the api key,secret,tracking profile & other parameter
//  description: Initlize the geoloqi with a sessoin & start tracking profile.      
//
//  created by : Globallogic
//===================================================================================================================
-(void) init:(id) args
{
    ENSURE_UI_THREAD_1_ARG(args);
    
    //Check if previous session is available if ys then restore it else create anonymous sesssion
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
        
        return;
    }
    
    //GET THE CALLBACK EVENT LISTNERS
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
    
    
    NSMutableDictionary *dictConfig =   (NSMutableDictionary *)[args objectAtIndex:0];
    
    NSString *strAPIKey          =   [Utils getStringValueForDict:dictConfig fromKey:CONST_GEOLOQI_SERVICE_API_KEY];
    NSString *strAPISecret       =   [Utils getStringValueForDict:dictConfig fromKey:CONST_GEOLOQI_SERVICE_API_SECRET];  
    NSString *strTrackerProfile  =   [Utils getStringValueForDict:dictConfig fromKey:CONST_GEOLOQI_SERVICE_TRACKING_PROFILE];
    
    NSLog(@"apiKey: %d \n apiSecret: %d \n Tracking: %@",strAPIKey,strAPISecret,strTrackerProfile);
    
    //CHECK IF API SECRET & KEY IS NOT PASSED BY DEVELOPER THEN THROW ERROR THAT MANDATORY 
    //PARAMETERS ARE NOT AVAILABLE
    if (([strAPIKey isEqualToString:CONST_EMPTY_STRING]) || ([strAPISecret isEqualToString:CONST_EMPTY_STRING]))
    {
        NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_API_KEY_SECRET_CODE
                                                  description:CONST_GEOLOQI_VALIDATION_INVALID_API_KEY_SECRET 
                                                       method:CONST_EMPTY_STRING];
        
        [self _fireEventToListener:CONST_GEOLOQI_SERVICE_REQUEST_FAILURE withObject:[Utils getDictionaryFromErrorObject:objError] listener:error thisObject:nil];        
        return;
    }
    
    
    [self.objRequestHelper setAPIKey:strAPIKey secret:strAPISecret];
    
    if ([LQSession savedSession]!=nil) 
    {
        NSLog(@"Restoring Session");

        [self sessionAuthenticated];
        [self _fireEventToListener:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS withObject:nil listener:success
                        thisObject:nil];
    }
    else
    {

        
        
        //CHECK IF USER HAS SET "allowAnonymousUsers" externally
        BOOL bAllowAnonymousUsers   =   [TiUtils boolValue:[dictConfig valueForKey:CONST_GEOLOQI_SERVICE_ALLOW_ANONYMOUS] def:YES];
        
        if (bAllowAnonymousUsers)
        {
            [[LQTracker sharedTracker] setProfile:[Utils getTrakerProfileFromString:strTrackerProfile]];
            NSLog(@"Creating anonymous");
            //Set the profile given in init config
            //If no previous session available then call the create anon session 
            [self.objRequestHelper createAnonymousAccountWithInfo:nil 
                                              successEventListner:success 
                                                errorEventListner:error];
        }
        else
        {
            NSLog(@"Not creating anonymous");
            [self _fireEventToListener:CONST_GEOLOQI_SERVICE_REQUEST_SUCCESS withObject:nil listener:success
                            thisObject:nil];
        }
    }
}

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
        ENSURE_UI_THREAD_1_ARG(args);
    
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
//  Method Name: createAnonymousUser
//  Return Type: void
//  Parameter  : id: args 
//  description: Create the anonoumous account with information provided by user       
//
//  created by : Globallogic
//==========================================================================================
-(void) createAnonymousUser:(id) args
{
    
        ENSURE_UI_THREAD_1_ARG(args);
    
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
//  Method Name: createUser: password: extraInfo
//  Return Type: void
//  Parameter  : id: args

//  description: create the new accont on the go
//
//  created by : Globallogic
//==========================================================================================
-(void) createUser:(id) args
{
    
        ENSURE_UI_THREAD_1_ARG(args);
    
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
        NSMutableDictionary *dictUserInfo   =   (NSMutableDictionary *)[args objectAtIndex:0];
        
        NSString     *strUserName       =   [Utils getStringValueForDict:dictUserInfo fromKey:CONST_GEOLOQI_SERVICE_USERNAME];
        
        NSString     *strPassword       =   [Utils getStringValueForDict:dictUserInfo fromKey:CONST_GEOLOQI_SERVICE_PASSWORD];

        
        //IF USERNAME / PWD IS PASSED AS BLANK OR NOT PASSED AT ALL
        if ([strUserName isEqualToString:CONST_EMPTY_STRING] || [strPassword isEqualToString:CONST_EMPTY_STRING])
        {
            NSError *objError   =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_ARGS_CODE 
                                                      description:CONST_GEOLOQI_VALIDATION_INVALID_ARGS 
                                                           method:[NSString stringWithFormat:@"%s",_cmd]];
            [self requestCompleteWithValidationError:objError];
            
            return;
        }
        
        NSMutableDictionary *dictEventListners  =   (NSMutableDictionary *)[args objectAtIndex:1];
        
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

#pragma pragma mark-
#pragma mark Get proxy class refrences
//==========================================================================================
//  Method Name: session
//  Return Type: TiGeoloqiLQSessionProxy 
//  Parameter  : N.A. 
//  description: Returns sessionProxy object to let user run the session specific methods/properties       
//
//  created by : Globallogic
//==========================================================================================
-(id) session
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if (objLQSession!=nil)
    {
        [objLQSession.objRequestHelper setObjSession:[LQSession savedSession]];
    }
    
    return objLQSession;
}

//==========================================================================================
//  Method Name: iOS
//  Return Type: TiGeoloqiiOSProxy*
//  Parameter  : N.A.
//  description: This method will be available as a property to the titanium developer and can be accessed by dot notation.       
//
//  created by : Globallogic
//==========================================================================================
-(TiGeoloqiiOSProxy*)iOS
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    return objiOSProxy;
}

//==========================================================================================
//  Method Name: tracker
//  Return Type: TiGeoloqiLQTrackerProxy*
//  Parameter  : N.A.
//  description: This method will be available as a property to the titanium developer and can be accessed by dot notation.       
//
//  created by : Globallogic
//==========================================================================================
-(TiGeoloqiLQTrackerProxy*)tracker
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    return objLQTracker;
}

//==========================================================================================
//  Method Name: sessionAuthenticated
//  Return Type: void
//  Parameter  : N.A.
//  description: If authenticated session found then init the proxy objects set the tracker profile & save the session       
//
//  created by : Globallogic
//==========================================================================================
-(void) sessionAuthenticated
{
    
    ENSURE_UI_THREAD_1_ARG(nil);

    
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //Initlize the proxy objects
    if (objLQSession==nil)
    {
        objLQSession    =   [[TiGeoloqiLQSessionProxy alloc] init];
    } 
    
    if (objLQTracker == nil)
    {
        objLQTracker = [[TiGeoloqiLQTrackerProxy alloc] init];
    }
    
    if (objiOSProxy == nil)
    {
        objiOSProxy = [[TiGeoloqiiOSProxy alloc] init];
    }
    
    [self.objRequestHelper setObjSession:[LQSession savedSession]];
    [[LQTracker sharedTracker] setSession:[LQSession savedSession]];  
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
    
    [self sessionAuthenticated];
//    if (objLQSession==nil)
//    {
//        objLQSession    =   [[[TiGeoloqiLQSessionProxy alloc] init] autorelease];
//    } 
//    
//    [self.objRequestHelper setObjSession:[LQSession savedSession]];
//    [[LQTracker sharedTracker] setSession:[LQSession savedSession]];        
    
        //else listner will always be passed 
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
    
        //else listner will always be passed 
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
    
    [self validationErrorOccuredWithError:error];
}



#pragma pragma mark-
#pragma mark Future methods, not implemented yet on geoloqi sdk
//==========================================================================================
//  Method Name: isLowBatteryTrackingEnabled:
//  Return Type: BOOL
//  Parameter  : id : args, this will be ignored

//  description: Gets the current value of the low battery tracking preference
//
//  NOTE: THIS METHOD IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(BOOL) isLowBatteryTrackingEnabled:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    return [self.objRequestHelper isLowBatteryTrackingEnabled];  
}

//==========================================================================================
//  Method Name: enableLowBatteryTracking:
//  Return Type: void
//  Parameter  : id : args, this will be ignored

//  description: Should enable low battery tracking preference.
//
//  NOTE: THIS METHOD IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(void) enableLowBatteryTracking:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    [self.objRequestHelper enableLowBatteryTracking];  
}

//==========================================================================================
//  Method Name: disableLowBatteryTracking:
//  Return Type: void
//  Parameter  : id : args, this will be ignored

//  description: Should disable low battery tracking preference.
//
//  NOTE: THIS METHOD IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(void) disableLowBatteryTracking:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    [self.objRequestHelper disableLowBatteryTracking];  
}



@end
