//
//  AnimalDetailsViewController.h
//  PetAdoption
//
//  Created by Andrew Kozlik on 10/6/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AnimalDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) PFObject *animal;

@end
