//
//  Utils.h
//  geoloqimodule
//
//  Created by globallogic on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(NSString *) getStringValueFromKey:(NSString *) key;
+(NSDictionary *) getDictionaryFromErrorObject:(NSError *) objError;
+(NSString *) getStringValueForDict:(NSDictionary *) dict fromKey:(NSString *) key;
+(NSError *) getErrorObjectWithCode:(NSInteger) code description:(NSString *) desc method:(NSString *) method;
+(void) printLogWithClassName:(NSString *) strClass message:(NSString *) strMessage;
+(NSString *) nilObjectToBlankString:(NSString *) strValue;
+(NSDictionary *) getResponseDictionary:(NSDictionary *) dict;

@end
