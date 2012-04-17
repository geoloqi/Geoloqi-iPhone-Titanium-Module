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
//  created by : Tarun Sharma
//  created on : 06/04/2012
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
//  created by : Tarun Sharma
//  created on : 06/04/2012
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
//  Method Name: runGetRequestWithAPIName: methodName
//  Return Type: void
//  Parameter  : NSString: strAPIName
//               NSString: strMethodName
//
//  description: Make the get request to geoloqi server for given api name as strAPIName        
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================

-(void) runGetRequestWithAPIName:(NSString *) strAPIName
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (objSession==nil)
    {
         NSError *error =   [Utils getErrorObjectWithCode:111 
                                              description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                   method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
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
            [m_delegate requestCompleteWithError:error];
            // [self fireEvent:@"requestFailed" withObject:[self getDictionaryFromErrorObject:error]];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary];
            //[self fireEvent:@"requestCompleted" withObject:responseDictionary];
        }
	}];
}

//==========================================================================================
//  Method Name: runGetRequestWithAPIName: methodName
//  Return Type: void
//  Parameter  : NSString: strAPIName
//               NSString: strMethodName
//
//  description: Make the get request to geoloqi server for given api name as strAPIName        
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) runGetRequestWithAPIName:(NSString *) strAPIName
                      methodName:(NSString *) strMethodName
                  extraParameter:(NSString *) strId 
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:111 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        return;
    }
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];
    
    NSURLRequest *req = [objSession requestWithMethod:CONST_GEOLOQI_SERVICE_REQUEST_GET path:[NSString stringWithFormat:@"%@:%@",strAPIName,strId] payload:nil];
    
    [objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        
        NSLog(@"Response: %@ error:%@", responseDictionary, error);
        
        if(error) 
        {
            NSLog(@"makeRequest:[ERROR] %@",[error localizedDescription]);
            [m_delegate requestCompleteWithError:error];
            // [self fireEvent:@"requestFailed" withObject:[self getDictionaryFromErrorObject:error]];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary];
            //[self fireEvent:@"requestCompleted" withObject:responseDictionary];
        }
	}];
}

//==========================================================================================
//  Method Name: runPostRequestWithAPIName: methodName : payload
//  Return Type: void
//  Parameter  : NSString: strAPIName
//               NSString: strMethodName
//               id      : objPayload   
//  description: Make the get request to geoloqi server for given api name as strAPIName        
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================

-(void) runPostRequestWithAPIName:(NSString *) strAPIName
                          payload:(id) objPayload
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:111 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        return;
    }
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];
    
    NSURLRequest *req = [objSession requestWithMethod:CONST_GEOLOQI_SERVICE_REQUEST_POST path:strAPIName payload:objPayload];
    
    [objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        
        NSLog(@"Response: %@ error:%@", responseDictionary, error);
        
        if(error) 
        {
            NSLog(@"makeRequest:[ERROR] %@",[error localizedDescription]);
            [m_delegate requestCompleteWithError:error];
            // [self fireEvent:@"requestFailed" withObject:[self getDictionaryFromErrorObject:error]];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary];
            //[self fireEvent:@"requestCompleted" withObject:responseDictionary];
        }
	}];
}

//==========================================================================================
//  Method Name: runPostRequestWithAPIName: methodName : payload
//  Return Type: void
//  Parameter  : NSString: strAPIName
//               NSString: strMethodName
//               id      : objPayload   
//               NSString:strId
//  description: Make the get request to geoloqi server for given api name as strAPIName        
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) runPostRequestWithAPIName:(NSString *) strAPIName
                       methodName:(NSString *) strMethodName
                          payload:(id) objPayload
                   extraParameter:(NSString *) strId  
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:111 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        return;
    }
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];
    
    NSURLRequest *req = [objSession requestWithMethod:CONST_GEOLOQI_SERVICE_REQUEST_POST path:[NSString stringWithFormat:@"%@:%@",strAPIName,strId] payload:objPayload];
    
    [objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        
        NSLog(@"Response: %@ error:%@", responseDictionary, error);
        
        if(error) 
        {
            NSLog(@"makeRequest:[ERROR] %@",[error localizedDescription]);
            [m_delegate requestCompleteWithError:error];
            // [self fireEvent:@"requestFailed" withObject:[self getDictionaryFromErrorObject:error]];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary];
            //[self fireEvent:@"requestCompleted" withObject:responseDictionary];
        }
	}];
    
}

