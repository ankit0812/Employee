//
//  EditInfoViewController.h
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoViewController : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *empID;

@property (weak, nonatomic) IBOutlet UITextField *firstName;

@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *age;

@property (weak, nonatomic) IBOutlet UITextField *department;

@property (weak, nonatomic) IBOutlet UITextField *designation;
@property (weak, nonatomic) IBOutlet UITextField *tagLine;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)takePic:(id)sender;

- (IBAction)browsePic:(id)sender;

- (IBAction)saveInfo:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;


@end
