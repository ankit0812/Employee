//
//  DetailViewController.h
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *empID;

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *age;

@property (weak, nonatomic) IBOutlet UITextField *department;

@property (weak, nonatomic) IBOutlet UITextField *designation;

@property (weak, nonatomic) IBOutlet UITextField *tagLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scroller1;

@property (strong) NSManagedObject *emp;
@property (weak, nonatomic) NSString *picLabel;



@end
