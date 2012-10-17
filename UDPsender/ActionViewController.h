//
//  ActionViewController.h
//  jmbirzday
//
//  Created by Xavier Forns Carreras on 14/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) IBOutlet UITextField *tfname;
@property (nonatomic,strong) IBOutlet UITextField *tfvalue;

@end
