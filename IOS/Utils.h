/**
 *  Utils.h
 *  Titanium GeoLoqi IOS-Module
 *
 *  Created by Global-Logic GeoLoqi IOS Module Team on 09/05/2012.
 *  Copyright 2012 Global Logic. All rights reserved.
 *  Licensed under the terms of the Apache Public License
 *  Please see the LICENSE included with this distribution for details.
 */

#import <Foundation/Foundation.h>

@interface Utils : NSObject

/**
 * Get the string value from interally saved 'dynprops'
 */
+(NSString *) getStringValueFromKey:(NSString *) key;

/**
 * Convert the error object into dictionary with keys of error_code & error_description 
 */
+(NSDictionary *) getDictionaryFromErrorObject:(NSError *) objError;

/**
 * Get the string value from passed dictionary from its key
 */
+(NSString *) getStringValueForDict:(NSDictionary *) dict fromKey:(NSString *) key;

/**
 * Get the custom error object build using error code & description.
 */
+(NSError *) getErrorObjectWithCode:(NSInteger) code description:(NSString *) desc method:(NSString *) method;

/**
 * Print the log message
 */
+(void) printLogWithClassName:(NSString *) strClass message:(NSString *) strMessage;

/**
 * Get the blank string if passed string object is nil 
 */
+(NSString *) nilObjectToBlankString:(NSString *) strValue;

/**
 * Wrap the dictioanry into respose keyword 
 */
+(NSDictionary *) getResponseDictionary:(NSDictionary *) dict;

/**
 * Get the tracker profile enum from string representation 
 */
+(LQTrackerProfile) getTrakerProfileFromString:(NSString *) strStrackingProfile;

/**
 * Get the url encoded string from normal string 
 */
+(NSString *) urlEncodedString:(NSString *) strTargetString;

/**
 *  Get the query string from json object 
 */
+(NSString *) convertTheJsonObjectToqueryString:(NSDictionary *) dictJsonObject;

@end
