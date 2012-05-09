/**
 *  RequestHelper.m
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */

#import "RequestHelper.h"
#import "TiGeoloqiModule.h"

@implementation RequestHelper

#pragma mark-
#pragma mark Properties
@synthesize m_delegate;
@synthesize objSession;

#pragma mark-
#pragma mark Initlizer methods
//==========================================================================================
//  Method Name: initWithDelegate
//  Return Type: id
//  Parameter  : id: delegate 
//  description: initlize with delegate         
//
//  created by : Globallogic
//==========================================================================================
-(id) initWithDelegate:(id) delegate
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    if(self = [super init])
    {
        [self setM_delegate:delegate];
        [self setObjSession:[LQSession savedSession]];
    }
        
    return self;
}

//==========================================================================================
//  Method Name: setAPIKey: secret
//  Return Type: void
//  Parameter  : NSString: apiKey
//               NSString: apiSecret

//  description: Set the API key & secret         
//
//  created by : Globallogic
//==========================================================================================
-(void) setAPIKey:(NSString *) apiKey secret:(NSString *) apiSecret
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

     [LQSession setAPIKey:apiKey secret:apiSecret];   
}


#pragma mark-
#pragma mark Async  call to Geoloqi
//==========================================================================================
//  Method Name: runGetRequestWithAPIName: successEventListner: errorEventListner:
//  Return Type: void
//  Parameter  : NSString: strAPIName
//               NSString: strMethodName
//               id      : eventSuccess
//               id      : eventError   
//
//  description: Make the get request to geoloqi server for given api name as strAPIName        
//
//  created by : Globallogic
//==========================================================================================
-(void) runGetRequestWithAPIName:(NSString *) strAPIName
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (self.objSession==nil)
    {
         NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE 
                                              description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                   method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithError:error eventListner:eventError];
        return;
    }
       
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];

    NSLog(self.objSession.accessToken);
    
    NSURLRequest *req = [self.objSession requestWithMethod:CONST_GEOLOQI_SERVICE_REQUEST_GET path:strAPIName payload:nil];
    
    [self.objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {

        NSLog(@"Response: %@ error:%@", responseDictionary, error);
        
        if(error) 
        {
            NSLog(@"makeRequest:[ERROR] %@",[error localizedDescription]);
            [m_delegate requestCompleteWithError:error eventListner:eventError];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary eventListner:eventSuccess];
        }
	}];
}


//==========================================================================================
//  Method Name: runPostRequestWithAPIName: payload: successEventListner: errorEventListner:
//  Return Type: void
//  Parameter  : NSString: strAPIName
//               id      : objPayload  
//               id      : eventSuccess
//               id      : eventError   

//  description: Make the post request to geoloqi server for given api name as strAPIName        
//
//  created by : Globallogic
//==========================================================================================
-(void) runPostRequestWithAPIName:(NSString *) strAPIName
                          payload:(id) objPayload
              successEventListner:(id) eventSuccess
                errorEventListner:(id) eventError

{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (self.objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithError:error eventListner:eventError];
        return;
    }
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];
    
    NSURLRequest *req = [self.objSession requestWithMethod:CONST_GEOLOQI_SERVICE_REQUEST_POST path:strAPIName payload:objPayload];
    
    [self.objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        
        NSLog(@"Response: %@ error:%@", responseDictionary, error);
        
        if(error) 
        {
            NSLog(@"makeRequest:[ERROR] %@",[error localizedDescription]);
            [m_delegate requestCompleteWithError:error eventListner:eventError];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary eventListner:eventSuccess];
        }
	}];
}


//=================================================================================================================
//  Method Name: runApiRequestWithAPIName: methodName : payload: successEventListner: errorEventListner:
//  Return Type: void
//  Parameter  : NSString: strAPIName
//               NSString: strMethodName
//               id      : objPayload  
//               id      : eventSuccess
//               id      : eventError   

