//
//  BrowseViewController.m
//  Employee
//
//  Created by optimusmac4 on 8/4/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "BrowseViewController.h"
#import "DetailViewController.h"
#import <CoreData/CoreData.h>
@interface BrowseViewController ()

@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    self.emp = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];                 // Obtaining all the entries of persistance store to show in Table view
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.emp.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];            //Creating object of TabelView to access each row and obtain data
    
    NSManagedObject *empp = [self.emp objectAtIndex:indexPath.row]; //obtaining the informatio of selected row in empp object
    
    /*
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [empp valueForKey:@"firstName"]]];
    [cell.detailTextLabel setText:[empp valueForKey:@"empId"]];     //Accessing and using the name and empId to show in tabelView
    */
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [empp valueForKey:@"firstName"]];
    
    cell.detailTextLabel.text =[empp valueForKey:@"empId"];
    return cell;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{                           //Segue which is called when user selects any row, and this segue modifies the value of emp object of BrowseClickViewController with the clicked row details.
    if ([segue.identifier isEqualToString:@"recordClick"]){
        NSManagedObject *selectedEmp = [self.emp objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        BrowseViewController *destViewController = segue.destinationViewController;
        destViewController.emp = selectedEmp;
    }
}

/*

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
