//
//  Created by
//

#import <Foundation/Foundation.h>

@class Person;
@interface AddressBookHandler : NSObject

@property(strong, nonatomic) NSMutableDictionary * contactNames;

+ (AddressBookHandler *) getInstance;

- (NSMutableArray *) getReduceAddressBook;
- (NSMutableArray *) getAddressBook;
- (NSMutableDictionary *) getEmailsAndPhonesFromAddresBook;

@end
