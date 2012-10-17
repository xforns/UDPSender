//
//  ConfigViewController.m
//  jmbirzday
//
//  Created by Xavier Forns Carreras on 14/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"
#import "GCDAsyncUdpSocket.h"
#import "GCDAsyncUdpSocket+sendString.h"


@implementation ConfigViewController


@synthesize tfip;
@synthesize tfport;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [super viewWillAppear:animated];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    tfip.text = [prefs stringForKey:@"host"];
    tfport.text = [NSString stringWithFormat:@"%d",[prefs integerForKey:@"port"]];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self textFieldDidEndEditing:textField];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [tfip resignFirstResponder];
    [tfport resignFirstResponder];
}


- (IBAction)backAction:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:tfip.text forKey:@"host"];
    [prefs setInteger:[tfport.text intValue] forKey:@"port"];
    [prefs setInteger:0 forKey:@"tag"];
    [prefs synchronize];
    
    [self dismissModalViewControllerAnimated:YES];
}


@end
