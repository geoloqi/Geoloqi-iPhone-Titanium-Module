/**
 *  RequestHelper.h
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */

#import <Foundation/Foundation.h>

/**
 * Protocol to handle async call to geoloqi server
 */
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

//Properties

/**
 * Request helper property
 */
@property (nonatomic,assign)     id  <RequestHelperDelegate> m_delegate;

/**
 * LQSession object proprty
 */
@property (nonatomic,retain)     LQSession *objSession;

/**
 * Initlizer methods
 */
-(id) initWithDelegate:(id) delegate;

/**
 * Set the API key & secret
 */
-(void) setAPIKey:(NSString *) apiKey secret:(NSString *) apiSecret;

//Async  call to Geoloqi

/**
 * Make the get request to geoloqi server for given api name as strAPIName
 */
-(void) runGetRequestWithAPIName:(NSString *) strAPIName
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError;

/**
 * Make the post request to geoloqi server for given api name as strAPIName
 */
-(void) runPostRequestWithAPIName:(NSString *) strAPIName
                          payload:(id) objPayload
              successEventListner:(id) eventSuccess
                errorEventListner:(id) eventError;

/**
 *  Make the request to geoloqi server for given api name as strAPIName 
 */
-(void) runApiRequestWithAPIName:(NSString *) strAPIName
                      methodName:(NSString *) strMethodName
                         payload:(id) objPayload
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError;

/**
 *  Configure the session for anonymous user
 */
-(void) createAnonymousAccountWithInfo:(NSDictionary *)extraData
                   successEventListner:(id) eventSuccess
                     errorEventListner:(id) eventError;

/**
 *  Configure the session for anonymous user
 */
-(void) createAnonymousAccountWithInfo:(NSDictionary *) extraData
                                   key:(NSString *) key
                              layerIds:(NSArray *) layerIds
                           groupTokens:(NSArray *) groupTokens
                   successEventListner:(id) eventSuccess
                     errorEventListner:(id) eventError;

/**
 *  Configure the session for given username & password
 */
-(void) configureSessionForUserName:(NSString *) userName 
                           password:(NSString *) password
                successEventListner:(id) eventSuccess
                  errorEventListner:(id) eventError;

/**
 *  Create the new accont on the go
 */
-(void) createAccountForUserName:(NSString *) userName 
                        password:(NSString *) password 
                       extraInfo:(NSDictionary *) dictInfo
             successEventListner:(id) eventSuccess
               errorEventListner:(id) eventError;


//LQSession methods

/**
 *  Returns the access token of saved session
 */
-(NSString *) getAccessToken;

/**
 *   Get the session object from access token
 */
-(LQSession *) sessionWithAccessToken:(NSString *) accessToken;

//Utility methods
/**
 *   Utility method: if backslash is not added at api name prefix then append it
 */
-(NSString *) appendSlashPrefixAtApiName:(NSString *) strApiName;

//new methods (SDK version 12.160) 
/**
 *   Returns the user id of authentic user
 */
-(NSString *) getUserID;

//Future methods, not implemented yet on geoloqi sdk

//new methods (SDK version 12.160) 

/**
 *   Returns the user name of authentic user
 */
-(NSString *) getUsername;

/**
 *    Is current session is anonymous
 */
-(BOOL) isAnonymous;

/**
 *    Gets the current value of the low battery tracking preference
 */
-(BOOL) isLowBatteryTrackingEnabled;

/**
 *   Should enable low battery tracking preference
 */
-(void) enableLowBatteryTracking;

/**
 *   Should disable low battery tracking preference
 */
-(void) disableLowBatteryTracking;

@end
