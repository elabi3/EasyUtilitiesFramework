//
//  TratadorImagenes.m
//  PrototipoElMundo
//
//  Created by Lorenzo Villarroel on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TratadorImagenes.h"

static TratadorImagenes * instance;

@implementation TratadorImagenes

+ (TratadorImagenes *) getInstance {
    if (instance == nil) {
        instance = [[TratadorImagenes alloc] init];
    }
    return instance;
}

-(void) reescalarImagen: (UIImageView *) imageView  maxHeight: (int)maxHeight maxWidth: (int)maxWidth {
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

-(void) reescalarImagen: (UIImageView *) imageView  enView: (UIView *) view {
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

-(void) centrarImagen:(UIImageView *) imagen EnView:(UIView *) view {
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
