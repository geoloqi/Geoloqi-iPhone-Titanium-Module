/**
 *   TiGeoloqiLQSessionProxy.m
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
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
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if (self=[super init])
    {
//        if (self.objRequestHelper!=nil)
//        {
//            RELEASE_TO_NIL(self.objRequestHelper);
//        }
        
        RequestHelper *objReqHelper   =   [[RequestHelper alloc] initWithDelegate:self];   
        self.objRequestHelper         =   objReqHelper;
        
        [objReqHelper release];
        objReqHelper    =   nil;
    }
   
    return self;
}


////==========================================================================================
////  Method Name: getAccessToken:
////  Return Type: NSString
////  Parameter  : id: args
//
////  description: Returns the access token of saved session
////
////  created by : Globallogic
////==========================================================================================
//-(NSString *) getAccessToken:(id) args
//{
//    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
//    {
//        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
//    }
//
//    
//    return [self.objRequestHelper getAccessToken];
//}
//
////==========================================================================================
////  Method Name: accessToken: (Exposed as property)
////  Return Type: NSString
////  Parameter  : id: args
//
////  description: Returns the access token of saved session
////
////  created by : Globallogic
////==========================================================================================
//-(NSString *) accessToken
//{
//    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
//    {
//        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
//    }
//    
//    
//     return [self.objRequestHelper getAccessToken];
//}





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

    //SET THE DELEGATE OBJECT TO NIL TO PREVENT THE CRASH
    //self.objRequestHelper.m_delegate    =   nil;
    RELEASE_TO_NIL(self.objRequestHelper);
    
    [super dealloc];
}

#pragma mark-
#pragma mark new methods (SDK version 12.160) 

//==========================================================================================
//  Method Name: getUserId:
//  Return Type: NSString
//  Parameter  : id: args, this value will be ignored

//  description: Returns the user id of authentic user
//
//  created by : Globallogic
//==========================================================================================
-(NSString *) getUserId:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    return [self.objRequestHelper getUserID];
}


#pragma pragma mark-
#pragma mark Future methods, not implemented yet on geoloqi sdk
//==========================================================================================
//  Method Name: getUsername:
//  Return Type: NSString
//  Parameter  : id: args, this value will be ignored

//  description: Returns the user name of authentic user
//
//  NOTE: THIS PROPERTY IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(NSString *) getUsername:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    return [self.objRequestHelper getUsername];  
}

//==========================================================================================
//  Method Name: isAnonymous:
//  Return Type: BOOL
//  Parameter  : id : args

//  description: Is current session is anonymous
//
//  NOTE: THIS PROPERTY IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(BOOL) isAnonymous:(id) args
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    return [self.objRequestHelper isAnonymous];  
}


#pragma pragma mark-
#pragma mark Geoloqi sync request
 //==========================================================================================
 //  Method Name: apiRequest:
 //  Return Type: void
 //  Parameter  : id: args
 
 //  description: Make the request to geoloqi server
 //
 //  created by : Globallogic
 //==========================================================================================
 -(void) apiRequest:(id) args
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
        NSString     *strHttpVerb       =   [TiUtils stringValue:[args objectAtIndex:0]];
        NSString     *strApiName        =   [TiUtils stringValue:[args objectAtIndex:1]];
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
 //  Method Name: getRequest:
 //  Return Type: void
 //  Parameter  : id: args
 
 //  description: Make the GET request to geoloqi server
 //
 //  created by : Globallogic
 //==========================================================================================
 -(void) getRequest:(id) args
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
         
         return;
         
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
         
         
         //Convert the passed json to query string
         NSString *strQueryString   =   [Utils convertTheJsonObjectToqueryString:dictExtraInfo];
         
         NSLog(@"Query String is: %@",strQueryString);
         
         if (![strQueryString isEqualToString:CONST_EMPTY_STRING])
         {
             //Append the query string to api path 
             strQueryString =   [NSString stringWithFormat:@"%@?%@",strApiName,strQueryString];
         }
         else
         {
             strQueryString =   strApiName;
         }
         
         NSLog(@"Complete Query String is: %@",strQueryString);
         
         //Url Encode the query string before passing it to server
         
         [self.objRequestHelper runGetRequestWithAPIName:strQueryString 
         successEventListner:success 
         errorEventListner:error];
     }
 }
 
 //==========================================================================================
 //  Method Name: postRequest:
 //  Return Type: void
 //  Parameter  : id: args, args can be either json array or json object
 
 //  description: Make the POST request to geoloqi server
 //
 //  created by : Globallogic
 //==========================================================================================
 -(void) postRequest:(id) args
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




@end
