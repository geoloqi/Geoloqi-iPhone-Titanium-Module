//
//  Utils.m
//  geoloqimodule
//
//  Created by globallogic on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#import "TiUtils.h"

@implementation Utils

#pragma pragma mark-
#pragma mark Utility Methods
//==========================================================================================
//  Method Name: getStringValueFromKey
//  Return Type: NSString
//  Parameter  : NSString: key 
//  description: Get the string value from interally saved 'dynprops'         
//
//  created by : Globallogic
//==========================================================================================
+(NSString *) getStringValueFromKey:(NSString *) key
{
    NSLog(@"Utils::getStringValueFromKey called");                    
    NSString *strValue  =   [TiUtils stringValue:[self valueForKey:key]];
    
    if (strValue==nil)
    {
        strValue    =   CONST_EMPTY_STRING;
    }
    
    return strValue;
}

//==========================================================================================
//  Method Name: getDictionaryFromErrorObject
//  Return Type: NSMutableDictionary
//  Parameter  : NSError: objError 
//  description: Convert the error object into dictionary with keys of error_code &         error_description        
//
//  created by : Globallogic
//==========================================================================================
+(NSDictionary *) getDictionaryFromErrorObject:(NSError *) objError
{
    NSLog(@"Utils::getDictionaryFromErrorObject called");    
    NSMutableDictionary *dictError = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[objError code]],@"error_code",[NSString stringWithFormat:@"%@",[objError localizedDescription]],@"error_description",nil];
    
    NSDictionary *respDict  =   [self getResponseDictionary:dictError];
    return respDict;
}

//==========================================================================================
//  Method Name: getStringValueFromKey
//  Return Type: NSString
//  Parameter  : NSString: key 
//  description: Get the string value from interally saved 'dynprops'         
//
//  created by : Globallogic
//==========================================================================================
+(NSString *) getStringValueForDict:(NSDictionary *) dict fromKey:(NSString *) key
{
    NSLog(@"Utils::getStringValueFromKey called");                    
    NSString *strValue  =   [TiUtils stringValue:[dict valueForKey:key]];
    
    if (strValue==nil)
    {
        strValue    =   CONST_EMPTY_STRING;
    }
    
    return strValue;
}

//==========================================================================================
//  Method Name: nilObjectToBlankString
//  Return Type: NSString
//  Parameter  : NSString: strValue 
//  description: Get the blank string if passed string object is nil          
//
//  created by : Globallogic
//==========================================================================================
+(NSString *) nilObjectToBlankString:(NSString *) strValue
{
    NSLog(@"Utils::ifNilThenBlank called");                    
    
    if (strValue==nil)
    {
        strValue    =   CONST_EMPTY_STRING;
    }
    
    return strValue;
}

//==========================================================================================
//  Method Name: getErrorObjectWithCode
//  Return Type: NSError
//  Parameter  : NSInteger: code 
//               NSString : desc
//               NSString : method
//
//  description: Get the custom error object         
//
//  created by : Globallogic
//==========================================================================================
+(NSError *) getErrorObjectWithCode:(NSInteger) code description:(NSString *) desc method:(NSString *) method
{
    NSError *objError   =   [NSError errorWithDomain:CONST_EMPTY_STRING code:code userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@: %@",method,desc] forKey:NSLocalizedDescriptionKey]];
    return objError;
}

//==========================================================================================
//  Method Name: printLogWithClassName
//  Return Type: Void
//  Parameter  : NSString : strClass
//               NSString : strMessage
//
//  description: Get the log message         
//
//  created by : Globallogic
//==========================================================================================
+(void) printLogWithClassName:(NSString *) strClass message:(NSString *) strMessage
{
    double currentTimeStamp  =   [[NSDate date] timeIntervalSince1970];
    NSLog(@"[INFO] %@ : %f, %@",strClass,currentTimeStamp,strMessage);
}

//==========================================================================================
//  Method Name: getResponseDictionary
//  Return Type: NSMutableDictionary
//  Parameter  : NSMutableDictionary : dict
//
//  description: Wrap the dictioanry into respose keyword        
//
//  created by : Globallogic
//==========================================================================================
+(NSDictionary *) getResponseDictionary:(NSDictionary *) dict
{
    if (dict==nil)
    {
        return dict;
    }
    else
    {
        return [NSDictionary dictionaryWithObject:dict forKey:@"response"];        
    }

}

@end
