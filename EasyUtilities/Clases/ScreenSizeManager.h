//
//  ScreenSizeManager.h
//  MapaApple
//
//  Created by Lorenzo Villarroel on 18/02/13.
//  Copyright (c) 2013 Laboratorio Ingeniería Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenSizeManager : NSObject

+(CGSize) currentSize;
+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;

@end
