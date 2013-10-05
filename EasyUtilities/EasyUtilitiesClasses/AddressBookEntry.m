//
//  AddressBookEntry.m
//  EasyUtilities
//
//  Created by elabi3 on 05/10/13.
//  Copyright (c) 2013 elabi3. All rights reserved.
//

#import "AddressBookEntry.h"

@implementation AddressBookEntry

- (id)initWithName:(NSString *) name  phones: (NSMutableArray *) phones  emails: (NSMutableArray *) emails {
    self = [super init];
    if (self) {
        self.name = name;
        self.phones = phones;
        self.emails = emails;
    }
    return self;
}

@end
