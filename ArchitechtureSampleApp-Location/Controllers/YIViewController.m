//
//  YIViewController.m
//  ArchitechtureSampleApp-Location
//
//  Created by Yuandra Ismiraldi on 5/31/14.
//  Copyright (c) 2014 Yuandra Ismiraldi. All rights reserved.
//

#import "YIViewController.h"
#import "YICustomMapView.h"
#import "YILocationHelper.h"
#import "YICustomTableView.h"

@implementation YIViewController {

    NSMutableArray *_dataLocation;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregNotification];

}


#pragma mark - Notification Method

-(void) registerNotification{

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

    [center addObserverForName:cYINotificationLocationError object:nil queue:nil usingBlock:^(NSNotification *note) {

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Location not found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];

    }];

    [center addObserverForName:cYINotificationLocationFound object:nil queue:nil usingBlock:^(NSNotification *note) {

        CLLocation *location = [YILocationHelper sharedHelper].currentLocation;

        [self.mapView updateSelfLocationOnMap:location];

        [_dataLocation addObject:location];

        [self.tableView addLocationData:location];

    }];

    [center addObserverForName:cYINotificationTableRowSelected object:nil queue:nil usingBlock:^(NSNotification *note) {

        NSDictionary *dict = [note userInfo];

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Table Row Tapped" message:[NSString stringWithFormat:@"Tapped in row %@",dict[@"row"]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];

        [alertView show];


    }];
}

-(void) unregNotification{

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

    [center removeObserver:self name:cYINotificationLocationError object:nil];
    [center removeObserver:self name:cYINotificationLocationFound object:nil];

    [center removeObserver:self name:cYINotificationTableRowSelected object:nil];
}

#pragma mark - Location Method

-(void) initData {

    _dataLocation = [[NSMutableArray alloc] init];

}

-(void) initLocation{

    [[YILocationHelper sharedHelper] startUpdatingLocation];
}


@end