//
//  Created by
//

#import <Foundation/Foundation.h>

@class Person, AddressBookEntry;
@interface AddressBookHandler : NSObject

@property(strong, nonatomic) NSMutableDictionary * contactNames;

+ (AddressBookHandler *) getInstance;

- (NSMutableArray *) getReduceAddressBook;
- (NSMutableArray *) getAddressBook;
- (NSMutableDictionary *) getEmailsAndPhonesFromAddresBook;

- (NSMutableArray *) getFavoriteContacts;
- (void) addNewContactFromEntry: (AddressBookEntry *) entry;

@end
