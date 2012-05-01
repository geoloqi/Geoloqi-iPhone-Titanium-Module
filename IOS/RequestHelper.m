//
//  RequestHelper.m
//  geoloqimodule
//
//  Created by globallogic on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RequestHelper.h"
#import "TiGeoloqiModule.h"

@implementation RequestHelper

@synthesize m_delegate;
@synthesize objSession;

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
        m_delegate  =   delegate;
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
    if (objSession==nil)
    {
         NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE 
                                              description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                   method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithError:error eventListner:eventError];
        return;
    }
       
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];

    NSLog(objSession.accessToken);
    
    NSURLRequest *req = [objSession requestWithMethod:CONST_GEOLOQI_SERVICE_REQUEST_GET path:strAPIName payload:nil];
    
    [objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {

        NSLog(@"Response: %@ error:%@", responseDictionary, error);
        
        if(error) 
        {
            NSLog(@"makeRequest:[ERROR] %@",[error localizedDescription]);
            [m_delegate requestCompleteWithError:error eventListner:eventError];
            // [self fireEvent:@"requestFailed" withObject:[self getDictionaryFromErrorObject:error]];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary eventListner:eventSuccess];
            //[self fireEvent:@"requestCompleted" withObject:responseDictionary];
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

//  description: Make the get request to geoloqi server for given api name as strAPIName        
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
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithError:error eventListner:eventError];
        return;
    }
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];
    
    NSURLRequest *req = [objSession requestWithMethod:CONST_GEOLOQI_SERVICE_REQUEST_POST path:strAPIName payload:objPayload];
    
    [objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        
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
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithError:error eventListner:eventError];
        return;
    }
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];
    
    NSURLRequest *req = [objSession requestWithMethod:strMethodName path:strAPIName payload:objPayload];
    
    [objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        
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
             NSLog(@"[DEBUG]: SET SAVED SESSION %@",session.description);
             
             [self setObjSession:session];
             [m_delegate requestCompleteWithSuccess:nil eventListner:eventSuccess];
         } 
         else 
         {
             NSLog(@"setSessionForGivenUserName:[ERROR] %@",[error localizedDescription]);
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
              NSLog(@"[DEBUG]: SET SAVED SESSION");
             [self setObjSession:session];
              //[LQSession setSavedSession:session];
              [m_delegate requestCompleteWithSuccess:nil eventListner:eventSuccess];
          }
          else
          {
              NSLog(@"createAnonymousAccountWithInfo:[ERROR] %@",[error localizedDescription]);
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
             [self setObjSession:session];
             [m_delegate requestCompleteWithSuccess:nil eventListner:eventSuccess];
         } 
         else 
         {
             [m_delegate requestCompleteWithError:error eventListner:eventError];
         }
     }];
}


////==========================================================================================
////  Method Name: isPushEnabled
////  Return Type: BOOL
////  Parameter  : N.A.
//
////  description: Check if APN is Enabled
////
////  created by : Globallogic
////==========================================================================================
//-(BOOL) isPushEnabled
//{
//    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
//    {
//        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
//    }
//
//    //INVERT THE VALUE AS IOS PROVIDE THE FUNCTION pushDisabled RATHER THEN isPushEnabled
//    BOOL bPushEnabled   =      !([LQSession pushDisabled]);
//    return bPushEnabled;    
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
//-(void) setPushEnabled:(BOOL) bPushEnable
//{
//    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
//    {
//        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
//    }
//
//    [LQSession setPushDisabled:!(bPushEnable)];
//}


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

    return [Utils nilObjectToBlankString:[objSession accessToken]];
}

//==========================================================================================
//  Method Name: setSavedSession:
//  Return Type: void
//  Parameter  : LQSession: session

//  description: set the session object
//
//  created by : Globallogic
//==========================================================================================
-(void) setSavedSession:(LQSession *) session
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    

    [LQSession setSavedSession:session];
}

//==========================================================================================
//  Method Name: savedSession:
//  Return Type: LQSession
//  Parameter  : 

//  description: get the session object
//
//  created by : Globallogic
//==========================================================================================
-(LQSession *) savedSession
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:CONST_GEOLOQI_VALIDATION_NO_SESSION_CODE 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        return nil;
    }

    return objSession;
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

#pragma mark -
#pragma mark APN Related methods
//==========================================================================================
//  Method Name: registerForPushNotificationsWithSuccessEventListner: errorEventListner:
//  Return Type: void
//  Parameter  : N.A. 
//  description: Regeister for apple push notification        
//
//  created by : Globallogic
//==========================================================================================
-(void) registerForPushNotificationsWithSuccessEventListner:(id) eventSuccess
                                          errorEventListner:(id) eventError

{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    [LQSession registerForPushNotificationsWithCallback:^(NSData *deviceToken, NSError *error) 
    {
        if(error)
        {
            [m_delegate requestCompleteWithError:error eventListner:eventError];
        }
        else
        {
            NSString *strDeviceToken            =   [NSString stringWithFormat:@"%@",deviceToken];
            NSDictionary *responseDictionary    =  [NSDictionary dictionaryWithObject:strDeviceToken forKey:CONST_DEVICE_TOKEN];
            [m_delegate requestCompleteWithSuccess:responseDictionary eventListner:eventSuccess];
        }
    }];
}

//==========================================================================================
//  Method Name: applicationDidFinish: WithLaunchOptions:
//  Return Type: void
//  Parameter  : UIApplication : applictionObject
//               id            : launchOptions
//
//  description: Need to be set while initilize        
//
//  created by : Globallogic
//==========================================================================================
-(void) applicationDidFinish:(UIApplication *) applictionObject WithLaunchOptions:(id) launchOptions
{
    [LQSession application:applictionObject didFinishLaunchingWithOptions:launchOptions];
}

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
-(NSString *) getUserID
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    
    return [self.objSession userID];
}

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

    NSLog(@"RequestHelper::dealloc called");            
    m_delegate = nil;
    
//    [objSession release];
//    objSession  =   nil;
    
    [super dealloc];
}

@end
