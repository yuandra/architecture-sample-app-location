//
// Created by Yuandra Ismiraldi on 6/9/14.
// Copyright (c) 2014 Yuandra Ismiraldi. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CLLocation;

@interface YICustomTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

- (void) addLocationData:(CLLocation *)location;

@end