//
//  Created by
//

#import <Foundation/Foundation.h>

@interface ScreenSizeManager : NSObject

+(CGSize) currentSize;
+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;

@end
