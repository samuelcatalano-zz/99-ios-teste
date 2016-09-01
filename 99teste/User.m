//
//  User.m
//  99teste
//
//  Created by Samuel Catalano on 8/29/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "User.h"

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.idUsuario forKey:@"UserIdUsuario"];
    [aCoder encodeObject:self.firstName forKey:@"UserFirstName"];
    [aCoder encodeObject:self.lastName  forKey:@"UserLastName"];
    [aCoder encodeObject:self.username  forKey:@"UserUsername"];
    [aCoder encodeObject:self.password  forKey:@"UserPassword"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _idUsuario  = [coder decodeObjectForKey:@"UserIdUsuario"];
        _firstName  = [coder decodeObjectForKey:@"UserFirstName"];
        _lastName   = [coder decodeObjectForKey:@"UserLastName"];
        _username   = [coder decodeObjectForKey:@"UserUsername"];
        _password   = [coder decodeObjectForKey:@"UserPassword"];
    }
    return self;
}

@end