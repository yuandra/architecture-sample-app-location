//
// Created by Yuandra Ismiraldi on 4/17/14.
// Copyright (c) 2014 YI. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "YILocationHelper.h"


@implementation YILocationHelper {

    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    BOOL _isPerformingReverseGeocoding;


}

#pragma mark - Initializer

+ (YILocationHelper *)sharedHelper {

    static YILocationHelper *_sharedHelper = nil;

    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        _sharedHelper = [[YILocationHelper alloc] init];
    });

    return _sharedHelper;
}

- (id)init {
    self = [super init];
    if (self) {
       _locationManager = [[CLLocationManager alloc] init];
       _locationManager.delegate = self;
       _geocoder = [[CLGeocoder alloc] init];
    }

    return self;
}

#pragma mark - Location Method
- (void)startUpdatingLocation {

    if([CLLocationManager locationServicesEnabled]) {
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = 100.0f;
        [_locationManager startUpdatingLocation];
        [self performSelector:@selector(locationTimeout:) withObject:nil afterDelay:60];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:cYINotificationLocationError object:nil];
    }
}

- (void)stopUpdatingLocation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(locationTimeout:) object:nil];
    [_locationManager stopUpdatingLocation];
}


- (void)locationTimeout:(id)obj{

    if(_currentLocation == nil){
        [self stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:cYINotificationLocationError object:nil];
    }


}

-(void)setPlacemarkBasedOnLocation:(CLLocation *)location {

    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {

        if(error == nil && [placemarks count] > 0){

            _currentPlacemark = [placemarks lastObject];
            [[NSNotificationCenter defaultCenter] postNotificationName:cYINotificationLocationFound object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:cYINotificationLocationError object:nil];
        }


    }];


}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    CLLocation *newLocation = [locations lastObject];

    //get first location

    if(_currentLocation == nil || _currentLocation != newLocation)
    {
        _currentLocation = newLocation;

        [self stopUpdatingLocation];

        [_geocoder reverseGeocodeLocation:_currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {

                if(error == nil && [placemarks count] > 0){

                    _currentPlacemark = [placemarks lastObject];

                }
                else {
                    _currentPlacemark = nil;
                }


            [[NSNotificationCenter defaultCenter] postNotificationName:cYINotificationLocationFound object:nil];


            }];


    }

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {


    if(error.code == kCLErrorLocationUnknown){
        return;
    }

    [self stopUpdatingLocation];

    [[NSNotificationCenter defaultCenter] postNotificationName:cYINotificationLocationError object:nil];
}

#pragma mark - coordinate helper

- (NSString*)convertToDegreeMinutesSecondFromCoordinate:(CLLocationCoordinate2D)coordinate;
{

    int latSeconds = (int)(coordinate.latitude * 3600);
    int latDegrees = latSeconds / 3600;
    latSeconds = ABS(latSeconds % 3600);
    int latMinutes = latSeconds / 60;
    latSeconds %= 60;

    int longSeconds = (int)(coordinate.longitude * 3600);
    int longDegrees = longSeconds / 3600;
    longSeconds = ABS(longSeconds % 3600);
    int longMinutes = longSeconds / 60;
    longSeconds %= 60;

    NSString* result = [NSString stringWithFormat:@"%d°%d'%d\"%@ %d°%d'%d\"%@",
                                                  ABS(latDegrees),
                                                  latMinutes,
                                                  latSeconds,
                                                  latDegrees >= 0 ? @"N" : @"S",
                                                  ABS(longDegrees),
                                                  longMinutes,
                                                  longSeconds,
                                                  longDegrees >= 0 ? @"E" : @"W"];

    return result;
}

@end