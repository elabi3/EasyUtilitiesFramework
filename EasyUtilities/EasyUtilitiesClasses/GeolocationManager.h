//
//  Created by
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GeolocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

+ (GeolocationManager *) getInstance;
-(void) refreshLocation;

@end
