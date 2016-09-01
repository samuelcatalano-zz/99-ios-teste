//
//  Utility.m
//  99teste
//
//  Created by Samuel Catalano on 8/31/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(User *)loadCustomObjectWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    User *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

@end