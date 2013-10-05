//
//  Created by
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
