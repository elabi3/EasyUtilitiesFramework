//
//  AddressBookEntry.h
//  EasyUtilities
//
//  Created by elabi3 on 05/10/13.
//  Copyright (c) 2013 elabi3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookEntry : NSObject

@property(strong, nonatomic) NSString * name;
@property(strong, nonatomic) NSMutableArray * phones;
@property(strong, nonatomic) NSMutableArray * emails;

- (id)initWithName:(NSString *) name  phones: (NSMutableArray *) phones  emails: (NSMutableArray *) emails;

@end
