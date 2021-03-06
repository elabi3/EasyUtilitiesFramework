//
//  Created by
//

#import <UIKit/UIKit.h>

@interface BigImageViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView* scrollView;
    UIImageView *imageView;
    
    float minZoomScale;
    float maxZoomScale;
}

@property(strong, nonatomic) UIImage *image;

- (id)initWithImage:(UIImage *) image;

@end
