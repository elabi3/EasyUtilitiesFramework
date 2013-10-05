//
//  GeolocationManager.h
//  GeolocalizationTest
//
//  Created by Laboratorio Ingeniería Software on 03/12/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GeolocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

+ (GeolocationManager *) getInstance;
-(void) refreshLocation;


@end
