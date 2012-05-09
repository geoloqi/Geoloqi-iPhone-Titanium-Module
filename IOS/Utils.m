/**
 *  Utils.m
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */

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
    
   // NSDictionary *respDict  =   [self getResponseDictionary:dictError];
    return dictError;
}

//==========================================================================================
//  Method Name: getStringValueFromKey
//  Return Type: NSString
//  Parameter  : NSString: key 
//  description: Get the string value from passed dictionary         
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
//  description: Get the custom error object build using error code & description.         
//
//  created by : Globallogic
//==========================================================================================
+(NSError *) getErrorObjectWithCode:(NSInteger) code description:(NSString *) desc method:(NSString *) method
{
    NSError *objError   =   [NSError errorWithDomain:CONST_EMPTY_STRING code:code userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",desc] forKey:NSLocalizedDescriptionKey]];
    return objError;
}

//==========================================================================================
//  Method Name: printLogWithClassName
//  Return Type: Void
//  Parameter  : NSString : strClass
//               NSString : strMessage
//
//  description: Print the log message         
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

//==========================================================================================
//  Method Name: getTrakerProfileFromString
//  Return Type: LQTrackerProfile
//  Parameter  : NSString : strStrackingProfile
//
//  description: Get the tracker profile enum from string representation        
//
//  created by : Globallogic
//==========================================================================================
+(LQTrackerProfile) getTrakerProfileFromString:(NSString *) strStrackingProfile
{
    //Default profile is off
    LQTrackerProfile trackerProfile     =   LQTrackerProfileOff;
    
    if ([strStrackingProfile isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_OFF]) 
    {
        trackerProfile  =   LQTrackerProfileOff;
    }
    else if([strStrackingProfile isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_PASSIVE])
    {
        trackerProfile  =    LQTrackerProfilePassive;    
    }
    else if([strStrackingProfile isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_REALTIME])
    {
        trackerProfile  =    LQTrackerProfileRealtime;
    }
    else if([strStrackingProfile isEqualToString:CONST_GEOLOQI_LQTRACKER_PROFILE_LOGGING])
    {
        trackerProfile  =    LQTrackerProfileLogging;
    }
    
    return trackerProfile;
}

//==========================================================================================
//  Method Name: urlEncodedString
//  Return Type: NSString ; Url encoded string
//  Parameter  : NSString : strTargetString
//
//  description: Get the url encoded string from normal string       
//
//  created by : Globallogic
//==========================================================================================
+(NSString *) urlEncodedString:(NSString *) strTargetString
{
    NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (CFStringRef)strTargetString,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8 );
    
    return encodedString;
    
}

//==========================================================================================
//  Method Name: convertTheJsonObjectToqueryString
//  Return Type: NSString; get the query string 
//  Parameter  : NSDictionary : dictJsonObject
//
//  description: Get the query string from json object       
//
//  created by : Globallogic
//==========================================================================================
+(NSString *) convertTheJsonObjectToqueryString:(NSDictionary *) dictJsonObject
{
    NSEnumerator *enumerator = [dictJsonObject keyEnumerator];

    NSString *strOutput =   CONST_EMPTY_STRING;
    
    for(NSString *aKey in enumerator) 
    {
        if ([strOutput isEqualToString:CONST_EMPTY_STRING])
        {
            strOutput   =  [NSString stringWithFormat:@"%@=%@",aKey,[Utils urlEncodedString:[Utils getStringValueForDict:dictJsonObject fromKey:aKey]]]; 
        }
        else
        {
            strOutput   =  [NSString stringWithFormat:@"%@&%@=%@",strOutput,aKey,[Utils urlEncodedString:[Utils getStringValueForDict:dictJsonObject fromKey:aKey]]]; 
        }
    }

    return strOutput;
    
}

@end
