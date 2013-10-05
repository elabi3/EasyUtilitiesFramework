//
//  ManejadorAddressBook.h
//  hooola
//
//  Created by Lorenzo Villarroel Pérez on 09/08/13.
//  Copyright (c) 2013 jobssy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;
@interface ManejadorAddressBook : NSObject

@property(strong, nonatomic) NSMutableDictionary * contactNames;

+ (ManejadorAddressBook *) getInstance;
- (NSMutableDictionary *)getEmailsAndPhonesFromAddresBook;
- (NSMutableArray *)getAgenda;

-(NSString *) getNameFromPerson: (Person *) person;

@end
