//
//  ScreenSizeManager.m
//  MapaApple
//
//  Created by Lorenzo Villarroel on 18/02/13.
//  Copyright (c) 2013 Laboratorio Ingeniería Software. All rights reserved.
//

#import "ScreenSizeManager.h"

@implementation ScreenSizeManager

+(CGSize) currentSize {
    return [ScreenSizeManager sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation {
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        size = CGSizeMake(size.height, size.width);
    }
    if (application.statusBarHidden == NO) {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    return size;
}

@end
