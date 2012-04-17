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
    //RELEASE_TO_NIL(LQTrackerProxyObj);
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

// Overriding "createProxy" method of Timodule to restrict proxy object creation.
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
        //NSLog(@"[ERROR]: ERROR IN METHOD CALLING");
    }
}

// Getter Method
-(id)getLQTracker:(id) args
{
    if (LQTrackerProxyObj == nil) {
        
        LQTrackerProxyObj = [[[TiGeoloqiLQTrackerProxy alloc]init] autorelease];
    }
    return LQTrackerProxyObj;
}

// Getter Property
-(id)LQTracker
{
    if (LQTrackerProxyObj == nil) {
        
        LQTrackerProxyObj = [[[TiGeoloqiLQTrackerProxy alloc]init] autorelease];
    }
    return LQTrackerProxyObj;
}


#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}


-(void) setDebug:(id) value
{
    bLogEnabled  =   [TiUtils boolValue:value];
}

-(BOOL) isDebugOn
{
    return bLogEnabled;
}

+(TiGeoloqiModule *) getCurrentObject
{
    return currentObject;
}


@end
