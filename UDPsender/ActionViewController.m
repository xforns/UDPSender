//
//  ActionViewController.m
//  jmbirzday
//
//  Created by Xavier Forns Carreras on 14/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActionViewController.h"


@implementation ActionViewController

@synthesize key;
@synthesize tfname;
@synthesize tfvalue;


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
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:71.f/255.f green:133.f/255.f blue:127.f/255.f alpha:1.f]];
    
    tfname.tag = 101;
    tfvalue.tag = 202;
    
    if(![key isEqualToString:@""]) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSDictionary *dactions = [prefs dictionaryForKey:@"actions"];
        NSEnumerator *denum = [dactions keyEnumerator];
        NSString *dkey;
        while((dkey=[denum nextObject])) {
            if([dkey isEqualToString:key]) {
                NSString *val = [dactions objectForKey:dkey];
                tfname.text = val;
                tfvalue.text = key;
            }
        }
    }
    
}


- (void)viewWillDisappear:(BOOL)animated {
    if(!([tfname.text isEqualToString:@""]) && (![tfvalue.text isEqualToString:@""])) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSDictionary *dactions = [prefs dictionaryForKey:@"actions"];
        NSMutableDictionary *copyactions = [dactions mutableCopy];
        if(copyactions==nil)
            copyactions = [[NSMutableDictionary alloc] init];
        [copyactions setObject:tfname.text forKey:tfvalue.text];
        [prefs setObject:copyactions forKey:@"actions"];
    }
    [super viewWillDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5f animations:^(void) {
        self.view.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y-100,self.view.frame.size.width, self.view.frame.size.height);
    }];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [tfname resignFirstResponder];
    [tfvalue resignFirstResponder];
    
    [UIView animateWithDuration:0.5f animations:^(void) {
        self.view.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y+100,self.view.frame.size.width, self.view.frame.size.height);
    }];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [tfname resignFirstResponder];
    [tfvalue resignFirstResponder];
}


@end
