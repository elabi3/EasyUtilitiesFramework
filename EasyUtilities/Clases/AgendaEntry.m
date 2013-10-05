//
//  AgendaEntry.m
//  hooola
//
//  Created by Lorenzo Villarroel Pérez on 09/08/13.
//  Copyright (c) 2013 jobssy. All rights reserved.
//

#import "AgendaEntry.h"

@implementation AgendaEntry

- (id)initWithName: (NSString *) name Phones: (NSMutableArray *) phones Emails: (NSMutableArray *) emails {
    self = [super init];
    if (self) {
        self.name = name;
        self.phones = phones;
        self.emails = emails;
    }
    return self;
}


@end
