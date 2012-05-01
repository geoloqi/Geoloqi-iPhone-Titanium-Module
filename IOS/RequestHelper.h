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
-(void) requestCompleteWithSuccess:(NSDictionary *) responseDictionary eventListner:(id) listner;
-(void) requestCompleteWithError:(NSError *) error eventListner:(id) listner;
-(void) requestCompleteWithValidationError:(NSError *) error;
@end

@interface RequestHelper : NSObject
{
    id  <RequestHelperDelegate> m_delegate;
    LQSession *objSession;
}

@property (nonatomic,retain)     id  <RequestHelperDelegate> m_delegate;

@property (nonatomic,retain)  LQSession *objSession;

-(id) initWithDelegate:(id) delegate;

-(void) setAPIKey:(NSString *) apiKey secret:(NSString *) apiSecret;

-(void) runGetRequestWithAPIName:(NSString *) strAPIName
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError;


-(void) runPostRequestWithAPIName:(NSString *) strAPIName
                          payload:(id) objPayload
              successEventListner:(id) eventSuccess
                errorEventListner:(id) eventError;

-(void) runApiRequestWithAPIName:(NSString *) strAPIName
                      methodName:(NSString *) strMethodName
                         payload:(id) objPayload
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError;

-(void) createAnonymousAccountWithInfo:(NSDictionary *) object
                   successEventListner:(id) eventSuccess
                     errorEventListner:(id) eventError;

-(void) configureSessionForUserName:(NSString *) userName 
                           password:(NSString *) password
                successEventListner:(id) eventSuccess
                  errorEventListner:(id) eventError;

-(void) createAccountForUserName:(NSString *) userName 
                        password:(NSString *) password 
                       extraInfo:(NSDictionary *) dictInfo
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError;

//-(BOOL) isPushEnabled;
//-(void) setPushEnabled:(BOOL) bPushEnable;

-(NSString *) getAccessToken;

-(void) setSavedSession:(LQSession *) session;
-(LQSession *) savedSession;

-(LQSession *) sessionWithAccessToken:(NSString *) accessToken;

-(NSString *) appendSlashPrefixAtApiName:(NSString *) strApiName;

-(void) registerForPushNotificationsWithSuccessEventListner:(id) eventSuccess
                                          errorEventListner:(id) eventError;

-(void) applicationDidFinish:(UIApplication *) applictionObject WithLaunchOptions:(id) launchOptions;

-(NSString *) getUserID;

@end
