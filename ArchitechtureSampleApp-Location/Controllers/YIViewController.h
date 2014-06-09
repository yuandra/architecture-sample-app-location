//
//  YIViewController.h
//  ArchitechtureSampleApp-Location
//
//  Created by Yuandra Ismiraldi on 5/31/14.
//  Copyright (c) 2014 Yuandra Ismiraldi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YICustomMapView;
@class YICustomTableView;

@interface YIViewController : UIViewController

@property(nonatomic, weak) IBOutlet YICustomMapView *mapView;
@property(nonatomic, weak) IBOutlet YICustomTableView *tableView;



@end