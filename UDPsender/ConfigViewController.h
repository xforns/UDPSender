//
//  ConfigViewController.h
//  jmbirzday
//
//  Created by Xavier Forns Carreras on 14/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConfigViewController : UIViewController <UITextFieldDelegate> {
}

@property (nonatomic,strong) IBOutlet UITextField *tfip;
@property (nonatomic,strong) IBOutlet UITextField *tfport;

- (IBAction)backAction:(id)sender;


@end
