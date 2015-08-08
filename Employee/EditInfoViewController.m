//
//  EditInfoViewController.m
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "EditInfoViewController.h"
#import <UIKit/UIView.h>
#import <CoreData/CoreData.h>

@interface EditInfoViewController ()

@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.empID.delegate = self;
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.age.delegate = self;
    self.designation.delegate = self;
    self.department.delegate = self;
    self.tagLine.delegate = self;
    
    
    _scroller.delegate=self;
    [_scroller setShowsHorizontalScrollIndicator:NO];
    
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [self.scroller addGestureRecognizer:yourTap];
    [self.view addSubview:_scroller];
    [self.scroller setScrollEnabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    
    
   
    // Do any additional setup after loading the view.
    
    
    //Log Directory Path
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
   
}

float oldX; // here or better in .h interface

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSManagedObjectContext *)managedObjectContext {          //This allows us to get the managed object context from the AppDelegate
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)takePic:(id)sender {
    
    [self.view endEditing:YES];
  
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device has no camera" delegate:nil                                                                                                                                                                                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [myAlertView show];
        
    } else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}



- (IBAction)browsePic:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
        
    [self presentViewController:picker animated:YES completion:NULL];
    

    
}


- (IBAction)saveInfo:(id)sender{
    [self.view endEditing:YES];
    
    if(_empID.text==nil || _firstName.text==nil || _lastName.text==nil|| _age.text==nil || _designation.text==nil || _department.text==nil || _tagLine.text==nil){
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                          message:@"Please Fill all the entries. Then Click Save"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        
    } else{
        
        
        
        
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *newEmp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context]; // create a new managedd object to take the input -- Employee Here referes to the entity name
        //taking input from textfields to set the attributes
        
        [newEmp setValue:self.empID.text forKey:@"empId"];
        [newEmp setValue:self.firstName.text forKey:@"firstName"];
        [newEmp setValue:self.lastName.text forKey:@"lastName"];
        [newEmp setValue:self.age.text forKey:@"age"];
        [newEmp setValue:self.designation.text forKey:@"designation"];
        [newEmp setValue:self.department.text forKey:@"department"];
        [newEmp setValue:self.tagLine.text forKey:@"tagLine"];
        NSString *picName=self.empID.text;
        NSString *nameWithExt=[picName stringByAppendingString:@".jpg"];
        
        [newEmp setValue:nameWithExt forKey:@"image"];
        
        [self saveImage:_imageView imgName:nameWithExt];
        
        NSError *error = nil;
        
        if (![context save:&error]) {           //saving the data to persistance store
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Record Save Unsuccessful"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [message show];
            
        }    else{
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Record Saved Successfully"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [message show];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

// Cancel choosing images

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)saveImage: (UIImageView *)imageView imgName:(NSString *)name{
    if (imageView != nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          name];
        UIImage *img=imageView.image;
        
        NSData* data = UIImagePNGRepresentation(img);
        
        [data writeToFile:path atomically:YES];
    } else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                          message:@"Please Select an Image to proceed"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        
    }
}
- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer{
    
    [self.view endEditing:YES];
}

// Dismiss keyboard on return

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

#pragma - Deals with adjusting the keyboard with the screen show that if a text box is selected keyboard moves down

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
    
    
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    CGPoint scrollPoint;
    
    if (!CGRectContainsPoint(aRect, _lastName.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _lastName.frame.origin.y - (keyboardSize.height));
    }
    else if ( !CGRectContainsPoint(aRect, _age.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _age.frame.origin.y - (keyboardSize.height));
    }
    else if (  !CGRectContainsPoint(aRect, _department.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _department.frame.origin.y - (keyboardSize.height));
    }
    else if (!CGRectContainsPoint(aRect, _designation.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _designation.frame.origin.y - (keyboardSize.height));
    }
    else if (!CGRectContainsPoint(aRect, _tagLine.frame.origin))
    {
        
        scrollPoint = CGPointMake(0.0, _tagLine.frame.origin.y - (keyboardSize.height));
    }
    
    
    [_scroller setContentOffset:scrollPoint animated:YES];
    
    //_scroller.contentOffset = CGPointMake(0, [_scroller convertPoint:CGPointZero fromView:textField].y - 60);
    
    
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0  ||  scrollView.contentOffset.x < 0 )
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

@end