//  description: Make the request to geoloqi server for given api name as strAPIName        
//
//  created by : Globallogic
//=================================================================================================================
-(void) runApiRequestWithAPIName:(NSString *) strAPIName
                       methodName:(NSString *) strMethodName
                          payload:(id) objPayload
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (self.objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithError:error eventListner:eventError];
        return;
    }
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];
    
    NSURLRequest *req = [self.objSession requestWithMethod:strMethodName path:strAPIName payload:objPayload];
    
    [self.objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        
        if(error) 
        {
            NSLog(@"makeRequest:[ERROR] %@",[error localizedDescription]);
            [m_delegate requestCompleteWithError:error eventListner:eventError];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary eventListner:eventSuccess];
        }
	}];
}

//===========================================================================================================
//  Method Name: configureSessionForUserName: password: successEventListner: errorEventListner:
//  Return Type: void
//  Parameter  : NSString: userName
//               NSString: password
//               id      : eventSuccess
//               id      : eventError   


//  description: Configure the session for given username & password. All the webservices will be 
//               called on behalf of that user
//
//  created by : Globallogic
//===========================================================================================================
-(void) configureSessionForUserName:(NSString *) userName 
                           password:(NSString *) password
                successEventListner:(id) eventSuccess
                  errorEventListner:(id) eventError
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    [LQSession requestSessionWithUsername:userName
                                 password:password
                               completion:^(LQSession *session , NSError *error ) 
     {
         if(session.accessToken) 
         {
             [LQSession setSavedSession:session];
             [self setObjSession:session];
             [m_delegate requestCompleteWithSuccess:nil eventListner:eventSuccess];
         } 
         else 
         {
             [m_delegate requestCompleteWithError:error eventListner:eventError];
         }
     }];
}

//==========================================================================================
//  Method Name: configureAnonymousAccount: successEventListner: errorEventListner:
//  Return Type: void
//  Parameter  : id      : eventSuccess
//               id      : eventError  

//  description: Configure the session for anonymous user
//
//  created by : Globallogic
//==========================================================================================
-(void) createAnonymousAccountWithInfo:(NSDictionary *) object
                   successEventListner:(id) eventSuccess
                     errorEventListner:(id) eventError

{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    [LQSession createAnonymousUserAccountWithUserInfo:object
                                            completion:^(LQSession *session , NSError *error ) 
      {
          if(session.accessToken) 
          {
             [LQSession setSavedSession:session];
             [self setObjSession:session];
             [m_delegate requestCompleteWithSuccess:nil eventListner:eventSuccess];
          }
          else
          {
              NSLog(@"createAnonymousAccountWithInfo %@",[error localizedDescription]);
              [m_delegate requestCompleteWithError:error eventListner:eventError];
          }
      }];
}

//==========================================================================================
//  Method Name: createAccountForUserName: password: extraInfo
//  Return Type: void
//  Parameter  : NSString       : userName
//               NSString       : password
//               NSDictionary   : dictInfo

//  description: create the new accont on the go
//
//  created by : Globallogic
//==========================================================================================
-(void) createAccountForUserName:(NSString *) userName 
                        password:(NSString *) password 
                       extraInfo:(NSDictionary *) dictInfo
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    [LQSession createAccountWithUsername:userName
                                 password:password
                                    extra:dictInfo
                               completion:^(LQSession *session , NSError *error ) 
     {
         
         if(session.accessToken) 
         {
             [LQSession setSavedSession:session];             
             [self setObjSession:session];
             [m_delegate requestCompleteWithSuccess:nil eventListner:eventSuccess];
         } 
         else 
         {
             [m_delegate requestCompleteWithError:error eventListner:eventError];
         }
     }];
}

#pragma mark-
#pragma mark LQSession methods
//==========================================================================================
//  Method Name: getAccessToken:
//  Return Type: NSString
//  Parameter  : id: args

//  description: Returns the access token of saved session
//
//  created by : Globallogic
//==========================================================================================
-(NSString *) getAccessToken
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    return [Utils nilObjectToBlankString:[self.objSession accessToken]];
}

//==========================================================================================
//  Method Name: sessionWithAccessToken:
//  Return Type: id
//  Parameter  : NSString: accessToken

//  description: get the session object from access token
//
//  created by : Globallogic
//==========================================================================================
-(LQSession *) sessionWithAccessToken:(NSString *) accessToken
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    [LQSession sessionWithAccessToken:accessToken];
}

