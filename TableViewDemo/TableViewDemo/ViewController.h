//
//  ViewController.h
//  TableViewDemo
//
//  Created by qingyun on 10/24/13.
//  Copyright (c) 2013 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger  apps;
    NSArray *_countryAry;
    NSString *_countryListStr;
    NSMutableArray *indexArray;
    int _selectedCountryCode;
    int _selectRow;
    int _selectSection;
    
    UITableView * _tableView;
}

@end
