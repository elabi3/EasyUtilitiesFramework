//
//  Created by
//

#import "AddressBookHandler.h"
#import <AddressBook/AddressBook.h>
#import "AddressBookEntry.h"

static AddressBookHandler * instance;

@implementation AddressBookHandler

+ (AddressBookHandler *) getInstance {
    if (instance == nil) {
        instance = [[AddressBookHandler alloc] init];
    }
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.contactNames = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSString *) normalizePhone: (NSString *)phone {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\+[0-9][0-9]|00[0-9][0-9]"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSRegularExpression *regexForDigits = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    phone  = [phone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSMutableString * newPhone = [NSMutableString stringWithString:phone];
    
    [regex replaceMatchesInString:newPhone
                          options:0
                            range:NSMakeRange(0, [newPhone length])
                     withTemplate:@""];
    [regexForDigits replaceMatchesInString:newPhone
                          options:0
                            range:NSMakeRange(0, [newPhone length])
                     withTemplate:@""];
    phone = [NSString stringWithString:newPhone];
    return phone;
}

-(BOOL) isValidEmail:(NSString *)checkString {
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (NSString *) normalizeEmail: (NSString *)email {
    email = [email stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![self isValidEmail:email]) {
        email = @"";
    }
    
    return email;
}

- (NSMutableArray *)getAddressBook:(ABAddressBookRef)addressBookRef {
    //ManejadorServicioWebHooola * manejadorServicioWebHooola = [ManejadorServicioWebHooola getInstance];
    NSMutableArray * addressBook = [NSMutableArray array];
    //NSMutableArray * friends;
    
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    for (CFIndex i = 0; i < CFArrayGetCount(people); i++) {
        NSMutableArray *allEmails = [NSMutableArray array];
        NSMutableArray *allPhones = [NSMutableArray array];
        
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (CFIndex j=0; j < ABMultiValueGetCount(emails); j++) {
            NSString* email = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j);
            email = [self normalizeEmail:email];
            [allEmails addObject:email];
        }
        for (CFIndex j=0; j < ABMultiValueGetCount(phones); j++) {
            
            NSString* phone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j);
            phone = [self normalizePhone:phone];
            phone  = [phone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            [allPhones addObject:phone];
        }
        CFStringRef sourceName = (CFStringRef)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef sourceSurname = (CFStringRef)ABRecordCopyValue(person, kABPersonLastNameProperty);
        
        NSString * name = (__bridge NSString *) sourceName;
        NSString * surname = (__bridge NSString *) sourceSurname;
        if (!name) {
            name = @"";
        }
        if (!surname) {
            surname = @"";
        }
        NSString * fullName = [NSString stringWithFormat:@"%@ %@",name,surname];
        
        AddressBookEntry * agendaEntry = [[AddressBookEntry alloc] initWithName:fullName Phones:allPhones Emails:allEmails];
        [addressBook addObject:agendaEntry];
        
        //CFRelease(sourceName);
        CFRelease(emails);
        CFRelease(phones);
    }
    CFRelease(people);
    //friends = [manejadorServicioWebHooola getFriendsWithApp:nil ProgressView:nil Emails:allEmails Phones:allPhones];
    //return friends;
    return addressBook;
}

-  (NSMutableArray *)getAgenda {
    __block NSMutableArray * agenda;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            dispatch_sync( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
                agenda = [self getAddressBook:addressBookRef];
            });
        });
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        dispatch_sync( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            agenda = [self getAddressBook:addressBookRef];
        });
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showError" object:@"Please, allow Hooola to access your contacts in settings."];
    }
    return agenda;
}

- (NSMutableDictionary *)getEmailsAndPhonesFromAddresBookRef:(ABAddressBookRef)addressBookRef {
    NSMutableDictionary * emailsAndPhonesDictionary = [NSMutableDictionary dictionary];
    //NSMutableArray * friends;
    
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    NSMutableArray *allEmails = [[NSMutableArray alloc] init];
    NSMutableArray *allPhones = [[NSMutableArray alloc] init];
    for (CFIndex i = 0; i < CFArrayGetCount(people); i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        
        CFStringRef sourceName = (CFStringRef)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef sourceSurname = (CFStringRef)ABRecordCopyValue(person, kABPersonLastNameProperty);
        
        NSString * name = (__bridge NSString *) sourceName;
        NSString * surname = (__bridge NSString *) sourceSurname;
        if (!name) {
            name = @"";
        }
        if (!surname) {
            surname = @"";
        }
        NSString * fullName = [NSString stringWithFormat:@"%@ %@",name,surname];
        
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (CFIndex j=0; j < ABMultiValueGetCount(emails); j++) {
            NSString* email = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j);
            email = [self normalizeEmail:email];
            [allEmails addObject:email];
            self.contactNames[email] = fullName;
        }
        
        for (CFIndex j=0; j < ABMultiValueGetCount(phones); j++) {
            NSString* phone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j);
            phone = [self normalizePhone:phone];
            if (![phone isEqualToString:@""]) {
                [allPhones addObject:phone];
                self.contactNames[phone] = fullName;
            }

        }
        
        CFRelease(emails);
        CFRelease(phones);
    }
    CFRelease(people);
    emailsAndPhonesDictionary[@"emails"] = allEmails;
    emailsAndPhonesDictionary[@"phones"] = allPhones;
    return emailsAndPhonesDictionary;
}

- (NSMutableDictionary *)getEmailsAndPhonesFromAddresBook {
    __block NSMutableDictionary * emailsAndPhones;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            dispatch_sync( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
                emailsAndPhones = [self getEmailsAndPhonesFromAddresBookRef:addressBookRef];
            });
        });
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        dispatch_sync( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            emailsAndPhones = [self getEmailsAndPhonesFromAddresBookRef:addressBookRef];
        });
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showError" object:@"Please, allow Hooola to access your contacts in settings."];
    }
    return emailsAndPhones;
}



@end
