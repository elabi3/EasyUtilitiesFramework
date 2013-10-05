//
//  Created by
//

#import "ImageActions.h"

static ImageActions * instance;

@implementation ImageActions

+ (ImageActions *) getInstance {
    if (instance == nil) {
        instance = [[ImageActions alloc] init];
    }
    return instance;
}

-(void) rescaleImage: (UIImageView *) imageView  maxHeight: (int)maxHeight maxWidth: (int)maxWidth {
    UIImage * image = imageView.image;
    CGRect frame = imageView.frame;
    if (image.size.width > image.size.height) {//x > y , apaisada
        double proporcion = maxWidth/image.size.width ;
        frame.size.width = image.size.width * proporcion;
        frame.size.height = image.size.height * proporcion;
        ////ALog(@"proporcion1 = %.3f",proporcion);
    } else if (image.size.width < image.size.height){//x < y , retrato
        double proporcion = maxHeight/image.size.height ;
        frame.size.width = image.size.width * proporcion;
        frame.size.height = image.size.height * proporcion;
        ////ALog(@"proporcion2 = %.3f",proporcion);
    } else {// x == y , cuadrada
        frame.size.width = maxWidth;
        frame.size.height = maxWidth;
    }
    imageView.frame = frame;
}

-(void) rescaleImage: (UIImageView *) imageView  insideView: (UIView *) view {
    UIImage * image = imageView.image;
    CGRect frame = imageView.frame;
    if (image.size.width > image.size.height) {//x > y , apaisada
        double proporcion = view.frame.size.width*0.9 /image.size.width ; 
        frame.size.width = image.size.width * proporcion;
        frame.size.height = image.size.height * proporcion;
        ////ALog(@"proporcion1 = %.3f",proporcion);
    } else if (image.size.width < image.size.height){//x < y , retrato
        double proporcion = view.frame.size.height*0.8 /image.size.height ;
        frame.size.width = image.size.width * proporcion;
        frame.size.height = image.size.height * proporcion;
        ////ALog(@"proporcion2 = %.3f",proporcion);
    } else {// x == y , cuadrada
        frame.size.width = view.frame.size.width*0.9;
        frame.size.height = view.frame.size.width*0.9;
    }
    imageView.frame = frame;
}

-(void) centerImage:(UIImageView *) imagen insideView:(UIView *) view {
    int margen = view.frame.size.width * 0.05;
    CGRect frame = imagen.frame;
    if (frame.size.width >= frame.size.height) {//foto apaisada
        frame.origin = CGPointMake(margen, frame.origin.y);
    } else if (frame.size.width < frame.size.height) {
        frame.origin = CGPointMake(view.frame.size.width*0.5 - frame.size.width*0.5, frame.origin.y);
    }
    imagen.frame = frame;
}


@end
