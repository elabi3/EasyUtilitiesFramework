//
//  Created by
//

#import "GeolocationManager.h"

static GeolocationManager *instance;

@implementation GeolocationManager

+ (GeolocationManager *) getInstance {
    if (instance == nil) {
        instance = [[GeolocationManager alloc] init];
    }
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10.0f;
    }
    return self;
}

-(void) refreshLocation {
    [self.locationManager startUpdatingLocation];
}

-(void) refreshLocationWithManager:(CLLocationManager *) manager  {
    self.locationManager = manager;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if ([locations count] > 0) {
        //ALog(@"locations = %d",locations.count);
        CLLocation *location = [locations objectAtIndex:0];
        if (location.horizontalAccuracy < 100 && location.verticalAccuracy < 100) {
            //NSLog(@"%.8f,%.8f",location.coordinate.latitude,location.coordinate.longitude);
            //NSLog(@"%.2f,%.2f", location.horizontalAccuracy,location.horizontalAccuracy);
           [[NSNotificationCenter defaultCenter] postNotificationName:@"currentLocation" object:location];
            [manager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"errorLocation" object:error];
}

@end
