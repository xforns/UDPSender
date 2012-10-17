//
//  MasterViewController.m
//  cic
//
//  Created by Xavier Forns Carreras on 10/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "ConfigViewController.h"
#import "ActionViewController.h"
#import "GCDAsyncUdpSocket.h"
#import "GCDAsyncUdpSocket+sendString.h"


@implementation MasterViewController


@synthesize table;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void)viewWillAppear:(BOOL)animated {
    
    // Navigationbar
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:71.f/255.f green:133.f/255.f blue:127.f/255.f alpha:1.f]];
    [self.navigationController.navigationBar.topItem setTitle:@"Actions"];
    
    // Toolbar
    [self.navigationController setToolbarHidden:NO];
    [self.navigationController.toolbar setTintColor:[UIColor colorWithRed:71.f/255.f green:133.f/255.f blue:127.f/255.f alpha:1.f]];
    UIBarButtonItem *optionsBut = [[UIBarButtonItem alloc] initWithTitle:@"Options" style:UIBarButtonItemStyleBordered target:self action:@selector(optionsAction:)];
    UIBarButtonItem *editBut = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(setEditMode:)];
    UIBarButtonItem *addBut = [[UIBarButtonItem alloc] initWithTitle:@"Add action" style:UIBarButtonItemStyleBordered target:self action:@selector(addAction:)];
    [self setToolbarItems:[NSArray arrayWithObjects:optionsBut,editBut,addBut,nil]];
    
    // Grab actions
    [self readActions];
    
    // Initialize socket
    if(udpSocket)
        udpSocket = nil;
    udpSocket = [GCDAsyncUdpSocket initSocket];
}


- (void)viewWillDisappear:(BOOL)animated {
    [udpSocket close];
}


- (void)readActions {
    if(actions)
        actions = nil;
    
    actions = [[NSMutableArray alloc] init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDictionary *dactions = [prefs dictionaryForKey:@"actions"];
    NSEnumerator *denum = [dactions keyEnumerator];
    NSString *key;
    while((key=[denum nextObject])) {
        NSMutableDictionary *foo = [[NSMutableDictionary alloc] init];
        NSString *val = [dactions objectForKey:key];
        [foo setObject:val forKey:key];
        [actions addObject:foo];
    }
    
    [table reloadData];
}


- (IBAction)optionsAction:(id)sender {
    // Show a modal with configuration options
    ConfigViewController *confvc = [[ConfigViewController alloc] initWithNibName:@"ConfigViewController" bundle:nil];
    [self presentModalViewController:confvc animated:YES];
}


- (IBAction)setEditMode:(id)sender {
    // Set editing mode
    if(![table isEditing]) {
        [table setEditing:YES animated: YES];
        [(UIBarButtonItem *)[self.toolbarItems objectAtIndex:1] setTitle:@"Done"];
    }
    else {
        [table setEditing:NO animated: YES];
        [(UIBarButtonItem *)[self.toolbarItems objectAtIndex:1] setTitle:@"Edit"];
    }
}


- (IBAction)addAction:(id)sender {
    // Add a new action
    ActionViewController *actionvc = [[ActionViewController alloc] initWithNibName:@"ActionViewController" bundle:nil];
    [self.navigationController pushViewController:actionvc animated:YES];
}


- (IBAction)editAction:(id)sender {
    // Modify the current action (if will add a new action if the udp value is changed, since it's a key in the dictionary)
    ActionViewController *actionvc = [[ActionViewController alloc] initWithNibName:@"ActionViewController" bundle:nil];
    NSMutableDictionary *foo = [actions objectAtIndex:((UIButton *)sender).tag];
    NSEnumerator *denum = [foo keyEnumerator];
    actionvc.key = [denum nextObject];
    [self.navigationController pushViewController:actionvc animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [actions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cid];
        
        UIButton *editBut = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [editBut setFrame:CGRectMake(cell.frame.size.width-editBut.frame.size.width-10,(cell.frame.size.height-editBut.frame.size.height)/2,editBut.frame.size.width,editBut.frame.size.height)];
        [editBut setTitle:@"Edit" forState:UIControlStateNormal];
        [editBut setTag:indexPath.row];
        [editBut addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:editBut];
    }
    
    NSMutableDictionary *foo = [actions objectAtIndex:indexPath.row];
    NSEnumerator *denum = [foo keyEnumerator];
    NSString *key = [denum nextObject];
    NSString *val = [foo objectForKey:key];
    
    cell.textLabel.text = val;
    cell.detailTextLabel.text = key;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Delete an action
    if(editingStyle==UITableViewCellEditingStyleDelete) {
        [actions removeObjectAtIndex:indexPath.row];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dactions = [[NSMutableDictionary alloc] init];
        for(int i=0;i<[actions count];i++) {
            NSDictionary *foo = [actions objectAtIndex:0];
            NSEnumerator *denum = [foo keyEnumerator];
            NSString *key = [denum nextObject];
            NSString *val = [foo objectForKey:key];
            [dactions setObject:key forKey:val];
        }
        [prefs setObject:dactions forKey:@"actions"];
        
        [table reloadData];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *foo = [actions objectAtIndex:indexPath.row];
    NSEnumerator *denum = [foo keyEnumerator];
    NSString *key = [denum nextObject];
    [GCDAsyncUdpSocket sendString:key toSocket:udpSocket];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