#pragma mark-
#pragma mark Utility methods
//==========================================================================================
//  Method Name: appendSlashPrefixAtApiName:
//  Return Type: NSString
//  Parameter  : NSString: strApiName

//  description: if / is not added at api name prefix then append it
//
//  created by : Globallogic
//==========================================================================================
-(NSString *) appendSlashPrefixAtApiName:(NSString *) strApiName
{
    NSString *strSlash   =   [strApiName substringToIndex:1];
    
    if (![strSlash isEqualToString:@"/"])
    {
        strApiName      =   [NSString stringWithFormat:@"/%@",strApiName];
    }
    
    return strApiName;
}

#pragma mark-
#pragma mark new methods (SDK version 12.160) 

//==========================================================================================
//  Method Name: getUserID:
//  Return Type: NSString
//  Parameter  : N.A.

//  description: Returns the user id of authentic user
//
//  created by : Globallogic
//==========================================================================================
-(NSString *) getUserID
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    return [self.objSession userID];
}

#pragma pragma mark-
#pragma mark Future methods, not implemented yet on geoloqi sdk

//==========================================================================================
//  Method Name: getUsername:
//  Return Type: NSString
//  Parameter  : N.A.

//  description: Returns the user name of authentic user
//
//  NOTE: THIS PROPERTY IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(NSString *) getUsername
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    NSString *username    =   CONST_EMPTY_STRING;
    
    @try 
    {
        username =   [self.objSession username]; 
    }
    @catch (NSException *exception) 
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_METHOD_CALL 
                                             description:[exception reason]
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        
    }
    
    return username;
}


//==========================================================================================
//  Method Name: isAnonymous:
//  Return Type: BOOL
//  Parameter  : N.A.

//  description: Is current session is anonymous
//
//  NOTE: THIS PROPERTY IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(BOOL) isAnonymous
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    BOOL isAnonymous    =   NO;
    
    @try 
    {
        isAnonymous =   [self.objSession isAnonymous]; 
    }
    @catch (NSException *exception) 
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_METHOD_CALL 
                                             description:[exception reason]
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        
    }
    
    return isAnonymous;
}

//==========================================================================================
//  Method Name: isLowBatteryTrackingEnabled:
//  Return Type: BOOL
//  Parameter  : N.A.

//  description: Gets the current value of the low battery tracking preference
//
//  NOTE: THIS METHOD IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(BOOL) isLowBatteryTrackingEnabled
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    BOOL isLowBatteryTrackingEnabled    =   NO;
    
    @try 
    {
        isLowBatteryTrackingEnabled =   [self.objSession isLowBatteryTrackingEnabled]; 
    }
    @catch (NSException *exception) 
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_METHOD_CALL 
                                             description:[exception reason]
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];

    }
    
    return isLowBatteryTrackingEnabled;
}

//==========================================================================================
//  Method Name: enableLowBatteryTracking:
//  Return Type: void
//  Parameter  : N.A.

//  description: Should enable low battery tracking preference.
//
//  NOTE: THIS METHOD IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(void) enableLowBatteryTracking
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    @try 
    {
        [self.objSession enableLowBatteryTracking]; 
    }
    @catch (NSException *exception) 
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_METHOD_CALL 
                                             description:[exception reason]
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        
    }
}

//==========================================================================================
//  Method Name: disableLowBatteryTracking:
//  Return Type: void
//  Parameter  : N.A.

//  description: Should disable low battery tracking preference.
//
//  NOTE: THIS METHOD IS NOT EXPOSED BY GEOLOQI SDK YET 
//  created by : Globallogic
//==========================================================================================
-(void) disableLowBatteryTracking
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    @try 
    {
        [self.objSession disableLowBatteryTracking]; 
    }
    @catch (NSException *exception) 
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_INVALID_METHOD_CALL 
                                             description:[exception reason]
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        
    }
}

#pragma pragma mark-
#pragma mark Memory managment methods

//==========================================================================================
//  Method Name: dealloc
//  Return Type: void
//  Parameter  : N.A. 
//  description: release memory resources        
//
//  created by : Globallogic
//==========================================================================================
-(void) dealloc
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    RELEASE_TO_NIL(self.objSession);
        
    [super dealloc];
}

@end
