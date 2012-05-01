/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import "TiUtils.h"
#import "RequestHelper.h"

@interface TiGeoloqiLQSessionProxy : TiProxy <RequestHelperDelegate> 
{

}

//Properties
@property (nonatomic,retain)     RequestHelper *objRequestHelper;

//Methods
-(void) authenticateUser:(id) args;
-(void) createAnonymousUserAccount:(id) args;
-(void) createAccountWithUsername:(id) args;

-(void) runAPIRequest:(id) args;
-(void) runGetRequest:(id) args;

-(void) runPostRequestWithJSONObject:(id) args;
-(void) runPostRequestWithJSONArray:(id) args;

-(NSString *) getAccessToken:(id) args;
-(NSString *) accessToken;

-(void) setSavedSession:(id) args;
-(id) savedSession:(id) args;

-(id) sessionWithAccessToken:(id) args;

//-(BOOL) isPushEnabled:(id) args;
//-(void) setPushEnabled:(id) args;

-(void)applicationDidFinishLaunchWithOptions:(id)args;
-(void)registerDeviceToken:(id) args;
-(void)handleDidFailToRegisterForRemoteNotifications:(id) args;
-(void)handlePush:(id) userInfo;

-(TiBlob *)deviceIdentifier;
-(TiBlob *)getDeviceIdentifier:(id)args;

-(void)setDeviceIdentifier:(TiBlob*)args;

-(NSString *)deviceIdentifierHexString;
-(NSString *)getDeviceIdentifierHexString:(id)args;

-(void)registerForPushNotificationsWithCallback:(id)args;

-(BOOL)pushAlertsEnabled:(id)args;
-(BOOL)pushSoundsEnabled:(id)args;
-(BOOL)pushBadgesEnabled:(id)args;

-(NSString *) getUserID:(id) args;

@end
