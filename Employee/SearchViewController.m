//
//  SearchViewController.m
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "SearchViewController.h"
#import <CoreData/CoreData.h>
#import "DetailViewController.h"
@interface SearchViewController ()
{
    NSArray *matchData;
}
@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)search:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *desc=[NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
    NSFetchRequest *fetch=[[NSFetchRequest alloc]init];
    
    [fetch setEntity:desc];
    if(![_empIDText.text isEqual:@""]){
        NSPredicate *pred=[NSPredicate predicateWithFormat:@"empId like %@",_empIDText.text];
        [fetch setPredicate:pred];
        NSError *error;
        matchData=[context executeFetchRequest:fetch error:&error];
        
        if(matchData.count<=0){
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Record Not Found"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [message show];
            
        } else{
            [self performSegueWithIdentifier:@"do" sender:self];
            
        }
    }   //This will take search key as Name And Designation
    else if ((![_firstNameText.text isEqual:@""]) && ([_designationText.text isEqual:@""])){
        NSPredicate *pred=[NSPredicate predicateWithFormat:@"firstName like %@ and designation like %@",
                           _firstNameText.text,_designationText.text];
        [fetch setPredicate:pred];
        NSError *error;
        matchData=[context executeFetchRequest:fetch error:&error];
        
        if(matchData.count<=0){
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Record Not Found"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [message show];

            } else{
            [self performSegueWithIdentifier:@"do" sender:self];
                
           
            }
    
    }
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message"
                                                          message:@"Invalid Combination"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];

        }
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"do"]){
        
        DetailViewController *dest=segue.destinationViewController;
        for(NSManagedObject *obj in matchData){
            dest.emp=obj;
        }
        
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{               //This will dismiss keyboard when user touches any where in the view
    [self.view endEditing:YES];
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
