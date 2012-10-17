//
//  MasterViewController.h
//  Lista de la compra
//
//  Created by Xavier Forns Carreras on 13/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GCDAsyncUdpSocket;


@interface MasterViewController : UIViewController <UITableViewDelegate> {
    
    GCDAsyncUdpSocket *udpSocket;
    NSMutableArray *actions;
}

@property (nonatomic,strong) IBOutlet UITableView *table;

- (IBAction)addAction:(id)sender;
- (IBAction)setEditMode:(id)sender;
- (IBAction)editAction:(id)sender;
- (IBAction)optionsAction:(id)sender;

@end
