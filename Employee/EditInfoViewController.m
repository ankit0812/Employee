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
    // Do any additional setup after loading the view.
    
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
   [_scroller setScrollEnabled:YES];
}

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



- (IBAction)browsePic:(id)sender {
    
    [self.view endEditing:YES];
    //To select the image from gallery. This wil open up the gallery.
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
    
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

- (void)imagePickerController:(UIImagePickerController *)photoPicker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageView setImage:selectedImage];
    
    [photoPicker dismissModalViewControllerAnimated:YES];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{               //This will dismiss keyboard when user touches any where in the view
    [self.scroller endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
