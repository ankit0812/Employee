//
//  BrowseViewController.h
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong) NSMutableArray *emp;     //An array to store all the information of clicked entries

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// HELLO WORLD

@end
