//
// Created by Yuandra Ismiraldi on 4/17/14.
// Copyright (c) 2014 YI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface YICustomMapView : MKMapView <MKMapViewDelegate>

-(void) updateSelfLocationOnMap:(CLLocation *)location;

-(void) addPlaceAnnotationWithTitle:(NSString*)title andDescription:(NSString*)description andTag:(NSString*)tag andCoordinate:(CLLocationCoordinate2D)coordinate;

@end