//==========================================================================================
//  Method Name: runApiRequestWithAPIName: methodName : payload
//  Return Type: void
//  Parameter  : NSString: strAPIName
//               NSString: strMethodName
//               id      : objPayload   
//  description: Make the request to geoloqi server for given api name as strAPIName        
//
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(void) runApiRequestWithAPIName:(NSString *) strAPIName
                       methodName:(NSString *) strMethodName
                          payload:(id) objPayload
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:111 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithValidationError:error];
        return;
    }
    
    strAPIName  =   [self appendSlashPrefixAtApiName:strAPIName];
    
    NSURLRequest *req = [objSession requestWithMethod:CONST_GEOLOQI_SERVICE_REQUEST_POST path:strAPIName payload:objPayload];
    
    [objSession runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
        
        NSLog(@"Response: %@ error:%@", responseDictionary, error);
        
        if(error) 
        {
            NSLog(@"makeRequest:[ERROR] %@",[error localizedDescription]);
            [m_delegate requestCompleteWithError:error];
            // [self fireEvent:@"requestFailed" withObject:[self getDictionaryFromErrorObject:error]];
        }
        else
        {
            [m_delegate requestCompleteWithSuccess:responseDictionary];
            //[self fireEvent:@"requestCompleted" withObject:responseDictionary];
        }
	}];
}

//==========================================================================================
//  Method Name: configureSessionForUserName: password
//  Return Type: void
//  Parameter  : NSString: userName
//               NSString: password

//  description: Configure the session for given username & password. All the webservices will be 
//               called on behalf of that user
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) configureSessionForUserName:(NSString *) userName password:(NSString *) password
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
             //[LQSession setSavedSession:session];
             //[m_delegate sessionAuthenicatedSuccessFullyWithUserName:userName];
             [m_delegate serviceStartedSuccessFully];
             //[self fireEvent:@"sessionInitlized" withObject:nil];
             //             [self fireEvent:@"requestCompleted" withObject:[self makeRequest]];
         } 
         else 
         {
             if (error==nil)
             {
                error =  [Utils getErrorObjectWithCode:111 description:@"Invalid username or password"
                                                method:CONST_EMPTY_STRING];
             }
                 
             NSLog(@"setSessionForGivenUserName:[ERROR] %@",[error localizedDescription]);
             [m_delegate requestCompleteWithError:error];
             //[self fireEvent:@"requestFailed" withObject:[error localizedDescription]];
         }
     }];
}

//==========================================================================================
//  Method Name: configureAnonymousAccount
//  Return Type: void
//  Parameter  : 

//  description: Configure the session for anonymous user
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) createAnonymousAccountWithInfo:(NSDictionary *) object
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
              [m_delegate serviceStartedSuccessFully];
          }
          else
          {
              NSLog(@"createAnonymousAccountWithInfo:[ERROR] %@",[error localizedDescription]);
              [m_delegate requestCompleteWithError:error];
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
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(void) createAccountForUserName:(NSString *) userName password:(NSString *) password 
                       extraInfo:(NSDictionary *) dictInfo
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
             NSLog(@"[DEBUG]: SET SAVED SESSION %@",session.description);
             
             [self setObjSession:session];
             //[LQSession setSavedSession:session];
             [m_delegate serviceStartedSuccessFully];
         } 
         else 
         {
             NSLog(@"setSessionForGivenUserName:[ERROR] %@",[error localizedDescription]);
             [m_delegate requestCompleteWithError:error];
         }
     }];
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
-(BOOL) isPushEnabled
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    //INVERT THE VALUE AS IOS PROVIDE THE FUNCTION pushDisabled RATHER THEN isPushEnabled
    BOOL bPushEnabled   =      !([LQSession pushDisabled]);
    return bPushEnabled;    
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
-(void) setPushEnabled:(BOOL) bPushEnable
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    [LQSession setPushDisabled:!(bPushEnable)];
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
-(NSString *) getAccessToken
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    //IF NO SESSION IS AVAILABE THEN THROW VALIDATION ERROR
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:111 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithError:error];
        return CONST_EMPTY_STRING;
    }

   return [objSession accessToken];
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
//  created by : Tarun Sharma
//  created on : 13/04/2012
//==========================================================================================
-(LQSession *) savedSession
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }
    
    if (objSession==nil)
    {
        NSError *error =   [Utils getErrorObjectWithCode:111 
                                             description:CONST_GEOLOQI_VALIDATION_NO_SESSION
                                                  method:CONST_EMPTY_STRING];
        
        [m_delegate requestCompleteWithError:error];
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
//  created by : Tarun Sharma
//  created on : 16/04/2012
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
//  created by : Tarun Sharma
//  created on : 17/04/2012
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


//==========================================================================================
//  Method Name: dealloc
//  Return Type: void
//  Parameter  : N.A. 
//  description: release memory resources        
//
//  created by : Tarun Sharma
//  created on : 06/04/2012
//==========================================================================================
-(void) dealloc
{
    if ([[TiGeoloqiModule getCurrentObject] isDebugOn])
    {
        [Utils printLogWithClassName:NSStringFromClass([self class]) message:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    }

    NSLog(@"RequestHelper::dealloc called");            
    m_delegate = nil;
    
    [objSession release];
    objSession  =   nil;
    
    [super dealloc];
}

@end
