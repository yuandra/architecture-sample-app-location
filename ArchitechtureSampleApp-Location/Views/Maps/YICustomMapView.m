//
// Created by Yuandra Ismiraldi on 4/17/14.
// Copyright (c) 2014 YI. All rights reserved.
//

#import "YICustomMapView.h"
#import "MKMapView+ZoomLevel.h"


@implementation YICustomMapView {

     MKPointAnnotation* _userAnnotation;


}

- (id)initWithCoder:(NSCoder *)coder {


    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
    }

    return self;
}

#pragma mark - Map Method
-(void)setMapParameters {

}


-(void) updateSelfLocationOnMap:(CLLocation *)location {

    if(_userAnnotation!=nil){
        [self removeAnnotation:_userAnnotation];
        _userAnnotation.coordinate = location.coordinate;
        [self addAnnotation:_userAnnotation];
    }
    else{

        _userAnnotation = [[MKPointAnnotation alloc] init];
        _userAnnotation.coordinate = location.coordinate;

        [self addAnnotation:_userAnnotation];


    }

    [self setCenterCoordinate:_userAnnotation.coordinate zoomLevel:14 animated:YES];

    [self setMapParameters];
}

#pragma mark - MKMapKitDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {

    if([annotation isKindOfClass:[MKPointAnnotation class]]) {

        static NSString *identifier = @"pointAnnotation";


        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self dequeueReusableAnnotationViewWithIdentifier:identifier];

        MKPointAnnotation *myAnnotation = (MKPointAnnotation*) annotation;

        if (annotationView == nil) {

            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier];



        } else {

            annotationView.annotation = annotation;
            annotationView.pinColor = MKPinAnnotationColorRed;

        }

        return annotationView;

    }
    else {
        return nil;
    }

}


@end