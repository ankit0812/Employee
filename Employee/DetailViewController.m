//
//  DetailViewController.m
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "DetailViewController.h"
#import "BrowseViewController.h"
#import <UIKit/UIView.h>
#import <CoreData/CoreData.h>

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scroller1 setScrollEnabled:YES];

    // Do any additional setup after loading the view.
    //Updating the values of Label with the obtained value from segue in emp
    
    _empID.text=[self.emp valueForKey:@"empId"];
    _firstName.text=[self.emp valueForKey:@"firstName"];
    _lastName.text=[self.emp valueForKey:@"lastName"];
    _age.text=[self.emp valueForKey:@"age"];
    _department.text=[self.emp valueForKey:@"department"];
    _designation.text=[self.emp valueForKey:@"designation"];
    _tagLine.text=[self.emp valueForKey:@"tagLine"];
    
    _picLabel=[self.emp valueForKey:@"image"];
    _imageView.image=[self loadImage:_picLabel];
    
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}



-(UIImage *)loadImage: (NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithString:name] ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
