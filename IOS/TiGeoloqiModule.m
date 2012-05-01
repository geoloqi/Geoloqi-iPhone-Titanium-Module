/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiGeoloqiModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiGeoloqiLQSessionProxy.h"
#import <TiApp.h>

static  TiGeoloqiModule *currentObject  =   nil;


@implementation TiGeoloqiModule

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
    currentObject   =   self;
    [LQSession application:(UIApplication*)[TiApp app] didFinishLaunchingWithOptions:[[TiApp app] launchOptions]];
    
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
    RELEASE_TO_NIL(LQTrackerProxyObj);
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
    
    if ([name isEqualToString:@"createLQSession"])
    {
        if (args && evaluator)
        {
            return [[[TiGeoloqiLQSessionProxy alloc] _initWithPageContext:evaluator args:args] autorelease];
        }
        else if (evaluator)
        {
            return [[[TiGeoloqiLQSessionProxy alloc] _initWithPageContext:evaluator] autorelease];            
        }
        else
        {
            return [[[TiGeoloqiLQSessionProxy alloc] init] autorelease];
        }
    }
    else
    {
        NSLog(@"[ERROR]: Proxy Creation for %@ is not supported",name);
    }
}

//==========================================================================================
//  Method Name: getLQTracker
//  Return Type: id
//  Parameter  : N.A.

//  description: LQTracker class getter Method.

//  created by : Globallogic
//==========================================================================================
-(id)getLQTracker:(id) args
{

    
    if (LQTrackerProxyObj == nil) {
        
        LQTrackerProxyObj = [[TiGeoloqiLQTrackerProxy alloc]init];
    }
    return LQTrackerProxyObj;
}

//==========================================================================================
//  Method Name: LQTracker
//  Return Type: id
//  Parameter  : N.A.

//  description: LQTracker class getter Method, exposed as property.

//  created by : Globallogic
//==========================================================================================
-(id)LQTracker
{
    if (LQTrackerProxyObj == nil) {
        
        LQTrackerProxyObj = [[TiGeoloqiLQTrackerProxy alloc]init];
    }
    return LQTrackerProxyObj;
}


#pragma Public APIs
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
//  Method Name: pushDisabled
//  Return Type: BOOL
//  Parameter  : N.A.

//  description: Check if APN is disables
//
//  created by : Globallogic
//==========================================================================================
-(BOOL) pushDisabled:(id) value
{
    BOOL bPushDisabled   =      [LQSession pushDisabled];
    return bPushDisabled;    
}

//==========================================================================================
//  Method Name: setPushDisabled
//  Return Type: void
//  Parameter  : BOOL: bPushEnable

//  description: Set the APN disables
//
//  created by : Globallogic
//==========================================================================================
-(void) setPushDisabled:(BOOL) bPushDisabled
{
    [LQSession setPushDisabled:bPushDisabled];
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


@end
