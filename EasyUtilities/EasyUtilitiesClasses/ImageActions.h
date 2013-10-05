//
//  Created by
//

#import <Foundation/Foundation.h>

@interface ImageActions : NSObject

+ (ImageActions *) getInstance;

-(void) rescaleImage: (UIImageView *) imageView  maxHeight: (int)maxHeight maxWidth: (int)maxWidth;
-(void) rescaleImage: (UIImageView *) imageView  insideView: (UIView *) view;
-(void) centerImage:(UIImageView *) imagen insideView:(UIView *) view;

@end
