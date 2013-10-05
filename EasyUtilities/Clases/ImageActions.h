//
//  TratadorImagenes.h
//  PrototipoElMundo
//
//  Created by Lorenzo Villarroel on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TratadorImagenes : NSObject

+ (TratadorImagenes *) getInstance;


-(void) reescalarImagen: (UIImageView *) imageView  maxHeight: (int)maxHeight maxWidth: (int)maxWidth;
-(void) reescalarImagen: (UIImageView *) imageView  enView: (UIView *) view;
-(void) centrarImagen:(UIImageView *) imagen EnView:(UIView *) view;

@end
