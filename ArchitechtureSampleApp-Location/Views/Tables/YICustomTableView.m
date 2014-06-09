//
// Created by Yuandra Ismiraldi on 6/9/14.
// Copyright (c) 2014 Yuandra Ismiraldi. All rights reserved.
//

#import "YICustomTableView.h"
#import <CoreLocation/CoreLocation.h>


@implementation YICustomTableView {

    NSMutableArray *_dataTable;

}

- (id)initWithCoder:(NSCoder *)coder {


    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;

        [self initData];
    }

    return self;
}



#pragma mark - Data Method

- (void) initData {

    _dataTable = [[NSMutableArray alloc] init];

}

- (void) addLocationData:(CLLocation *)location {

    [_dataTable addObject:location];
    [self reloadData];

}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dict = @{@"row":@(indexPath.row)};

    [[NSNotificationCenter defaultCenter] postNotificationName:cYINotificationTableRowSelected object:nil userInfo:dict];

}

#pragma mark - UITableViewDataSourceDelegate


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CLLocation* location = _dataTable[indexPath.row];

    static NSString *cellIdentifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];

    return cell;


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataTable count];
}


@end