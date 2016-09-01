//
//  Utility.h
//  99teste
//
//  Created by Samuel Catalano on 8/31/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Utility : NSObject

+(User *)loadCustomObjectWithKey:(NSString *)key;

@end