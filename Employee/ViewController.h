//
//  ViewController.h
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)addNewRecords:(id)sender;
- (IBAction)browseRecords:(id)sender;
- (IBAction)searchRecords:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrolls;

@end

