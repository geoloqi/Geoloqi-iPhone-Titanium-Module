//
//  RequestHelper.h
//  geoloqimodule
//
//  Created by globallogic on 06/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestHelperDelegate 
@required
-(void) requestCompleteWithSuccess:(NSDictionary *) responseDictionary;
-(void) requestCompleteWithError:(NSError *) error;
-(void) requestCompleteWithValidationError:(NSError *) error;

@optional
-(void) serviceStartedSuccessFully;

@end

@interface RequestHelper : NSObject
{
    id  <RequestHelperDelegate> m_delegate;
    LQSession *objSession;
}

@property (nonatomic,retain)     id  <RequestHelperDelegate> m_delegate;

@property (nonatomic,retain)  LQSession *objSession;

-(id) initWithDelegate:(id) delegate;

-(void) runGetRequestWithAPIName:(NSString *) strAPIName;

-(void) runGetRequestWithAPIName:(NSString *) strAPIName
                      methodName:(NSString *) strMethodName
                  extraParameter:(NSString *) strId; 

-(void) runPostRequestWithAPIName:(NSString *) strAPIName
                         payload:(id) objPayload;

-(void) runPostRequestWithAPIName:(NSString *) strAPIName
                       methodName:(NSString *) strMethodName
                          payload:(id) objPayload
                   extraParameter:(NSString *) strId; 

-(void) runApiRequestWithAPIName:(NSString *) strAPIName
                      methodName:(NSString *) strMethodName
                         payload:(id) objPayload;

-(void) setAPIKey:(NSString *) apiKey secret:(NSString *) apiSecret;

-(void) createAnonymousAccountWithInfo:(NSDictionary *) object;
-(void) configureSessionForUserName:(NSString *) userName password:(NSString *) password;
-(void) createAccountForUserName:(NSString *) userName password:(NSString *) password 
                       extraInfo:(NSDictionary *) dictInfo;

-(BOOL) isPushEnabled;
-(void) setPushEnabled:(BOOL) bPushEnable;

-(NSString *) getAccessToken;

-(void) setSavedSession:(LQSession *) session;
-(LQSession *) savedSession;

-(LQSession *) sessionWithAccessToken:(NSString *) accessToken;

-(NSString *) appendSlashPrefixAtApiName:(NSString *) strApiName;

@end
