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
    
    self.empID.delegate=self;
    self.firstName.delegate=self;
    self.lastName.delegate=self;
    self.age.delegate=self;
    self.department.delegate=self;
    self.designation.delegate=self;
    self.tagLine.delegate=self;
    
    _scroller1.delegate=self;
    [_scroller1 setShowsHorizontalScrollIndicator:NO];
    
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [self.scroller1 addGestureRecognizer:yourTap];
    [self.view addSubview:_scroller1];
    [self.scroller1 setScrollEnabled:YES];


    // Do any additional setup after loading the view.
    //Updating the values of Label with the obtained value from segue in emp
    
    _empID.text=[@"EMP ID : " stringByAppendingString:[self.emp valueForKey:@"empId"]];
    _firstName.text=[@"FIRST NAME : " stringByAppendingString:[self.emp valueForKey:@"firstName"]];
    _lastName.text=[@"LAST NAME : " stringByAppendingString:[self.emp valueForKey:@"lastName"]];
    _age.text=[@"AGE : " stringByAppendingString:[self.emp valueForKey:@"age"]];
    _department.text=[@"DEPARTMENT : " stringByAppendingString:[self.emp valueForKey:@"department"]];
    _designation.text=[@"DESIGNATION : " stringByAppendingString:[self.emp valueForKey:@"designation"]];
    _tagLine.text=[@"TAG LINE : " stringByAppendingString:[self.emp valueForKey:@"tagLine"]];
    
    _picLabel=[self.emp valueForKey:@"image"];
    _imageView.image=[self loadImage:_picLabel];
    
    
 
}

float oldX;




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

- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer{
    
    [self.view endEditing:YES];
}

// Dismiss keyboard on return

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0  ||  scrollView.contentOffset.x < 0 )
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
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
