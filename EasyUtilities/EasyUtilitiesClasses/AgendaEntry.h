//
//  Created by
//

#import <Foundation/Foundation.h>

@interface AgendaEntry : NSObject

@property(strong, nonatomic) NSString * name;
@property(strong, nonatomic) NSMutableArray * phones;
@property(strong, nonatomic) NSMutableArray * emails;

- (id)initWithName: (NSString *) name Phones: (NSMutableArray *) phones Emails: (NSMutableArray *) emails;

@end
