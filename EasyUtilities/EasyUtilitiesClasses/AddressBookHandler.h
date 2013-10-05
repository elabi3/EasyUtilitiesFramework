//
//  Created by
//

#import <Foundation/Foundation.h>

@class Person;
@interface AddressBookHandler : NSObject

@property(strong, nonatomic) NSMutableDictionary * contactNames;

+ (AddressBookHandler *) getInstance;
- (NSMutableArray *)getAgenda;

- (NSMutableDictionary *)getEmailsAndPhonesFromAddresBook;

@end
