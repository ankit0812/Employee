//
//  ViewController.m
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [self.scrolls addGestureRecognizer:yourTap];
    [self.view addSubview:_scrolls];
    [self.scrolls setScrollEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addNewRecords:(id)sender{
    
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
    
}
- (IBAction)browseRecords:(id)sender{
    
    [self performSegueWithIdentifier:@"browse" sender:self];
    
}
- (IBAction)searchRecords:(id)sender{
    
    [self performSegueWithIdentifier:@"search" sender:self];

}

- (void)scrollTap:(UIGestureRecognizer*)gestureRecognizer {
    
    //make keyboard disappear , you can use resignFirstResponder too, it's depend.
    [self.view endEditing:YES];
}
@end
