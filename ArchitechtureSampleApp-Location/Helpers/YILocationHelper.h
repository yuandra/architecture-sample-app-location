//
// Created by Yuandra Ismiraldi on 4/17/14.
// Copyright (c) 2014 YI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YILocationHelper : NSObject <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocation *currentLocation;
@property(nonatomic, strong) CLPlacemark *currentPlacemark;


+ (YILocationHelper *)sharedHelper;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
-(void)setPlacemarkBasedOnLocation:(CLLocation *)location ;
- (NSString*)convertToDegreeMinutesSecondFromCoordinate:(CLLocationCoordinate2D)coordinate;

@end