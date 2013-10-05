//
//  ImagenGrandeViewController.h
//  Prototipo El Mundo
//
//  Created by Laboratorio Ingeniería Software on 21/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería del Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagenGrandeViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView* scrollView;
    UIImageView *imageView;
    
    float minZoomScale;
    float maxZoomScale;
}

@property(strong, nonatomic) UIImage *image;

- (id)initWithImage:(UIImage *) image;

@end
